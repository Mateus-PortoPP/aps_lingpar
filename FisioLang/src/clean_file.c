#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Uso: %s arquivo_entrada arquivo_saida\n", argv[0]);
        return 1;
    }
    
    FILE *in = fopen(argv[1], "rb");
    if (!in) {
        perror("fopen(entrada)");
        return 1;
    }
    
    FILE *out = fopen(argv[2], "wb");
    if (!out) {
        perror("fopen(saida)");
        fclose(in);
        return 1;
    }
    
    // Lê o arquivo byte a byte, ignorando BOM e outros caracteres invisíveis
    int c;
    // Ignorar BOM se existir (EF BB BF para UTF-8)
    if ((c = fgetc(in)) == 0xEF) {
        int b2 = fgetc(in);
        int b3 = fgetc(in);
        if (b2 == 0xBB && b3 == 0xBF) {
            printf("BOM UTF-8 detectado e removido.\n");
        } else {
            // Se não for BOM, escreve os bytes lidos
            fputc(c, out);
            fputc(b2, out);
            fputc(b3, out);
        }
    } else if (c != EOF) {
        fputc(c, out);
    }
    
    // Copia o resto do arquivo
    while ((c = fgetc(in)) != EOF) {
        // Filtrar caracteres invisíveis problemáticos
        if (c >= 32 || c == '\n' || c == '\r' || c == '\t') {
            fputc(c, out);
        } else {
            printf("Caractere invisível removido: 0x%02X\n", c);
        }
    }
    
    fclose(in);
    fclose(out);
    printf("Concluído.\n");
    
    return 0;
}
