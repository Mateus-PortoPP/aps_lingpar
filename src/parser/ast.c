/* ast.c */
#include "ast.h"
#include <stdlib.h>
#include <string.h>

AST *new_node(NodeType t) {
    AST *n = calloc(1, sizeof(AST));
    n->type = t;
    return n;
}

AST *new_int_node(int v) {
    AST *n = new_node(NODE_EXPR_INT);
    n->intval = v;
    return n;
}

AST *new_var_node(const char *name) {
    AST *n = new_node(NODE_EXPR_VAR);
    n->text = strdup(name);
    return n;
}

AST *new_binop_node(AST_OpType op, AST *l, AST *r) {
    AST *n = new_node(NODE_EXPR_BINOP);
    n->op = op;
    ast_add_child(n, l);
    ast_add_child(n, r);
    return n;
}

void ast_add_child(AST *parent, AST *child) {
    parent->children = realloc(parent->children,
                              sizeof(AST*) * (parent->n_children + 1));
    parent->children[parent->n_children++] = child;
}

void free_ast(AST *root) {
    if (!root) return;
    for (int i = 0; i < root->n_children; i++)
        free_ast(root->children[i]);
    free(root->children);
    free(root->text);
    free(root);
}
