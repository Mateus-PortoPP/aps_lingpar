%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Funções do VM stub
extern void init_vm();
extern void set_variable(const char* name, int value);
extern int get_variable(const char* name);
extern void print_resultado(int value);
extern void print_resultado_var(const char* name);

int yylex();
void yyerror(const char *s);
extern FILE *yyin;
%}

%union {
    int num;
    char id[50];
}

%token SESSAO FIM_SESSAO
%token RESULTADO
%token <num> NUM
%token <id> ID
%token ASSIGN

%left '+' '-'
%left '*' '/'

%type <num> expr

%%

programa: SESSAO '{' statements '}' FIM_SESSAO
    {
        printf("Programa FisioLang analisado com sucesso.\n");
    }
    ;

statements: statements statement
    | statement
    ;

statement: ID ASSIGN expr ';'
    {
        set_variable($1, $3);
    }
    | RESULTADO '(' ID ')' ';'
    {
        print_resultado_var($3);
    }
    | RESULTADO '(' expr ')' ';'
    {
        print_resultado($3);
    }
    ;

expr: NUM
    {
        $$ = $1;
    }
    | ID
    {
        $$ = get_variable($1);
    }
    | expr '+' expr
    {
        $$ = $1 + $3;
    }
    | expr '-' expr
    {
        $$ = $1 - $3;
    }
    | expr '*' expr
    {
        $$ = $1 * $3;
    }
    | expr '/' expr
    {
        if ($3 == 0) {
            yyerror("Divisão por zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | '(' expr ')'
    {
        $$ = $2;
    }
    ;

%%

int main(int argc, char *argv[]) {
    // Inicializar a VM
    init_vm();
    
    // Se um arquivo foi especificado como argumento
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Não foi possível abrir o arquivo %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    
    // Analisar a entrada
    yyparse();
    
    // Fechar o arquivo se foi aberto
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro de análise: %s\n", s);
}
