# FisioLang

FisioLang é uma linguagem de programação inovadora, criada especialmente para fisioterapeutas. Ela integra os conceitos básicos da programação – variáveis criadas por atribuição implícita, condicionais e loops – com uma temática voltada para o tratamento fisioterapêutico. A linguagem possibilita o registro de dados dos pacientes, a avaliação do progresso e a adaptação dos exercícios de maneira dinâmica, fazendo uso de funções integradas que podem operar com datasets reais.

---

## Motivação

A FisioLang foi desenvolvida para oferecer uma ferramenta prática para fisioterapeutas, permitindo que eles:
- Estruturem e controlem sessões de tratamento de forma programática.
- Registrem informações importantes dos pacientes, como peso, altura, tipo de lesão, sexo e número de sessões já realizadas.
- Adaptem automaticamente os exercícios com base em avaliações de progresso (por exemplo, através de funções como `melhora()`).
- Importem dados reais (por exemplo, de sensores e datasets) para ajustar os parâmetros do tratamento e gerar relatórios.

Essa abordagem inovadora busca unir a tecnologia à prática clínica, tornando o planejamento e o acompanhamento das sessões mais precisos e personalizados.

---

## Principais Funcionalidades

- **Estrutura do Programa:**
  - Todo programa em FisioLang inicia com `sessao` e termina com `fim_sessao`.
  - O corpo do programa é definido em blocos delimitados por chaves `{ ... }`.

- **Registro de Dados do Paciente:**
  - Use o comando `paciente { ... }` para coletar informações essenciais do paciente.
  - Exemplo:
    ```plaintext
    paciente {
        peso = 80;
        altura = 175;
        lesao = "joelho";
        sexo = "M";
        sessoes = 4;
    }
    ```

- **Importação de Dados:**
  - O comando `importar_dados("URL")` permite carregar datasets externos, que podem ser usados para treinar funções integradas ou ajustar os parâmetros do tratamento.
  - Exemplo:
    ```plaintext
    importar_dados("https://exemplo.com/dataset_fisio.csv");
    ```

- **Variáveis Implícitas:**
  - As variáveis são criadas automaticamente por atribuição, sem a necessidade de declaração de tipo.
  - Exemplo:
    ```plaintext
    x = 30;
    ```

- **Estruturas Condicionais:**
  - Use `se melhorou (condição) { ... } [caso contrario { ... }]` para executar blocos de código com base no progresso do tratamento.
  - Exemplo:
    ```plaintext
    se melhorou (x > 20) {
        x = x - 5;
    } caso contrario {
        x = x + 5;
    }
    ```

- **Laços de Repetição:**
  - A linguagem oferece dois comandos de loop:
    - **treino:** Laço tradicional que repete enquanto a condição for verdadeira.
    - **praticar_ate:** Repete um bloco até que uma função integrada (como `melhora()`) retorne um valor que satisfaça a meta.
  - Exemplo de loop com meta:
    ```plaintext
    praticar_ate (melhora() >= 80) {
        resultado(x);
        x = x + 1;
    }
    ```

- **Comandos de Saída e Pausa:**
  - **resultado(expr);** – exibe o valor da expressão.
  - **pausa(tempo);** – define intervalos durante a sessão.
  - Exemplo:
    ```plaintext
    resultado(x);
    pausa(10);
    ```

- **Registro de Dados:**
  - **registrar(expr, expr);** – salva informações importantes, como medições (por exemplo, registrar("força", 75);).

- **Funções Integradas para Avaliação:**
  - **melhora():** Retorna um índice de progresso, podendo determinar se o tratamento atingiu a meta.
  - **ler_sensor("parâmetro"):** Lê dados de sensores, como força ou amplitude.
  - **calcular_consultas(...):** Sugere, com base nas características do paciente, a quantidade ideal de consultas.

---

## Exemplo de Programa

```plaintext
sessao {
  paciente {
      peso = 80;
      altura = 175;
      lesao = "joelho";
      sexo = "M";
      sessoes = 4;
  }
  
  importar_dados("https://exemplo.com/dataset_fisio.csv");
  
  x = 30;                    (* tempo do exercício em segundos *)
  resultado(x);

  se melhorou (x > 20) {
      x = x - 5;
  } caso contrario {
      x = x + 5;
  }

  praticar_ate (melhora() >= 80) {
      resultado(x);
      x = x + 1;
  }
  
  pausa(10);
  registrar("força", ler_sensor("força"));

  consulta = calcular_consultas(peso, altura, lesao, sexo, sessoes);
  resultado(consulta);
  
  resultado(x);
}
fim_sessao
