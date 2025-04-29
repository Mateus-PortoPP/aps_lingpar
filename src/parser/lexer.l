%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"

// Para copiar o identificador para yylval
void copy_id() {
    strcpy(yylval.id, yytext);
}
%}

%option noyywrap

%%

[ \t\n]+        ; /* Ignora espaços em branco */
"sessao"        { return SESSAO; }
"fim_sessao"    { return FIM_SESSAO; }
"resultado"     { return RESULTADO; }
"="             { return ASSIGN; }
";"             { return ';'; }
"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }

[0-9]+          { 
                  yylval.num = atoi(yytext); 
                  return NUM; 
                }

[a-zA-Z][a-zA-Z0-9_]*  { 
                  strcpy(yylval.id, yytext);
                  return ID; 
                }

.               { printf("Caractere não reconhecido: %c\n", *yytext); }

%%

int yywrap() {
    return 1;
}
