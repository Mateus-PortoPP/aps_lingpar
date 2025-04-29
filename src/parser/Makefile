# Makefile para o compilador FisioLang
# Suporta compilação tanto no Windows quanto no Linux

# Determinar o sistema operacional
ifdef SystemRoot
    # Windows
    RM = del /Q
    EXE_EXT = .exe
    PATH_SEP = \\
    MKDIR = if not exist $(BIN_DIR) mkdir $(BIN_DIR)
else
    # Linux/Unix
    RM = rm -f
    EXE_EXT = 
    PATH_SEP = /
    MKDIR = mkdir -p $(BIN_DIR)
endif

# Diretórios do projeto
SRC_DIR = src$(PATH_SEP)parser
BIN_DIR = bin

# Ferramentas
BISON = bison
FLEX = flex
CC = gcc

# Flags
CFLAGS = -Wall -g
LDFLAGS = 
VERBOSE ?= 1

# Arquivos
PARSER_Y = $(SRC_DIR)$(PATH_SEP)parser.y
LEXER_L = $(SRC_DIR)$(PATH_SEP)lexer.l
OUTPUT = $(BIN_DIR)$(PATH_SEP)fisio$(EXE_EXT)
TEST_FILE ?= test1.fisio

# Arquivos intermediários
PARSER_C = $(SRC_DIR)$(PATH_SEP)parser.tab.c
PARSER_H = $(SRC_DIR)$(PATH_SEP)parser.tab.h
LEXER_C = $(SRC_DIR)$(PATH_SEP)lex.yy.c

# Arquivos objeto
VM_OBJ = $(SRC_DIR)$(PATH_SEP)vm_stub.o

# Se modo verbose estiver ativado
ifeq ($(VERBOSE),1)
  CFLAGS += -DVERBOSE_OUTPUT
endif

# Regras de compilação
all: preparar $(OUTPUT)

preparar:
	@echo "Compilando FisioLang..."
	@$(MKDIR)

$(OUTPUT): $(PARSER_C) $(LEXER_C) $(VM_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	@echo "Compilação concluída! O executável está em: $(OUTPUT)"

$(PARSER_C) $(PARSER_H): $(PARSER_Y)
	$(BISON) -d -o $(PARSER_C) $<

$(LEXER_C): $(LEXER_L) $(PARSER_H)
	$(FLEX) -o $@ $<

$(VM_OBJ): $(SRC_DIR)$(PATH_SEP)vm_stub.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	$(RM) $(PARSER_C) $(PARSER_H) $(LEXER_C) $(VM_OBJ) $(OUTPUT)
	@echo "Arquivos temporários removidos."

# Regra para executar o programa
run: all
	$(OUTPUT)

# Regra para testar com arquivo de entrada
test: all
	$(OUTPUT) $(TEST_FILE)

# Regra para testar especificamente test1.fisio
test1: all
	$(OUTPUT) test1.fisio

.PHONY: all clean run test test1 preparar
