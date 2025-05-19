/* codegen.h */
#ifndef CODEGEN_H
#define CODEGEN_H

#include "ast.h"

typedef enum {
    OP_PUSH_INT,
    OP_LOAD_VAR,
    OP_STORE_VAR,
    OP_ADD,
    OP_SUB,
    OP_MUL,
    OP_DIV,
    OP_EQ,
    OP_NE,
    OP_LT,
    OP_GT,
    OP_LE,
    OP_GE,
    OP_IMPORT_DATA,
    OP_MELHORA,
    OP_LER_SENSOR,
    OP_CALC_CONSULTAS,
    OP_PRINT,
    OP_PAUSE_OP,
    OP_REGISTER_OP,
    OP_JMP_IF_FALSE,
    OP_JMP,
    OP_HALT
} OpCode;

typedef struct {
    OpCode op;
    int    arg;
    char  *sarg;
} Instr;

typedef struct {
    Instr *data;
    int    size, capacity;
} InstrArray;

void cg_init(InstrArray *ia);
void cg_emit(InstrArray *ia, OpCode op, int arg);
void cg_emit_str(InstrArray *ia, OpCode op, const char *s);
void generate(AST *root, InstrArray *ia);

#endif
