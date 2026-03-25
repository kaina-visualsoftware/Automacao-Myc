# 🤖 Como Desenvolver Testes Automatizados com IA — Guia Completo

> **Objetivo**: Este guia ensina, passo a passo, como criar testes automatizados no projeto **mycommerce-automacao** utilizando o **sistema de agentes IA** integrado ao IDE. Em vez de escrever código manualmente, você descreve o que quer testar e a IA gera o código seguindo todos os padrões do projeto.

---

## 📋 Índice

1. [O que é o Sistema de Agentes?](#1-o-que-é-o-sistema-de-agentes)
2. [Pré-Requisitos](#2-pré-requisitos)
3. [Entendendo a Estrutura de Agentes](#3-entendendo-a-estrutura-de-agentes)
4. [Conceitos Fundamentais](#4-conceitos-fundamentais)
5. [Passo a Passo: Criando um Teste com IA](#5-passo-a-passo-criando-um-teste-com-ia)
6. [Utilizando os Workflows](#6-utilizando-os-workflows)
7. [Utilizando as Skills](#7-utilizando-as-skills)
8. [Revisando o Código Gerado](#8-revisando-o-código-gerado)
9. [Exemplos Reais de Prompts](#9-exemplos-reais-de-prompts)
10. [O que a IA Faz vs. O que Você Faz](#10-o-que-a-ia-faz-vs-o-que-você-faz)
11. [Depuração: Quando o Código Gerado Não Funciona](#11-depuração-quando-o-código-gerado-não-funciona)
12. [Dicas para Prompts Eficientes](#12-dicas-para-prompts-eficientes)
13. [Checklist Rápido](#13-checklist-rápido)
14. [Comparação: Manual vs. Automatizado](#14-comparação-manual-vs-automatizado)

---

## 1. O que é o Sistema de Agentes?

O projeto possui um **sistema multi-agente** embarcado no diretório `.agent/` que funciona como um "copiloto especializado" dentro do seu IDE. Ele conhece:

- ✅ Toda a **estrutura do projeto** (pastas, arquivos, padrões)
- ✅ Os **frameworks utilizados** (Robot Framework, SikuliLibrary, ImageHorizonLibrary, DatabaseLibrary)
- ✅ As **convenções de nomenclatura** (BDD em português, prefixos de imagem, namespacing)
- ✅ As **keywords reutilizáveis** existentes em `utils/`
- ✅ A **integração com banco de dados** MySQL do myCommerce
- ✅ Os **atalhos do myCommerce** e padrões de interação visual

### Como funciona na prática

```
1. Você descreve em linguagem natural o que quer testar
2. O Orquestrador identifica o tipo de tarefa
3. Delega para a Skill apropriada
4. A IA gera o código .robot seguindo TODOS os padrões
5. Você revisa, captura as imagens e executa
```

### Diferença do Desenvolvimento Manual

| Aspecto | Manual (comoDesenvolver.md) | Com IA (este guia) |
|---|---|---|
| **Quem escreve o código?** | Você, linha por linha | A IA gera seguindo os padrões |
| **Precisa conhecer Robot Framework?** | Sim, profundamente | Básico para revisão |
| **Precisa decorar atalhos?** | Sim | Não, a IA já conhece |
| **Keywords existentes?** | Precisa procurar manualmente | A IA já sabe quais existem |
| **Naming conventions?** | Precisa consultar documentação | A IA aplica automaticamente |
| **Tempo para criar um teste?** | 30-60 minutos | 5-10 minutos (+ captura de imagens) |

---

## 2. Pré-Requisitos

### Mesmos do desenvolvimento manual

```bash
# Python 3.9.13 ou superior
python --version

# Dependências do projeto
pip install robotframework
pip install robotframework-SikuliLibrary
pip install robotframework-imagehorizonlibrary
pip install robotframework-faker
pip install robotframework-databaselibrary
pip install mysql-connector-python
pip install pymysql
```

### Pré-requisitos adicionais para o sistema de agentes

- **IDE com suporte a agentes IA** (Antigravity / VS Code com extensão)
- O diretório `.agent/` deve existir na raiz do projeto (já está configurado)
- Não precisa instalar mais nada — o sistema de agentes é baseado em arquivos markdown

> ⚠️ **IMPORTANTE**: O diretório `.agent/` está no `.gitignore` — ele é **local** e não vai para o repositório Git. Cada máquina tem sua própria cópia.

---

## 3. Entendendo a Estrutura de Agentes

```
.agent/
│
├── rules/                              ← 📜 REGRAS DO ORQUESTRADOR
│   └── orchestrator.md                 ← Define as regras globais de desenvolvimento
│                                          Estrutura obrigatória, convenções, delegação
│
├── skills/                             ← 🧠 HABILIDADES ESPECIALIZADAS
│   │
│   ├── analise-codigo/                 ← 🔍 Skill: Análise de Código
│   │   └── SKILL.md                       Mapeia módulos, keywords, cobertura
│   │
│   ├── documentacao-frameworks/        ← 📚 Skill: Documentação dos Frameworks
│   │   └── SKILL.md                       Referência rápida Robot/Sikuli/DB/etc.
│   │
│   ├── padroes-desenvolvimento/        ← 📐 Skill: Padrões de Desenvolvimento
│   │   └── SKILL.md                       Como se desenvolve neste projeto
│   │
│   └── geracao-testcases/              ← ⚙️ Skill: Geração de Test Cases
│       └── SKILL.md                       Templates e processo de geração
│
└── workflows/                          ← 🔄 WORKFLOWS (fluxos automatizados)
    │
    ├── analise-projeto.md              ← /analise-projeto
    │                                      Análise completa de cobertura
    │
    ├── criar-testcase.md               ← /criar-testcase
    │                                      Criar novo test case end-to-end
    │
    └── executar-testes.md              ← /executar-testes
                                           Executar testes e diagnosticar falhas
```

### O que cada componente faz

| Componente | Função | Quando é usado |
|---|---|---|
| **Orquestrador** | Recebe sua solicitação e decide o que fazer | Sempre (automático) |
| **Análise de Código** | Entende o projeto, mapeia módulos e cobertura | Quando você pergunta "o que tem?", "analise X" |
| **Documentação Frameworks** | Responde dúvidas sobre sintaxe e API | Quando você pergunta "como usar X?" |
| **Padrões de Desenvolvimento** | Garante que o código siga os padrões | Quando gera qualquer código |
| **Geração de Test Cases** | Gera arquivos .robot completos | Quando você pede "crie um teste para X" |

---

## 4. Conceitos Fundamentais

### 4.1 O Orquestrador Conhece Todas as Regras

O orquestrador define **10 regras** que a IA segue automaticamente. Você não precisa decorá-las, mas é bom saber que existem:

| Regra | O que garante |
|---|---|
| **R1** | Keywords e TestCases em diretórios separados e espelhados |
| **R2** | Nomenclatura BDD em português (Dado/Quando/Então) |
| **R3** | Nomes de arquivo padronizados (Key\<Nome\>1.robot, Teste\_\<Nome\>1.robot) |
| **R4** | Variáveis de imagem com prefixo (${TELA\_}, ${AVISO\_}, ${MODAL\_}, etc.) |
| **R5** | Seções obrigatórias (Settings, Variables, Keywords/TestCases) |
| **R6** | Conexão com banco de dados MySQL configurada |
| **R7** | Tempos de espera padronizados (SLEEP\_BAIXO, SLEEP\_MEDIO, etc.) |
| **R8** | Namespacing de keywords quando há ambiguidade |
| **R9** | Suite Setup e Teardown corretamente configurados |
| **R10** | Tags sequenciais em todos os test cases |

### 4.2 Workflows São Fluxos Guiados

Workflows são como "receitas" que guiam a IA passo a passo. Quando você aciona um workflow, a IA segue uma sequência de ações definidas:

```
/criar-testcase  →  A IA vai:
  1. Perguntar qual módulo
  2. Verificar diretórios
  3. Criar diretórios se necessário
  4. Gerar arquivo de Keywords com todos os padrões
  5. Gerar arquivo de Test Cases com todos os padrões
  6. Listar imagens necessárias
  7. Validar referências
```

### 4.3 Skills São o Conhecimento Especializado

Cada skill é um "manual" que a IA consulta quando precisa. Você pode pedir para a IA consultar uma skill específica, mas normalmente o orquestrador faz isso automaticamente.

---

## 5. Passo a Passo: Criando um Teste com IA

### Passo 1: Identifique o que Testar

Antes de falar com a IA, tenha claro:

```
□ Qual módulo do myCommerce? (Vendas, Condicional, OS, etc.)
□ Quais operações testar? (Incluir, Editar, Excluir, Visualizar)
□ Existem cenários especiais? (venda parcial, devolução, etc.)
```

### Passo 2: Acione o Workflow de Criação

No IDE, use o workflow:

```
/criar-testcase
```

Ou simplesmente descreva o que você precisa em linguagem natural:

```
"Crie um teste automatizado para o módulo de Cadastro de Fornecedores 
do myCommerce. Preciso testar: inclusão, edição, visualização e exclusão."
```

### Passo 3: Responda as Perguntas da IA

A IA pode perguntar:

- Qual tecla de atalho abre o módulo? (F2, F3, etc.)
- Qual o nome da tabela no banco de dados?
- Existem avisos/popups específicos nessa tela?

> 💡 **Dica**: Se você não souber, diga "não sei" e a IA vai tentar inferir baseada nos padrões existentes do projeto.

### Passo 4: Revise o Código Gerado

A IA vai gerar dois arquivos:

```
KeyWords/<Módulo>/<SubMódulo>/Key<Nome>1.robot    ← Keywords
TestsCases/<Módulo>/<SubMódulo>/Teste_<Nome>1.robot ← Test Cases
```

Revise seguindo o [Checklist de Revisão](#8-revisando-o-código-gerado).

### Passo 5: Capture as Imagens

A IA vai listar quais imagens `.png` precisam ser capturadas:

```
📸 Imagens necessárias:
1. tela_CadastroFornecedores.png        ← Barra de título da tela principal
2. tela_CadastroFornecedoresAdd.png     ← Barra de título ao clicar Adicionar
3. aviso_DesejaExcluirFornecedor.png    ← Texto do aviso de exclusão
4. ...
```

Capture cada imagem seguindo as regras de captura do guia manual ([comoDesenvolver.md](#) Seção 6):

- Use **Win + Shift + S** para capturar
- Capture a **menor área possível** que identifique o elemento
- Salve como **PNG** em `Testes_BancoAleatorio/images/`
- Use **exatamente o nome** que a IA indicou

### Passo 6: Execute e Valide

```bash
# Execute o teste gerado
cd C:\Automacao\mycommerce-automacao\Testes_BancoAleatorio
robot -d .\results\ -i Teste01 .\TestsCases\<Módulo>\<SubMódulo>\Teste_<Nome>1.robot
```

> ⚠️ Lembre-se: clique na tela do myCommerce após iniciar a execução!

### Passo 7: Itere com a IA

Se o teste falhar, descreva o erro para a IA:

```
"O Teste 01 falhou na keyword 'Wait Until Screen Contain' com timeout. 
A imagem tela_CadastroFornecedores.png não foi encontrada. 
A tela que aparece é diferente do esperado."
```

A IA vai sugerir correções — pode ser re-captura de imagem, ajuste de timing, ou tratamento de aviso.

---

## 6. Utilizando os Workflows

### 📊 /analise-projeto — Análise Completa

**Quando usar**: Para entender o estado atual do projeto, cobertura de testes, ou antes de começar um novo módulo.

**O que você recebe**: Um relatório com:
- Total de módulos cobertos
- Quantidade de test cases por módulo
- Keywords reutilizáveis disponíveis
- Recomendações de melhoria

**Como usar**:
```
/analise-projeto
```

Ou em linguagem natural:
```
"Faça uma análise completa do projeto. 
Quais módulos do ERP já têm cobertura de testes?"
```

---

### 🆕 /criar-testcase — Criar Novo Test Case

**Quando usar**: Sempre que precisar criar um teste novo.

**O que a IA faz automaticamente**:
1. Verifica se o diretório do módulo já existe
2. Identifica a próxima numeração (Key\<Nome\>2.robot se já existe o 1)
3. Gera arquivo de Keywords com:
   - Todas as libraries e resources aplicáveis
   - Variáveis de imagem com nomenclatura correta
   - Keywords BDD em português
   - Queries SQL de validação baseadas nas tabelas do myCommerce
4. Gera arquivo de Test Cases com:
   - Suite Setup/Teardown configurados
   - Tags sequenciais
   - Referências corretas para as Keywords
5. Lista as imagens que precisam ser capturadas
6. Valida que os caminhos relativos estão corretos

**Como usar**:
```
/criar-testcase
```

Ou em linguagem natural:
```
"Crie testes para o módulo de Ordens de Entrega. 
Preciso testar: gerar OE a partir de venda, 
imprimir OE e cancelar OE."
```

---

### ▶️ /executar-testes — Executar Testes

**Quando usar**: Para executar testes e diagnosticar falhas.

**O que a IA faz**:
1. Verifica se os pré-requisitos estão instalados
2. Gera o comando correto para execução
3. Ajuda a interpretar resultados e falhas

**Como usar**:
```
/executar-testes
```

Ou em linguagem natural:
```
"Execute o Teste 03 do módulo de Condicional e 
me ajude a entender se passou ou falhou."
```

---

## 7. Utilizando as Skills

As skills são consultadas automaticamente pelo orquestrador, mas você pode invocá-las diretamente:

### 🔍 Análise de Código

```
"Analise o arquivo KeyCondicional1.robot. 
Quais keywords ele define? Quais queries SQL usa?"
```

```
"Liste todas as keywords de utils/utils.robot 
que eu posso reutilizar."
```

### 📚 Documentação de Frameworks

```
"Como uso o Wait Until Screen Contain do SikuliLibrary? 
Quais parâmetros aceita?"
```

```
"Como faço um FOR loop no Robot Framework que 
insere 5 produtos diferentes?"
```

### 📐 Padrões de Desenvolvimento

```
"Quais são as regras de nomenclatura de imagens neste projeto?"
```

```
"Como deve ser o Suite Setup de um arquivo de Test Case?"
```

### ⚙️ Geração de Test Cases

```
"Gere um template de Keywords para o módulo Financeiro/Boletos"
```

```
"Preciso de um teste que faça venda, 
depois devolução parcial, 
depois verifique o saldo no caixa."
```

---

## 8. Revisando o Código Gerado

Toda vez que a IA gerar código, revise estes pontos:

### Checklist de Revisão do Código Gerado

```
SETTINGS
✅ SikuliLibrary importada?
✅ ImageHorizonLibrary importada?
✅ DatabaseLibrary importada?
✅ Resource para utils.robot incluído?
✅ Resource para validacaoAviso.robot incluído?
✅ Variables para leituraConfig.py incluído?

VARIÁVEIS
✅ ${IMAGENS} aponta para ./Testes_BancoAleatorio/images?
✅ Variáveis de DB (Host, Name, Pass, Port, User) presentes?
✅ Sleep's padrão definidos (BAIXO=0.7, MEDIO=1.5, ALTO=3, TEMPO_TELA=25)?
✅ Variáveis de imagem com prefixo correto (TELA_, AVISO_, MODAL_, etc.)?
✅ Nomes das imagens .png correspondem ao que você vai capturar?

KEYWORDS
✅ 'Ler imagens iniciais' presente como primeira keyword?
✅ Nomes em BDD português (Dado/Quando/Então/E)?
✅ Sleep antes de combinações de tecla?
✅ Wait Until Screen Contain após navegar para outra tela?
✅ Namespacing usado para keywords ambíguas (Arquivo.Keyword)?

TEST CASES
✅ Documentation presente?
✅ Resource apontando para o arquivo de Keywords correto?
✅ Resource para parametros_pre_condicoes.robot incluído?
✅ Suite Setup com: Start Sikuli + Ler imagens + Conectar BD + Preparar Ambiente?
✅ Suite Teardown com: Stop Remote Server?
✅ Cada teste tem [Tags] sequencial (Teste01, Teste02...)?
✅ Testes apenas CHAMAM keywords (sem implementação direta)?

CAMINHOS
✅ Caminhos relativos ../../../ corretos para o nível de diretório?
✅ Diretórios espelhados entre KeyWords/ e TestsCases/?
```

### O que NÃO revisar

A IA cuida automaticamente de:
- ✳️ Formato de separação de colunas (4 espaços)
- ✳️ Ordem das seções (Settings → Variables → Keywords/TestCases)
- ✳️ Padrão de queries SQL
- ✳️ Estrutura de IF/FOR/TRY

---

## 9. Exemplos Reais de Prompts

### Exemplo 1 — Criar teste CRUD simples

**Prompt**:
```
Crie um teste completo para o módulo de Cadastro de Serviços do myCommerce.
O atalho para abrir é F9. 
A tabela no banco é 'servicos'.
Preciso testar: inclusão, edição, visualização e exclusão.
```

**O que a IA gera**:
- `KeyWords/Cadastro/Servicos/KeyServicos1.robot` com keywords para cada operação
- `TestsCases/Cadastro/Servicos/Teste_Servicos1.robot` com 4 test cases
- Lista de 6-8 imagens para capturar

---

### Exemplo 2 — Teste com cenário composto

**Prompt**:
```
Crie um teste que realize uma venda com 3 produtos, 
depois gere uma devolução parcial de 2 produtos, 
e valide no banco que o estoque foi atualizado corretamente.
Use o montadorDeCenarios para a venda inicial.
```

**O que a IA gera**:
- Keywords que utilizam `montadorDeCenarios.Dado que realizo uma venda com mais de um produto(3)`
- Keywords de devolução parcial usando `KeyDevolucaoVenda1`
- Validações SQL de estoque usando `libs/estoque.py`

---

### Exemplo 3 — Entender código existente

**Prompt**:
```
Analise o arquivo KeyCondicional1.robot e me explique:
1. Quais keywords ele exporta?
2. Quais queries SQL ele usa?
3. Quais imagens ele precisa?
```

**O que a IA retorna**:
- Lista detalhada de todas as keywords com descrição
- Cada query SQL explicada com seu propósito
- Todas as variáveis de imagem listadas

---

### Exemplo 4 — Expandir testes existentes

**Prompt**:
```
O módulo de Condicional já tem 8 testes.
Adicione mais 2 testes:
- Teste 09: Condicional com produto com desconto
- Teste 10: Condicional com múltiplos vendedores
```

**O que a IA gera**:
- Novas keywords se necessário (ou reutiliza existentes)
- 2 novos test cases com Tags Teste09 e Teste10
- Tudo já integrado com o arquivo existente

---

### Exemplo 5 — Dúvida sobre framework

**Prompt**:
```
Como eu faço para o SikuliLibrary tentar encontrar uma imagem 
por no máximo 5 segundos, e se não encontrar, 
continuar o teste sem falhar?
```

**O que a IA responde**:
```robot
${encontrou}    Run Keyword And Return Status    
...    Wait Until Screen Contain    ${IMAGEM}    5

IF    ${encontrou}
    # Faz algo se encontrou
ELSE
    Log To Console    Imagem não encontrada, continuando...
END
```

---

## 10. O que a IA Faz vs. O que Você Faz

### 🤖 A IA faz:

| Tarefa | Detalhes |
|---|---|
| Gerar código `.robot` | Keywords e Test Cases completos |
| Aplicar todas as convenções | Nomenclatura, BDD, prefixos, namespacing |
| Escolher keywords reutilizáveis | Busca em utils/ antes de criar novas |
| Gerar queries SQL | Baseado nas tabelas do myCommerce |
| Configurar Setup/Teardown | Sempre correto e completo |
| Definir variáveis de imagem | Com nomes corretos e prefixos |
| Listar imagens necessárias | Diz exatamente quais capturar |
| Diagnosticar falhas | Analisa logs e sugere correções |

### 👤 Você faz:

| Tarefa | Detalhes |
|---|---|
| **Descrever o que testar** | Em linguagem natural |
| **Capturar imagens .png** | A IA diz quais, você captura no myCommerce |
| **Revisar o código gerado** | Usar o [Checklist de Revisão](#8-revisando-o-código-gerado) |
| **Executar o teste** | Rodar o comando que a IA gera |
| **Dar foco na tela** | Clicar no myCommerce após iniciar |
| **Reportar falhas** | Descrever o erro para a IA corrigir |
| **Informar atalhos do ERP** | Se a IA não souber, diga qual tecla abre qual tela |

---

## 11. Depuração: Quando o Código Gerado Não Funciona

### Cenário 1: Imagem não encontrada

**O que aconteceu**: `Wait Until Screen Contain` deu timeout.

**O que fazer**:
```
"O teste falhou na keyword 'Dado que acesso a tela de serviços' 
com timeout de 25 segundos na imagem tela_Servicos.png. 
A imagem foi capturada mas o Sikuli não reconhece."
```

**A IA vai sugerir**:
- Re-capturar a imagem com recorte menor
- Verificar resolução (deve ser a mesma do teste)
- Verificar se a tela mudou após atualização do myCommerce

### Cenário 2: Aviso inesperado

**O que aconteceu**: Um popup apareceu e o teste não soube lidar.

**O que fazer**:
```
"Apareceu um aviso 'Deseja salvar as alterações?' 
que não era esperado entre o passo de edição e o de finalização.
Como trato esse aviso?"
```

**A IA vai**:
- Gerar keyword para tratar o aviso
- Atualizar o arquivo de Keywords
- Sugerir incluir tratamento em `validacaoAviso.robot` se for genérico

### Cenário 3: Dados do banco incorretos

**O que aconteceu**: Query SQL retornou vazio ou dados errados.

**O que fazer**:
```
"A query 'SELECT Codigo FROM servicos ORDER BY Codigo DESC LIMIT 1' 
retornou vazio. A tabela pode ter outro nome?"
```

**A IA vai**:
- Sugerir queries alternativas
- Verificar o esquema do banco
- Ajustar o código

### Cenário 4: Timing errado

**O que aconteceu**: A ação foi executada antes da tela carregar.

**O que fazer**:
```
"O teste clica em ALT+A antes da tela terminar de carregar. 
Precisa esperar mais."
```

**A IA vai**:
- Adicionar `Sleep` ou `Wait Until Screen Contain` antes da ação
- Ajustar timeouts

---

## 12. Dicas para Prompts Eficientes

### ✅ Bons Prompts

```
✅ "Crie um teste para vendas com produto com desconto de 10%, 
   finalizando com a forma de pagamento 30 DIAS."

✅ "Adicione ao módulo de Condicional um teste que gera 
   venda parcial de 2 de 5 produtos."

✅ "O teste 03 falhou com timeout na imagem tela_OS.png 
   no step 'Dado que acesso a tela de ordens de serviço'. 
   Como corrijo?"

✅ "Analise o montadorDeCenarios.robot e me diga quais 
   cenários compostos já existem para devolução."
```

### ❌ Prompts Ruins

```
❌ "Faz um teste"
   → Falta informação: teste de quê? Quais cenários?

❌ "Corrige o erro"
   → Qual erro? Em qual arquivo? Qual mensagem?

❌ "Refaz tudo"
   → A IA precisa saber O QUE refazer e POR QUÊ
```

### 💡 Dicas Gerais

1. **Seja específico** sobre o módulo, operações e cenários
2. **Informe atalhos** do myCommerce que você conhece
3. **Cole mensagens de erro** quando pedir correções
4. **Mencione dependências** (ex: "precisa de uma venda antes")
5. **Peça explicação** se não entender o código gerado

---

## 13. Checklist Rápido

Use esta checklist sempre que for criar um teste com IA:

```
ANTES DE COMEÇAR
□ Sei qual módulo/funcionalidade vou testar
□ Fiz o fluxo manualmente no myCommerce ao menos uma vez
□ Sei quais atalhos de teclado o módulo usa (ou vou descobrir)

GERANDO O CÓDIGO
□ Descrevi o que testar em linguagem natural
□ Respondi as perguntas da IA (atalhos, tabelas, etc.)
□ Recebi os dois arquivos: Keywords + Test Cases

REVISANDO
□ Passei pelo Checklist de Revisão (Seção 8)
□ Verifiquei que os caminhos relativos estão corretos
□ Confirmei nomes de tabelas do banco de dados

CAPTURANDO IMAGENS
□ Li a lista de imagens que a IA gerou
□ Capturei CADA imagem listada no myCommerce
□ Salvei em Testes_BancoAleatorio/images/
□ Usei EXATAMENTE os nomes que a IA indicou
□ Salvei como PNG (nunca JPG)
□ Capturei na resolução correta (1920x1080)

EXECUTANDO
□ Executei o teste isoladamente com tag (-i Teste01)
□ Cliquei na tela do myCommerce após iniciar
□ Se falhou: descrevi o erro para a IA e iterei
□ Se passou: executei junto com os demais testes
```

---

## 14. Comparação: Manual vs. Automatizado

### Criando um teste de CRUD (4 operações)

| Etapa | Manual | Com IA |
|---|---|---|
| Identificar módulo | 5 min | 5 min |
| Fluxo manual no ERP | 10 min | 10 min |
| Criar estrutura de diretórios | 2 min | ⚡ Automático |
| Configurar Settings/Variables | 10 min | ⚡ Automático |
| Escrever keywords (4 operações) | 30 min | ⚡ Automático (~30 seg) |
| Escrever test cases | 10 min | ⚡ Automático (~10 seg) |
| Capturar imagens | 15 min | 15 min |
| Configurar Setup/Teardown | 5 min | ⚡ Automático |
| Revisar e validar | 5 min | 5 min |
| **Total** | **~90 min** | **~35 min** |

### Onde a IA mais ajuda

```
⭐ Gerar código que segue TODOS os padrões
⭐ Reutilizar keywords existentes sem precisar procurar
⭐ Gerar queries SQL corretas para as tabelas do myCommerce
⭐ Aplicar namespacing e convenções de nomes automaticamente
⭐ Diagnosticar falhas rapidamente
⭐ Expandir testes existentes mantendo consistência
```

### Onde VOCÊ continua essencial

```
🧑 Capturar imagens das telas do ERP
🧑 Conhecer o fluxo de negócio (o que testar)
🧑 Confirmar que o ERP está aberto e com foco
🧑 Tomar decisões de negócio (quais cenários priorizar)
🧑 Validar visualmente que o teste faz o que deveria
```

---

## 🎯 Resumo Final

| Pergunta | Resposta |
|---|---|
| **Onde fica o sistema de agentes?** | `.agent/` na raiz do projeto |
| **Vai para o GitHub?** | Não, está no `.gitignore` |
| **Como crio um teste novo?** | `/criar-testcase` ou descreva em linguagem natural |
| **Como analiso o projeto?** | `/analise-projeto` |
| **Como executo testes?** | `/executar-testes` |
| **Ainda preciso capturar imagens?** | Sim, a IA gera o código mas você captura as .png |
| **Preciso saber Robot Framework?** | Básico para revisão — a IA gera o código |
| **E se o teste falhar?** | Descreva o erro para a IA, ela sugere correções |
| **Posso expandir testes existentes?** | Sim, peça à IA e ela mantém a consistência |
| **Funciona offline?** | A estrutura `.agent/` é local, mas precisa do IDE com IA |

---

> 📝 **Dica Final**: O sistema de agentes é um **acelerador**, não um substituto. Você continua sendo responsável por conhecer o fluxo de negócio, capturar imagens e validar os resultados. A IA cuida da parte repetitiva e garante que os padrões do projeto sejam sempre seguidos!

> 🔗 **Referência**: Para entender COMO tudo funciona internamente (sem IA), consulte o guia [comoDesenvolver.md](./comoDesenvolver.md).
