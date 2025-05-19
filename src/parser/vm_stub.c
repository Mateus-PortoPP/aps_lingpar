/* vm_stub.c */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "codegen.h"
#include "ast.h"

#define STACK_MAX 1024

static int    stack[STACK_MAX], sp = 0;
static int   *vars = NULL;
static char **var_names = NULL;
static int    var_count = 0;

static char  **headers = NULL;
static double **data    = NULL;
static int      n_rows  = 0;
static int      n_cols  = 0;

void push(int v) { stack[sp++] = v; }
int  pop(void)   { return stack[--sp]; }

/* Retorna índice da variável, criando-a se necessário */
static int var_index(const char *name) {
    for (int i = 0; i < var_count; i++)
        if (strcmp(var_names[i], name) == 0) return i;
    var_names = realloc(var_names, sizeof(char*) * (var_count + 1));
    vars      = realloc(vars,      sizeof(int)    * (var_count + 1));
    var_names[var_count] = strdup(name);
    vars[var_count]      = 0;
    return var_count++;
}

/* Importa CSV, guarda em headers[] e data[][] */
void import_data(const char *path) {
    FILE *f = fopen(path, "r");
    if (!f) { perror("importar_dados"); exit(1); }

    char *line = NULL; size_t len = 0;
    if (getline(&line, &len, f) <= 0) {
        free(line);
        fclose(f);
        return;
    }

    /* conta colunas */
    int cols = 1;
    for (char *p = line; *p; p++) if (*p == ',') cols++;
    n_cols  = cols;
    headers = malloc(sizeof(char*) * n_cols);

    /* lê cabeçalho */
    int c = 0;
    char *tok = strtok(line, ",\n");
    while (tok && c < n_cols) {
        headers[c++] = strdup(tok);
        tok = strtok(NULL, ",\n");
    }
    free(line);

    /* lê dados */
    while (1) {
        ssize_t rd = getline(&line, &len, f);
        if (rd <= 0) break;
        data = realloc(data, sizeof(double*) * (n_rows + 1));
        data[n_rows] = malloc(sizeof(double) * n_cols);
        c = 0;
        tok = strtok(line, ",\n");
        while (tok && c < n_cols) {
            data[n_rows][c++] = atof(tok);
            tok = strtok(NULL, ",\n");
        }
        n_rows++;
    }
    free(line);
    fclose(f);
}

/* Retorna média simples do sensor */
int ler_sensor_vm(const char *sensor) {
    int idx = -1;
    for (int i = 0; i < n_cols; i++)
        if (strcmp(headers[i], sensor) == 0) { idx = i; break; }
    if (idx < 0) {
        fprintf(stderr, "sensor '%s' nao existe\n", sensor);
        return 0;
    }
    double sum = 0;
    for (int r = 0; r < n_rows; r++) sum += data[r][idx];
    return (int)(sum / n_rows);
}

/* Soma os últimos nargs valores da pilha */
int calcular_consultas_vm(int nargs) {
    int acc = 0;
    while (nargs--) acc += pop();
    return acc;
}

/* Executa o bytecode gerado */
void run_vm(InstrArray *ia) {
    int ip = 0;
    while (1) {
        Instr in = ia->data[ip++];
        switch (in.op) {
        case OP_PUSH_INT:
            push(in.arg);
            break;
        case OP_LOAD_VAR: {
            int idx = var_index(in.sarg);
            push(vars[idx]);
            break;
        }
        case OP_STORE_VAR: {
            int idx = var_index(in.sarg);
            vars[idx] = pop();
            break;
        }
        case OP_ADD:
            push(pop() + pop());
            break;
        case OP_SUB: {
            int b = pop(), a = pop();
            push(a - b);
            break;
        }
        case OP_MUL:
            push(pop() * pop());
            break;
        case OP_DIV: {
            int b = pop(), a = pop();
            push(a / b);
            break;
        }
        case OP_EQ:
            push(pop() == pop());
            break;
        case OP_NE:
            push(pop() != pop());
            break;
        case OP_LT: {
            int b = pop(), a = pop();
            push(a < b);
            break;
        }
        case OP_GT: {
            int b = pop(), a = pop();
            push(a > b);
            break;
        }
        case OP_LE: {
            int b = pop(), a = pop();
            push(a <= b);
            break;
        }
        case OP_GE: {
            int b = pop(), a = pop();
            push(a >= b);
            break;
        }
        case OP_IMPORT_DATA:
            import_data(in.sarg);
            break;
        case OP_MELHORA:
            push(rand() % 101);
            break;
        case OP_LER_SENSOR:
            push(ler_sensor_vm(in.sarg));
            break;
        case OP_CALC_CONSULTAS:
            push(calcular_consultas_vm(in.arg));
            break;
        case OP_PRINT:
            printf("%d\n", pop());
            break;
        case OP_PAUSE_OP:
            pop();
            break;
        case OP_REGISTER_OP: {
            int v2 = pop(), v1 = pop();
            printf("[REG] %d, %d\n", v1, v2);
            break;
        }
        case OP_JMP_IF_FALSE: {
            int cond = pop();
            if (!cond) ip = in.arg;
            break;
        }
        case OP_JMP:
            ip = in.arg;
            break;
        case OP_HALT:
            return;
        default:
            fprintf(stderr, "VM: opcode desconhecido %d\n", in.op);
            return;
        }
    }
}

/* Libera toda a memória alocada pela VM */
static void cleanup_vm(void) {
    for (int i = 0; i < var_count; i++) free(var_names[i]);
    free(var_names);
    free(vars);

    for (int i = 0; i < n_cols; i++) free(headers[i]);
    free(headers);

    for (int r = 0; r < n_rows; r++) free(data[r]);
    free(data);
}

extern AST *parse_file(const char *path);

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s arquivo.fsl\n", argv[0]);
        return 1;
    }
    srand((unsigned)time(NULL));

    /* Parse + geração de bytecode */
    AST         *ast = parse_file(argv[1]);
    InstrArray   ia;
    generate(ast, &ia);

    /* Execução */
    run_vm(&ia);

    /* Limpeza geral */
    free_ast(ast);
    cleanup_vm();

    return 0;
}
