/* codegen.c */
#include <stdlib.h>
#include <string.h>
#include "codegen.h"

static void cg_node(AST *n, InstrArray *ia);
static void cg_stmt(AST *n, InstrArray *ia);

void cg_init(InstrArray *ia) {
    ia->size     = 0;
    ia->capacity = 128;
    ia->data     = malloc(sizeof(Instr) * ia->capacity);
}

void cg_emit(InstrArray *ia, OpCode op, int arg) {
    if (ia->size >= ia->capacity) {
        ia->capacity *= 2;
        ia->data = realloc(ia->data, sizeof(Instr) * ia->capacity);
    }
    ia->data[ia->size++] = (Instr){op, arg, NULL};
}

void cg_emit_str(InstrArray *ia, OpCode op, const char *s) {
    if (ia->size >= ia->capacity) {
        ia->capacity *= 2;
        ia->data = realloc(ia->data, sizeof(Instr) * ia->capacity);
    }
    ia->data[ia->size++] = (Instr){op, 0, strdup(s)};
}

static void cg_node(AST *n, InstrArray *ia) {
    switch (n->type) {
    case NODE_EXPR_INT:
        cg_emit(ia, OP_PUSH_INT, n->intval);
        break;
    case NODE_EXPR_VAR:
        cg_emit_str(ia, OP_LOAD_VAR, n->text);
        break;
    case NODE_EXPR_BINOP:
        cg_node(n->children[0], ia);
        cg_node(n->children[1], ia);
        switch (n->op) {
        case AST_OP_ADD: cg_emit(ia, OP_ADD,  0); break;
        case AST_OP_SUB: cg_emit(ia, OP_SUB,  0); break;
        case AST_OP_MUL: cg_emit(ia, OP_MUL,  0); break;
        case AST_OP_DIV: cg_emit(ia, OP_DIV,  0); break;
        case AST_OP_EQ:  cg_emit(ia, OP_EQ,   0); break;
        case AST_OP_NE:  cg_emit(ia, OP_NE,   0); break;
        case AST_OP_LT:  cg_emit(ia, OP_LT,   0); break;
        case AST_OP_GT:  cg_emit(ia, OP_GT,   0); break;
        case AST_OP_LE:  cg_emit(ia, OP_LE,   0); break;
        case AST_OP_GE:  cg_emit(ia, OP_GE,   0); break;
        default: break;
        }
        break;
    case NODE_MELHORA:
        cg_emit(ia, OP_MELHORA, 0);
        break;
    case NODE_LER_SENSOR:
        cg_emit_str(ia, OP_LER_SENSOR, n->text);
        break;
    case NODE_CALC_CONSULTAS:
        for (int i = 0; i < n->n_children; i++)
            cg_node(n->children[i], ia);
        cg_emit(ia, OP_CALC_CONSULTAS, n->n_children);
        break;
    default:
        break;
    }
}

static void cg_stmt(AST *n, InstrArray *ia) {
    switch (n->type) {
    case NODE_IMPORT_DATA:
        cg_emit_str(ia, OP_IMPORT_DATA, n->text);
        break;
    case NODE_ASSIGN:
        cg_node(n->children[0], ia);
        cg_emit_str(ia, OP_STORE_VAR, n->text);
        break;
    case NODE_PRINT:
        cg_node(n->children[0], ia);
        cg_emit(ia, OP_PRINT, 0);
        break;
    case NODE_PAUSE:
        cg_node(n->children[0], ia);
        cg_emit(ia, OP_PAUSE_OP, 0);
        break;
    case NODE_REGISTER:
        cg_node(n->children[0], ia);
        cg_node(n->children[1], ia);
        cg_emit(ia, OP_REGISTER_OP, 0);
        break;
    case NODE_IF: {
        cg_node(n->children[0], ia);
        int jz = ia->size; cg_emit(ia, OP_JMP_IF_FALSE, 0);
        cg_stmt(n->children[1], ia);
        if (n->n_children == 3) {
            int ja = ia->size; cg_emit(ia, OP_JMP, 0);
            ia->data[jz].arg = ia->size;
            cg_stmt(n->children[2], ia);
            ia->data[ja].arg = ia->size;
        } else {
            ia->data[jz].arg = ia->size;
        }
        break;
    }
    case NODE_LOOP_TREINO:
    case NODE_LOOP_PRACTICAR: {
        int start = ia->size;
        cg_node(n->children[0], ia);
        int jz = ia->size; cg_emit(ia, OP_JMP_IF_FALSE, 0);
        cg_stmt(n->children[1], ia);
        cg_emit(ia, OP_JMP, start);
        ia->data[jz].arg = ia->size;
        break;
    }
    case NODE_BLOCK:
        for (int i = 0; i < n->n_children; i++)
            cg_stmt(n->children[i], ia);
        break;
    default:
        break;
    }
}

void generate(AST *root, InstrArray *ia) {
    cg_init(ia);
    for (int i = 0; i < root->n_children; i++)
        cg_stmt(root->children[i], ia);
    cg_emit(ia, OP_HALT, 0);
}
