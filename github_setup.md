# Instruções para Configurar o Repositório no GitHub

Siga estas instruções para criar um repositório público no GitHub para o projeto FisioLang:

## 1. Criar uma Conta no GitHub (se ainda não tiver)

1. Acesse [GitHub.com](https://github.com/)
2. Clique em "Sign up" e siga as instruções para criar sua conta

## 2. Criar um Novo Repositório

1. No GitHub, clique no botão "+" no canto superior direito e selecione "New repository"
2. Preencha os seguintes campos:
   - Repository name: `fisiolang`
   - Description: `FisioLang: Uma linguagem de programação para fisioterapeutas`
   - Visibilidade: **Public**
   - Inicializar com README: **Não** (você já tem um README)
3. Clique em "Create repository"

## 3. Configurar Git Local e Fazer Upload do Projeto

Abra o PowerShell no Windows e execute os seguintes comandos:

```powershell
# Navegar até a pasta do projeto
cd "c:\Users\mateu\OneDrive\Documentos\Quarto_sem\aps_lingpar"

# Inicializar o repositório Git
git init

# Adicionar todos os arquivos ao controle de versão
git add .

# Criar o primeiro commit
git commit -m "Versão inicial do projeto FisioLang"

# Adicionar o repositório remoto (substitua SEU-USUARIO pelo seu nome de usuário no GitHub)
git remote add origin https://github.com/SEU-USUARIO/fisiolang.git

# Enviar tudo para o GitHub
git push -u origin main
```

Se o Git reclamar sobre a branch `main` não existir, você pode precisar usar:

```powershell
git branch -M main
git push -u origin main
```

## 4. Verificar se Tudo Está Correto

1. Acesse seu repositório no GitHub (https://github.com/SEU-USUARIO/fisiolang)
2. Verifique se todos os arquivos estão presentes:
   - README.md
   - ebnf.md
   - apresentacao_slides.md
   - src/parser/ (com todos os arquivos do compilador)
   - Exemplos de teste (exemplo_fisio.fsl, teste_simplificado.fsl)

## 5. Adicionar Tópicos ao Repositório (opcional)

1. Na página do seu repositório, clique em "Manage topics" (próximo à descrição)
2. Adicione tópicos relevantes como:
   - programming-language
   - compiler
   - flex-bison
   - physical-therapy
   - domain-specific-language

Pronto! Agora seu projeto está disponível publicamente no GitHub e pode ser compartilhado com o professor da disciplina.
