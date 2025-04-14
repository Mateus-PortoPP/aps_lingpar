(* 
   TimãoLang – Linguagem de Programação Temática do Corinthians

   Termos utilizados:
     - Programa: inicia com "partida" e termina com "fim".
     - Bloco: delimitado por chaves { ... }.
     - Atribuição: cria a variável implicitamente (ex: x = 3;).
     - Condicional: "se marcou" (if) e opcional "senão" (else).
     - Loop: "treino" para laço de repetição.
     - Impressão: "vai_curintia( expressão );".
*)

program       ::= "partida" block "fim"

block         ::= "{" { statement } "}"

(* Statements básicos *)
statement     ::= assignment
                | if_stmt
                | loop_stmt
                | print_stmt
                | ";"   (* statement vazio *)

(* Atribuição: cria a variável implicitamente se não existir *)
assignment    ::= identifier "=" expression ";"

(* Condicional: "se marcou" inicia o teste; bloco obrigatório para o "então" e opcional "senão" *)
if_stmt       ::= "se marcou" "(" expression ")" block [ "senão" block ]

(* Loop: "treino" para repetir enquanto a condição for verdadeira *)
loop_stmt     ::= "treino" "(" expression ")" block

(* Comando de saída: "vai_curintia" para imprimir *)
print_stmt    ::= "vai_curintia" "(" expression ")" ";"

(* Expressões – operações aritméticas e agrupamento *)
expression         ::= additive_expr

additive_expr      ::= multiplicative_expr { ("+" | "-") multiplicative_expr }
multiplicative_expr::= unary_expr { ("*" | "/") unary_expr }
unary_expr         ::= [ ("+" | "-" | "!") ] primary
primary            ::= INTEGER
                   | STRING
                   | BOOL
                   | identifier
                   | "(" expression ")"

(* Terminais *)
identifier    ::= letter { letter | digit | "_" }
INTEGER       ::= digit { digit }
BOOL          ::= "true" | "false"
STRING        ::= "\"" { character } "\""

digit         ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

letter        ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J"
              | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T"
              | "U" | "V" | "W" | "X" | "Y" | "Z"
              | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j"
              | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t"
              | "u" | "v" | "w" | "x" | "y" | "z"

character     ::= any character except the double quote
