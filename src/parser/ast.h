/* ast.h */
#ifndef AST_H
#define AST_H

typedef enum {
    NODE_BLOCK,
    NODE_ASSIGN,
    NODE_PACIENTE,
    NODE_IMPORT_DATA,
    NODE_PRINT,
    NODE_PAUSE,
    NODE_REGISTER,
    NODE_IF,
    NODE_LOOP_TREINO,
    NODE_LOOP_PRACTICAR,
    NODE_EXPR_INT,
    NODE_EXPR_VAR,
    NODE_EXPR_BINOP,
    NODE_MELHORA,
    NODE_LER_SENSOR,
    NODE_CALC_CONSULTAS
} NodeType;

typedef enum {
    AST_OP_ADD,
    AST_OP_SUB,
    AST_OP_MUL,
    AST_OP_DIV,
    AST_OP_EQ,
    AST_OP_NE,
    AST_OP_LT,
    AST_OP_GT,
    AST_OP_LE,
    AST_OP_GE
} AST_OpType;

typedef struct AST {
    NodeType    type;
    char       *text;
    int         intval;
    AST_OpType  op;
    struct AST **children;
    int         n_children;
} AST;

AST *new_node(NodeType t);
AST *new_int_node(int v);
AST *new_var_node(const char *name);
AST *new_binop_node(AST_OpType op, AST *l, AST *r);
void  ast_add_child(AST *parent, AST *child);
void  free_ast(AST *root);

#endif
