CC      = gcc
CFLAGS  = -Wall -g


.PHONY: all run clean

all: fisio

fisio: parser.tab.c lex.yy.c ast.o codegen.o vm_stub.o
	$(CC) $(CFLAGS) parser.tab.c lex.yy.c ast.o codegen.o vm_stub.o -o fisio

parser.tab.c parser.tab.h: parser.y
	bison -d -o parser.tab.c parser.y

lex.yy.c: lexer.l
	flex -o lex.yy.c lexer.l

ast.o: ast.c ast.h
	$(CC) $(CFLAGS) -c ast.c

codegen.o: codegen.c codegen.h ast.h
	$(CC) $(CFLAGS) -c codegen.c

vm_stub.o: vm_stub.c codegen.h ast.h
	$(CC) $(CFLAGS) -c vm_stub.c

run: fisio
	./fisio ../examples/exemplo_fisio.fsl

test: fisio
	./fisio ../examples/teste_simplificado.fsl

clean:
	rm -f parser.tab.c parser.tab.h lex.yy.c fisio *.o
