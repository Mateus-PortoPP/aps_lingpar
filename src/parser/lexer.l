/* lexer.l */
%{
#include "ast.h"           /* garantir AST definido antes de parser.tab.h */
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

DIGIT   [0-9]
LETTER  [a-zA-Z]
ID      {LETTER}({LETTER}|{DIGIT}|_)*
WS      [ \t\r\n]+

%%

"sessao"             { return SESSAO; }
"fim_sessao"         { return FIM_SESSAO; }
"paciente"           { return PACIENTE; }
"importar_dados"     { return IMPORTAR; }
"se"                 { return SE; }
"melhorou"           { return MELHOROU; }
"caso"               { return CASO; }
"contrario"          { return CONTRARIO; }
"treino"             { return TREINO; }
"praticar_ate"       { return PRACTICAR; }
"resultado"          { return RESULTADO; }
"pausa"              { return PAUSA; }
"registrar"          { return REGISTRAR; }
"ler_sensor"         { return LER_SENSOR; }
"calcular_consultas" { return CALCULAR; }

"<="                 { return LE; }
">="                 { return GE; }
"=="                 { return EQ; }
"!="                 { return NE; }
"&&"                 { return AND; }
"||"                 { return OR; }

{DIGIT}+             { yylval.intval = atoi(yytext);    return INTEGER; }
{ID}                 { yylval.str   = strdup(yytext); return IDENTIFIER; }

\"([^\"\\]|\\.)*\"   {
    int len = yyleng - 2;
    yylval.str = malloc(len + 1);
    strncpy(yylval.str, yytext+1, len);
    yylval.str[len] = '\0';
    return STRING;
}

{WS}+                { /* ignora espaços e quebras */ }

"<"                  { return '<'; }
">"                  { return '>'; }
"="                  { return '='; }
"+"                  { return '+'; }
"-"                  { return '-'; }
"*"                  { return '*'; }
"/"                  { return '/'; }
";"                  { return ';'; }
","                  { return ','; }
"{"                  { return '{'; }
"}"                  { return '}'; }
"("                  { return '('; }
")"                  { return ')'; }

.                    { return yytext[0]; }

%%

int yywrap(void) { return 1; }
