%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
%}

/* Valores possíveis para yylval */
%union {
  int int_val;
  int bool_val;
  char *str_val;
  char *id;
}

/* Tokens */
%token SESSAO FIM_SESSAO PACIENTE IMPORTAR_DADOS SE MELHOROU CASO CONTRARIO
%token TREINO PRACTICAR_ATE RESULTADO PAUSA REGISTRAR
%token <int_val> INTEGER
%token <bool_val> BOOL
%token <str_val> STRING
%token <id> IDENTIFIER
%token EQ NEQ LT LTE GT GTE AND OR NOT
%token PLUS MINUS MULT DIV ASSIGN
%token SEMICOLON COMMA LPAREN RPAREN LBRACE RBRACE

%start program

%%

program:
    SESSAO block FIM_SESSAO
      { puts("Programa FisioLang analisado com sucesso."); }
  ;

block:
    LBRACE statements RBRACE
  ;

statements:
    /* vazio */
  | statements statement
  ;

statement:
    paciente_stmt
  | importar_stmt
  | IDENTIFIER ASSIGN expression SEMICOLON     /* atribuição implícita */
  | if_stmt
  | loop_stmt
  | print_stmt
  | pause_stmt
  | registrar_stmt
  | SEMICOLON
  ;

paciente_stmt:
    PACIENTE LBRACE paciente_info_list RBRACE
  ;

paciente_info_list:
    /* vazio */
  | paciente_info_list IDENTIFIER ASSIGN expression SEMICOLON
  ;

importar_stmt:
    IMPORTAR_DADOS LPAREN STRING RPAREN SEMICOLON
  ;

if_stmt:
    SE MELHOROU LPAREN expression RPAREN block
  | SE MELHOROU LPAREN expression RPAREN block CASO CONTRARIO block
  ;

loop_stmt:
    TREINO LPAREN expression RPAREN block
  | PRACTICAR_ATE LPAREN expression RPAREN block
  ;

print_stmt:
    RESULTADO LPAREN expression RPAREN SEMICOLON
  ;

pause_stmt:
    PAUSA LPAREN expression RPAREN SEMICOLON
  ;

registrar_stmt:
    REGISTRAR LPAREN expression COMMA expression RPAREN SEMICOLON
  ;

/* Expressões aritméticas e lógicas */
expression:
    additive_expr
  ;

additive_expr:
    multiplicative_expr
  | additive_expr PLUS multiplicative_expr
  | additive_expr MINUS multiplicative_expr
  ;

multiplicative_expr:
    unary_expr
  | multiplicative_expr MULT unary_expr
  | multiplicative_expr DIV unary_expr
  ;

unary_expr:
    primary
  | NOT unary_expr
  | PLUS unary_expr
  | MINUS unary_expr
  ;

primary:
    INTEGER
  | BOOL
  | STRING
  | IDENTIFIER
  | LPAREN expression RPAREN
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe: %s\\n", s);
}

int main(void) {
    return yyparse();
}
