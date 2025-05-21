---
marp: true
theme: default
paginate: true
backgroundColor: white
header: '**FisioLang**'
footer: 'Maio 2025'
---

# FisioLang

## Uma Linguagem de Programação para Fisioterapeutas

Desenvolvido por: Equipe de Desenvolvimento
Maio 2025

---

# Motivação

- **Lacuna tecnológica**: Ponte entre a tecnologia e a prática clínica em fisioterapia
- **Automação de processos**: Redução de tarefas manuais e repetitivas
- **Adaptação dinâmica**: Customização de tratamentos com base em métricas objetivas
- **Avaliação baseada em dados**: Decisões clínicas apoiadas em evidências
- **Acessibilidade tecnológica**: Ferramenta que fisioterapeutas podem usar sem conhecimento avançado em programação

---

# Características da Linguagem

- **Domínio específico**: Projetada exclusivamente para fisioterapia
- **Sintaxe intuitiva**: Fácil de aprender, mesmo para profissionais sem experiência em programação
- **Integração de dados**: Importação e análise de dados de pacientes (CSV)
- **Funções especializadas**: Operações focadas no contexto fisioterapêutico
- **Estrutura adaptada**: Construções que refletem o fluxo natural de uma sessão de fisioterapia

---

# Estrutura Básica do Programa

```
sessao {
  /* Bloco principal do programa */
  /* Representa uma sessão de fisioterapia */
}
fim_sessao
```

Cada programa FisioLang representa uma sessão de fisioterapia, com início e fim claramente definidos.

---

# Registro de Dados do Paciente

```
paciente {
  peso = 75;
  altura = 170;
  lesao = "joelho";
  sexo = "M";
  sessoes = 5;
}
```

Blocos específicos para armazenar informações do paciente de maneira organizada.

---

# Estruturas Condicionais

```
se melhorou(ler_sensor("amplitude") > 80) {
  tempo_exercicio = tempo_exercicio - 5;
} caso contrario {
  tempo_exercicio = tempo_exercicio + 10;
}
```

Decisões baseadas em parâmetros clínicos com sintaxe natural para fisioterapeutas.

---

# Funções Especializadas

- `importar_dados(arquivo)`: Carrega dados de pacientes ou exercícios
- `ler_sensor(tipo)`: Simula leituras de sensores (amplitude, força, etc.)
- `melhora()`: Avalia a evolução do paciente
- `calcular_consultas(...)`: Estima o número necessário de sessões
- `registrar(...)`: Salva dados da sessão
- `resultado(valor)`: Define o resultado de uma operação

---

# Tipos de Dados

- **Números inteiros**: Para medições, contagens e cálculos
  ```
  idade = 45;
  repeticoes = 10;
  ```

- **Strings**: Para textos e descrições
  ```
  regiao = "lombar";
  observacao = "Dor ao movimento lateral";
  ```

- **Expressões booleanas**: Para decisões clínicas
  ```
  amplitude_adequada = (angulo > 90);
  ```

---

# Exemplo: Programa Simples

```
sessao {
  paciente { 
    peso = 75; 
    altura = 170; 
    lesao = "joelho"; 
    sessoes = 5; 
  }
  
  importar_dados("physical_therapy_exercises.csv");
  
  resultado(42);
}
fim_sessao
```

---

# Exemplo: Avaliação de Progresso

```
sessao {
  x = 10;
  y = 20;
  
  se melhorou(x > 5) {
    resultado(100);
  } caso contrario {
    resultado(200);
  }
  
  valor = ler_sensor("amplitude");
  m = melhora();
  
  registrar(m, valor);
}
fim_sessao
```

---

# Arquitetura da Linguagem

1. **Analisador Léxico (Flex)**: Identifica tokens da linguagem
2. **Analisador Sintático (Bison)**: Constrói a estrutura gramatical
3. **Gerador de Código**: Cria representação intermediária
4. **Máquina Virtual**: Executa o código gerado

---

# Implementação

- Desenvolvida em C para eficiência e portabilidade
- Utiliza ferramentas padrão de compilação (Flex, Bison)
- Estrutura de projeto modular e extensível
- Arquitetura que permite futuras extensões

---

# Curiosidades

- **Inspiração**: Linguagens específicas para medicina e reabilitação
- **Nome**: Fusão de "Fisioterapia" e "Language"
- **Desenvolvimento**: Projeto acadêmico com potencial de aplicação real
- **Extensibilidade**: Pode ser adaptada para outras áreas da saúde
- **Futuro**: Possibilidade de integração com dispositivos IoT de fisioterapia

---

# Desafios Enfrentados

- Equilibrar simplicidade e funcionalidade
- Criar uma sintaxe realmente intuitiva para não-programadores
- Implementar funções que realmente refletem as necessidades dos fisioterapeutas
- Garantir precisão na manipulação de dados clínicos
- Desenvolver uma documentação acessível

---

# Demo

- Demonstração de um programa FisioLang em execução
- Análise de dados de pacientes
- Simulação de leitura de sensores
- Geração de relatórios de progresso

---

# Próximos Passos

- Expansão da biblioteca de funções
- Integração com sistemas de prontuário eletrônico
- Desenvolvimento de uma interface gráfica
- Criação de uma comunidade de usuários fisioterapeutas
- Publicação como software livre para contribuições

---

# Conclusão

- FisioLang preenche uma lacuna importante entre tecnologia e fisioterapia
- Permite que fisioterapeutas automatizem e personalizem tratamentos
- Facilita a coleta e análise de dados para prática baseada em evidências
- Proporciona uma plataforma extensível para inovação em fisioterapia
- Democratiza o acesso à tecnologia para profissionais de saúde

---

treino(tempo_exercicio > 0) {
  resultado(tempo_exercicio);
  tempo_exercicio = tempo_exercicio - 1;
}

praticar_ate(melhora() > 79) {
  pausa(2);
  registrar(ler_sensor("amplitude"), tempo_exercicio);
}
```

# Funções Específicas
- **melhora()**: Retorna um valor aleatório entre 0 e 100
- **ler_sensor(nome)**: Lê valor médio de um sensor do arquivo CSV
- **calcular_consultas(...)**: Calcula número de consultas necessárias
- **resultado(expr)**: Exibe o resultado de uma expressão
- **pausa(tempo)**: Implementa pausa no tratamento
- **registrar(v1, v2)**: Registra dados do tratamento

# Implementação
- Analisador léxico implementado com Flex
- Analisador sintático implementado com Bison
- Máquina virtual customizada para execução
- Gramática definida formalmente em EBNF

# Exemplo Completo
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

#Curiosidades
- Nome FisioLang combina "Fisioterapia" + "Language"
- Todas as palavras-chave são em português
- Inspirada em linguagens como Python e JavaScript
- Facilmente extensível para incluir novos sensores ou métricas

#Conclusão
- FisioLang demonstra como linguagens específicas podem auxiliar áreas especializadas
- Potencial para aplicação em clínicas e pesquisas
- Futuras extensões: interface gráfica, novos sensores, módulos específicos para diferentes tipos de lesão
- Código open-source disponível no GitHub
