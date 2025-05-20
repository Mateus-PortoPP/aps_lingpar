
%{
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

extern int  yylex();
extern FILE *yyin;
extern int  yylineno;
AST *ast_root;

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe (linha %d): %s\n", yylineno, s);
    exit(1);
}
%}

%debug
%define parse.error verbose

%union {
    AST   *ast;
    int    intval;
    char  *str;
}

%token <str>    IDENTIFIER STRING
%token <intval> INTEGER

%token SESSAO FIM_SESSAO PACIENTE IMPORTAR SE MELHOROU CASO CONTRARIO
%token TREINO PRACTICAR RESULTADO PAUSA REGISTRAR LER_SENSOR CALCULAR
%token LE GE EQ NE AND OR

%type <ast> program block stmts stmt expr arg_list

%%

program:
      SESSAO block FIM_SESSAO  { ast_root = $2; }
    ;

block:
      '{' stmts '}'           { $$ = $2; }
    ;

stmts:
      /* vazio */             { $$ = new_node(NODE_BLOCK); }
    | stmts stmt              { ast_add_child($1,$2); $$ = $1; }
    ;

stmt:
      IDENTIFIER '=' expr ';' {
          AST *n = new_node(NODE_ASSIGN);
          n->text = $1;           /* pega ownership de $1 */
          ast_add_child(n,$3);
          $$ = n;
      }
    | PACIENTE '{' stmts '}'   {
          AST *n = new_node(NODE_PACIENTE);
          ast_add_child(n,$3);
          $$ = n;
      }
    | IMPORTAR '(' STRING ')' ';' {
          AST *n = new_node(NODE_IMPORT_DATA);
          n->text = $3;           /* ownstring */
          $$ = n;
      }
    | RESULTADO '(' expr ')' ';' {
          AST *n = new_node(NODE_PRINT);
          ast_add_child(n,$3);
          $$ = n;
      }
    | PAUSA '(' expr ')' ';'   {
          AST *n = new_node(NODE_PAUSE);
          ast_add_child(n,$3);
          $$ = n;
      }
    | REGISTRAR '(' expr ',' expr ')' ';' {
          AST *n = new_node(NODE_REGISTER);
          ast_add_child(n,$3);
          ast_add_child(n,$5);
          $$ = n;
      }
    | SE MELHOROU '(' expr ')' block CASO CONTRARIO block {
          AST *n = new_node(NODE_IF);
          ast_add_child(n,$4);
          ast_add_child(n,$6);
          ast_add_child(n,$9);
          $$ = n;
      }
    | SE MELHOROU '(' expr ')' block {
          AST *n = new_node(NODE_IF);
          ast_add_child(n,$4);
          ast_add_child(n,$6);
          $$ = n;
      }
    | TREINO '(' expr ')' block {
          AST *n = new_node(NODE_LOOP_TREINO);
          ast_add_child(n,$3); ast_add_child(n,$5);
          $$ = n;
      }
    | PRACTICAR '(' expr ')' block {
          AST *n = new_node(NODE_LOOP_PRACTICAR);
          ast_add_child(n,$3); ast_add_child(n,$5);
          $$ = n;
      }
    ;

expr:
      INTEGER                  { $$ = new_int_node($1); }
    | IDENTIFIER               {
          AST *n = new_node(NODE_EXPR_VAR);
          n->text = $1;         /* pega ownership de $1, sem duplicar */
          $$ = n;
      }
    | expr '+' expr            { $$ = new_binop_node(AST_OP_ADD, $1, $3); }
    | expr '-' expr            { $$ = new_binop_node(AST_OP_SUB, $1, $3); }
    | expr '*' expr            { $$ = new_binop_node(AST_OP_MUL, $1, $3); }
    | expr '/' expr            { $$ = new_binop_node(AST_OP_DIV, $1, $3); }
    | expr EQ expr             { $$ = new_binop_node(AST_OP_EQ,  $1, $3); }
    | expr NE expr             { $$ = new_binop_node(AST_OP_NE,  $1, $3); }
    | expr '<' expr            { $$ = new_binop_node(AST_OP_LT,  $1, $3); }
    | expr '>' expr            { $$ = new_binop_node(AST_OP_GT,  $1, $3); }
    | expr LE expr             { $$ = new_binop_node(AST_OP_LE,  $1, $3); }
    | expr GE expr             { $$ = new_binop_node(AST_OP_GE,  $1, $3); }
    | MELHOROU '(' ')'         { $$ = new_node(NODE_MELHORA); }
    | LER_SENSOR '(' STRING ')' {
          AST *n = new_node(NODE_LER_SENSOR);
          n->text = $3;
          $$ = n;
      }
    | CALCULAR '(' arg_list ')' {
          AST *n = new_node(NODE_CALC_CONSULTAS);
          for (int i = 0; i < $3->n_children; i++)
              ast_add_child(n, $3->children[i]);
          free($3->children);
          free($3);
          $$ = n;
      }
    | '(' expr ')'             { $$ = $2; }
    ;

arg_list:
      expr                     {
          AST *n = new_node(NODE_BLOCK);
          ast_add_child(n,$1);
          $$ = n;
      }
    | arg_list ',' expr        {
          ast_add_child($1,$3);
          $$ = $1;
      }
    ;

%%

AST *parse_file(const char *path) {
    yyin = fopen(path, "r");
    if (!yyin) { perror("fopen"); exit(1); }
    yyparse();
    fclose(yyin);
    return ast_root;
}
