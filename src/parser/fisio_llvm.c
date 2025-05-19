#include <stdio.h>
#include <stdlib.h>
#include "ast.h"
#include "codegen.h"


extern AST *parse_file(const char *path);

extern void run_vm(InstrArray *ia);

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s arquivo.fsl\n", argv[0]);
        return 1;
    }

    
    AST *ast = parse_file(argv[1]);

   
    InstrArray ia;
    generate(ast, &ia);

    /* 3) Executar na VM */
    run_vm(&ia);

    
    free_ast(ast);
    free(ia.data);
    return 0;
}
