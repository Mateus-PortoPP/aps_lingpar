(*
   FisioLang – Linguagem de Programação para Fisioterapia

   Recursos:
   - O programa começa com "sessao" e termina com "fim_sessao".
   - Um bloco de dados do paciente é definido com "paciente { ... }".
   - É possível importar um dataset externo com "importar_dados".
   - Variáveis são criadas implicitamente por atribuição.
   - Condicionais usam "se melhorou" com bloco obrigatório e opcional "caso contrario".
   - Laços podem ser definidos com "treino" ou "praticar_ate".
   - Comandos para saída, pausa e registro de dados são "resultado", "pausa" e "registrar", respectivamente.
   - A gramática suporta expressões aritméticas, funções integradas e agrupamento.
*)

program          ::= "sessao" block "fim_sessao"

block            ::= "{" { statement } "}"

(* Statements *)
statement        ::= paciente_stmt
                   | importar_stmt
                   | assignment
                   | if_stmt
                   | loop_stmt
                   | print_stmt
                   | pause_stmt
                   | registrar_stmt
                   | ";"  (* statement vazio *)

(* Bloco de dados do paciente *)
paciente_stmt    ::= "paciente" "{" { paciente_info } "}"
paciente_info    ::= identifier "=" expression ";"

(* Importação de dataset externo *)
importar_stmt    ::= "importar_dados" "(" STRING ")" ";"

(* Atribuição *)
assignment       ::= identifier "=" expression ";"

(* Condicional *)
if_stmt          ::= "se melhorou" "(" expression ")" block [ "caso contrario" block ]

(* Loop – "treino" ou "praticar_ate" *)
loop_stmt        ::= ( "treino" | "praticar_ate" ) "(" expression ")" block

(* Comando de saída *)
print_stmt       ::= "resultado" "(" expression ")" ";"

(* Comando de pausa *)
pause_stmt       ::= "pausa" "(" expression ")" ";"

(* Comando para registrar dados *)
registrar_stmt   ::= "registrar" "(" expression "," expression ")" ";"

(* Expressões *)
expression         ::= additive_expr

additive_expr      ::= multiplicative_expr { ("+" | "-") multiplicative_expr }
multiplicative_expr::= unary_expr { ("*" | "/") unary_expr }
unary_expr         ::= [ ("+" | "-" | "!") ] primary
primary            ::= INTEGER
                   | STRING
                   | BOOL
                   | function_call
                   | identifier
                   | "(" expression ")"

(* Função integrada *)
function_call    ::= identifier "(" [ argument_list ] ")"
argument_list    ::= expression { "," expression }

(* Terminais *)
identifier       ::= letter { letter | digit | "_" }
INTEGER          ::= digit { digit }
BOOL             ::= "true" | "false"
STRING           ::= "\"" { character } "\""

digit            ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

letter           ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J"
                | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T"
                | "U" | "V" | "W" | "X" | "Y" | "Z"
                | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j"
                | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t"
                | "u" | "v" | "w" | "x" | "y" | "z"

character        ::= any character except the double quote
