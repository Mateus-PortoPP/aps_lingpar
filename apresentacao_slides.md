# Apresentação FisioLang

Este arquivo contém o conteúdo para os slides de apresentação da linguagem FisioLang.

## Slide 1: Título
- **FisioLang**: Uma Linguagem de Programação para Fisioterapeutas
- Desenvolvido por: [Seu Nome]
- Data: Maio 2025

## Slide 2: Motivação
- Lacuna entre tecnologia e prática clínica em fisioterapia
- Necessidade de automatizar aspectos do tratamento
- Importância de adaptar exercícios com base em métricas objetivas
- Facilitar o registro e análise de dados de pacientes

## Slide 3: Características da Linguagem
- Linguagem de domínio específico para fisioterapia
- Sintaxe simples e intuitiva
- Suporte a importação de dados externos (CSV)
- Funções específicas para o contexto fisioterapêutico
- Estruturas de controle (condicionais e loops) adaptadas para o domínio

## Slide 4: Estrutura Básica
```
sessao {
  /* Código aqui */
}
fim_sessao
```

## Slide 5: Blocos de Dados do Paciente
```
paciente {
  peso = 75;
  altura = 170;
  lesao = "joelho";
  sexo = "M";
  sessoes = 5;
}
```

## Slide 6: Construções Condicionais
```
se melhorou(ler_sensor("amplitude") > 80) {
  tempo_exercicio = tempo_exercicio - 5;
} caso contrario {
  tempo_exercicio = tempo_exercicio + 10;
}
```

## Slide 7: Estruturas de Repetição
```
treino(tempo_exercicio > 0) {
  resultado(tempo_exercicio);
  tempo_exercicio = tempo_exercicio - 1;
}

praticar_ate(melhora() > 79) {
  pausa(2);
  registrar(ler_sensor("amplitude"), tempo_exercicio);
}
```

## Slide 8: Funções Específicas
- **melhora()**: Retorna um valor aleatório entre 0 e 100
- **ler_sensor(nome)**: Lê valor médio de um sensor do arquivo CSV
- **calcular_consultas(...)**: Calcula número de consultas necessárias
- **resultado(expr)**: Exibe o resultado de uma expressão
- **pausa(tempo)**: Implementa pausa no tratamento
- **registrar(v1, v2)**: Registra dados do tratamento

## Slide 9: Implementação
- Analisador léxico implementado com Flex
- Analisador sintático implementado com Bison
- Máquina virtual customizada para execução
- Gramática definida formalmente em EBNF

## Slide 10: Exemplo Completo
```
sessao {
  paciente {
    peso = 75;
    altura = 170;
    lesao = "joelho";
  }
  
  importar_dados("physical_therapy_exercises.csv");
  
  tempo_exercicio = 30;
  
  se melhorou(ler_sensor("amplitude") > 80) {
    tempo_exercicio = tempo_exercicio - 5;
  } caso contrario {
    tempo_exercicio = tempo_exercicio + 10;
  }
  
  /* Mais código... */
}
fim_sessao
```

## Slide 11: Curiosidades
- Nome FisioLang combina "Fisioterapia" + "Language"
- Todas as palavras-chave são em português
- Inspirada em linguagens como Python e JavaScript
- Facilmente extensível para incluir novos sensores ou métricas

## Slide 12: Conclusão
- FisioLang demonstra como linguagens específicas podem auxiliar áreas especializadas
- Potencial para aplicação em clínicas e pesquisas
- Futuras extensões: interface gráfica, novos sensores, módulos específicos para diferentes tipos de lesão
- Código open-source disponível no GitHub
