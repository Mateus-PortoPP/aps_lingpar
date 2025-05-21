# Instruções de Compilação e Execução

Este documento explica como compilar e executar o interpretador FisioLang.

## Pré-requisitos

Para compilar o FisioLang, você precisará ter instalado:

- GCC (GNU Compiler Collection)
- Flex (Analisador Léxico)
- Bison (Analisador Sintático)

Em sistemas baseados em Ubuntu, você pode instalá-los com:

```bash
sudo apt-get install gcc flex bison make
```

## Compilação

1. Navegue até a pasta `src`:

```bash
cd src
```

2. Compile o projeto:

```bash
make
```

Isso gerará o executável `fisio` na pasta `src`.

## Execução


### Exemplo Simplificado

Para executar o exemplo simplificado:

```bash
make test
```

Isso executará o programa `teste_simplificado.fsl` localizado na pasta `examples`.

### Executar Arquivo Personalizado

Para executar um arquivo FisioLang específico:

```bash
./fisio caminho/para/seu_arquivo.fsl
```

## Limpeza

Para limpar os arquivos compilados e gerados:

```bash
make clean
```

## Estrutura de Diretórios

- `src/`: Contém o código-fonte do compilador e da VM
- `examples/`: Contém exemplos de programas FisioLang
- `doc/`: Contém documentação técnica e apresentação

## Exemplos Incluídos

1. `exemplo_fisio.fsl`: Um exemplo completo que demonstra todas as funcionalidades da linguagem
2. `teste_simplificado.fsl`: Um exemplo mais simples para testes básicos
3. `teste_simplificado_new.fsl`: Versão atualizada do exemplo simplificado
4. `teste_minimo.fsl`: Exemplo mínimo com estruturas básicas da linguagem
5. `super_simples.fsl`: O exemplo mais simples possível (apenas retorna um valor)
6. `teste_simples_limpo.fsl`: Versão limpa do exemplo simplificado
7. `exemplo_importacao.fsl`: Demonstração de importação de dados externos
8. `physical_therapy_exercises.csv`: Arquivo de dados usado pelos exemplos

## Guia Rápido da Linguagem FisioLang

FisioLang é uma linguagem de programação específica para fisioterapeutas, projetada para ser intuitiva e focada nas necessidades da área.

### Estrutura Básica

Todo programa em FisioLang deve começar com `sessao {` e terminar com `} fim_sessao`.

```
sessao {
  // Seu código aqui
}
fim_sessao
```

### Tipos de Dados

- Números inteiros: `x = 10;`
- Strings (texto): `nome = "João";`
- Booleanos: Representados através de expressões condicionais

### Cadastro de Paciente

```
paciente {
  peso = 75;
  altura = 170;
  lesao = "joelho";
  sessoes = 5;
}
```

### Operações Básicas

- Atribuição: `x = 10;`
- Operações aritméticas: `resultado(x + y);`
- Comparações: `x > 5`, `y == 10`

### Estruturas de Controle

Condicionais:
```
se melhorou(x > 5) {
  resultado(100);
} caso contrario {
  resultado(200);
}
```

### Funções Especiais

- `importar_dados(arquivo)`: Importa dados de um arquivo CSV
- `ler_sensor(tipo)`: Simula leitura de um sensor
- `melhora()`: Avalia a melhora do paciente
- `calcular_consultas(x, y, z)`: Calcula o número de consultas necessárias
- `registrar(m, valor)`: Registra informações no sistema
- `pausa(segundos)`: Pausa a execução
- `resultado(valor)`: Retorna um valor como resultado da sessão

## Resolução de Problemas

Se você encontrar problemas durante a compilação ou execução:

1. Verifique se todos os pré-requisitos estão instalados corretamente
2. Certifique-se de que os caminhos para arquivos importados estão corretos
3. Verifique a sintaxe do seu código FisioLang
4. Execute `make clean` e tente compilar novamente

Para reportar bugs ou sugerir melhorias, entre em contato com os desenvolvedores.

## Depuração

Para executar o FisioLang sem output de depuração (para uma saída mais limpa):

1. Modifique o arquivo `parser.y` para remover ou comentar a linha que define `yydebug = 1` na função `parse_file`.
2. Comente ou remova os `printf` de depuração nos arquivos `parser.y` e `lexer.l`.
3. Recompile o projeto com `make clean && make`.

Para ativar o modo de depuração:

1. Certifique-se de que a linha `yydebug = 1` está ativa na função `parse_file` em `parser.y`.
2. Descomente os `printf` de depuração relevantes.
3. Recompile o projeto.

A depuração pode ajudar a identificar problemas na análise léxica e sintática do seu código FisioLang.
