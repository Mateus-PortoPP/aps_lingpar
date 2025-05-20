#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
#include "ast.h"

extern FILE *yyin;
extern int yylex(void);
extern char *yytext;

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s arquivo\n", argv[0]);
        return 1;
    }
    
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("fopen");
        return 1;
    }
    
    printf("Analisando tokens do arquivo %s:\n", argv[1]);
    
    int token;
    while ((token = yylex())) {
        printf("Token: %d, Texto: '%s'\n", token, yytext);
    }
    
    fclose(yyin);
    return 0;
}
