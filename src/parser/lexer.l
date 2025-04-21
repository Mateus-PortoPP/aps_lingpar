%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%
"sessao"           return SESSAO;
"fim_sessao"       return FIM_SESSAO;
"paciente"         return PACIENTE;
"importar_dados"   return IMPORTAR_DADOS;
"se"               return SE;
"melhorou"         return MELHOROU;
"caso"             return CASO;
"contrario"        return CONTRARIO;
"treino"           return TREINO;
"praticar_ate"     return PRACTICAR_ATE;
"resultado"        return RESULTADO;
"pausa"            return PAUSA;
"registrar"        return REGISTRAR;

"true"             { yylval.bool_val = 1; return BOOL; }
"false"            { yylval.bool_val = 0; return BOOL; }

[0-9]+              { yylval.int_val = atoi(yytext); return INTEGER; }
\"([^\\"]|\\.)*\"   {
                      yylval.str_val = strdup(yytext+1);
                      yylval.str_val[strlen(yylval.str_val)-1] = '\0';
                      return STRING;
                   }
[a-zA-Z_][a-zA-Z0-9_]* {
                      yylval.id = strdup(yytext);
                      return IDENTIFIER;
                   }

"=="               return EQ;
"!="               return NEQ;
"<="               return LTE;
">="               return GTE;
"<"                return LT;
">"                return GT;
"&&"               return AND;
"||"               return OR;
"!"                return NOT;

"+"                return PLUS;
"-"                return MINUS;
"*"                return MULT;
"/"                return DIV;
"="                return ASSIGN;
";"                return SEMICOLON;
","                return COMMA;
"("                return LPAREN;
")"                return RPAREN;
"{"                return LBRACE;
"}"                return RBRACE;

[ \t\r\n]+         /* ignora espaços e quebras de linha */
.                  { fprintf(stderr, "Caractere inválido: %s\n", yytext); exit(1); }
%%
