
%{
#include "ast.h"           
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
"melhora"            { return MELHOROU; } 

"="                  { return '='; }
"+"                  { return '+'; }
"-"                  { return '-'; }
"*"                  { return '*'; }
"/"                  { return '/'; }
";"                  { return ';'; }
"("                  { return '('; }
")"                  { return ')'; }
"{"                  { return '{'; }
"}"                  { return '}'; }
","                  { return ','; }

"<"                  { return '<'; }
">"                  { return '>'; }
"<="                 { return LE; }
">="                 { return GE; }
"=="                 { return EQ; }
"!="                 { return NE; }
"&&"                 { return AND; }
"||"                 { return OR; }

{ID}                 { yylval.str = strdup(yytext); return IDENTIFIER; }
{DIGIT}+             { yylval.intval = atoi(yytext); return INTEGER; }
\"[^\"]*\"           { 
                        char *s = strdup(yytext + 1); 
                        s[strlen(s) - 1] = '\0';
                        yylval.str = s;
                        return STRING;
                      }

{WS}                 { /* ignorar espaços */ }
\/\/[^\n]*           { /* ignorar comentários de linha */ }
\/\*([^*]|\*+[^*/])*\*+\/ { /* ignorar comentários em bloco */ }

.                    { fprintf(stderr, "Caractere inesperado: %c\n", *yytext); }

%%

int yywrap(void) { return 1; }
