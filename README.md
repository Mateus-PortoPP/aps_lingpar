# TimãoLang

TimãoLang é uma linguagem de programação inclusiva, criada com uma temática inspirada no futebol e, especialmente, no universo do Corinthians. O principal objetivo da linguagem é demonstrar que a programação pode ser acessível, divertida e culturalmente rica, mesmo quando se trabalha com os conceitos básicos.  

## Capacidades da Linguagem

- **Estrutura Simples e Temática:**  
  TimãoLang foi desenvolvida para ser simples e minimalista, contendo apenas as estruturas essenciais necessárias em uma linguagem de programação:  
  - **Variáveis implícitas:** As variáveis não precisam ser declaradas com um tipo específico. Basta atribuir um valor para que a variável seja criada.  
  - **Condicionais:** O comando condicional permite a execução de blocos de código com base em uma condição. Em vez de utilizar a palavra “if”, a linguagem usa a expressão **"se marcou"** para iniciar a condição e **"senão"** para o bloco alternativo.
  - **Loops:** A repetição de comandos é realizada por meio do laço **"treino"**, que funciona de forma semelhante ao comando “while” tradicional.
  - **Entrada e Saída:** Para leitura de dados, utiliza-se comandos como **scanf()** (ou equivalentes como input/reader, unificados em uma palavra reservada) e, para saída, o comando temático **"vai_curintia"** que exibe valores.

- **Acessibilidade e Inclusividade:**  
  A escolha dos nomes dos comandos e das estruturas (como “partida”, “se marcou”, “treino” e “vai_curintia”) torna a linguagem não apenas temática, mas também inclusiva, aproximando o universo do futebol – e, em particular, a cultura corintiana – do mundo da programação. Essa abordagem pode reduzir barreiras e incentivar o interesse de públicos que se identifiquem com o tema.

## Especificações da Linguagem

TimãoLang adota uma sintaxe definida por uma gramática em EBNF que estabelece, de forma formal, as regras e estruturas permitidas no código. Entre os aspectos mais relevantes estão:

- **Programa:**  
  Todo programa deve começar com a palavra-chave `partida` e finalizar com `fim`. Todo o conteúdo do programa é definido dentro de um bloco delimitado por chaves (`{` e `}`).

- **Statements:**  
  A linguagem trabalha com um conjunto reduzido de instruções:  
  - **Atribuição:** Toda variável é criada quando recebe seu primeiro valor. Exemplo: `x = 3;`
  - **Condicional:** Utiliza-se o comando **"se marcou"** para testar uma condição, seguido de um bloco de comandos. Se a condição não for satisfeita, um bloco opcional iniciado por **"senão"** será executado.
  - **Loop:** O comando **"treino"** é usado para criar loops que repetem um bloco de código enquanto uma condição for verdadeira.
  - **Saída:** O comando **"vai_curintia"** exibe resultados na tela.

- **Expressões:**  
  TimãoLang suporta expressões simples para operações aritméticas. A ordem de precedência é definida da seguinte forma:  
  1. Operadores aditivos (`+`, `-`)  
  2. Operadores multiplicativos (`*`, `/`)  
  3. Operadores unários (`+`, `-`, `!`)  
  4. Agrupamento com parênteses  
  Dessa forma, expressões como `3 + 6/3 * 2 - 1` são avaliadas com a precedência esperada.

- **Terminais:**  
  Os elementos básicos da linguagem incluem:  
  - **Identificadores:** Sequências de letras, dígitos e underscores que iniciam com uma letra.  
  - **Inteiros:** Sequências de dígitos.  
  - **Booleanos:** Os literais `true` e `false`.  
  - **Strings:** Cadeias de caracteres delimitadas por aspas duplas.

## Exemplo de Programa

Segue um exemplo simples que demonstra as principais funcionalidades:

```timãolang
partida {
  x = 3;
  vai_curintia(x);

  se marcou (x > 1) {
      x = x - 1;
  } senão {
      x = x + 1;
  }

  treino (x < 10) {
      vai_curintia(x);
      x = x + 1;
  }

  vai_curintia(x);
}
fim
