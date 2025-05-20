# Instruções de Compilação e Execução

Este documento explica como compilar e executar o interpretador FisioLang.

## Pré-requisitos

Para compilar o FisioLang, você precisará ter instalado:

- GCC (GNU Compiler Collection)
- Flex (Analisador Léxico)
- Bison (Analisador Sintático)

Em sistemas baseados em Debian/Ubuntu, você pode instalá-los com:

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

### Exemplo Principal

Para executar o exemplo principal:

```bash
make run
```

Isso executará o programa `exemplo_fisio.fsl` localizado na pasta `examples`.

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
3. `physical_therapy_exercises.csv`: Arquivo de dados usado pelos exemplos
