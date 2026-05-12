# 📖 Como Desenvolver Testes Automatizados — Guia Completo

> **Objetivo**: Este guia ensina, passo a passo, como criar um teste automatizado no projeto **mycommerce-automacao**. Foi escrito para que qualquer pessoa — mesmo sem experiência prévia em programação — consiga entrar no projeto e começar a desenvolver.

---

## 📋 Índice

1. [Visão Geral do Projeto](#1-visão-geral-do-projeto)
2. [Pré-Requisitos](#2-pré-requisitos)
3. [Entendendo a Estrutura de Pastas](#3-entendendo-a-estrutura-de-pastas)
4. [Conceitos Fundamentais](#4-conceitos-fundamentais)
5. [Passo a Passo: Criando um Teste do Zero](#5-passo-a-passo-criando-um-teste-do-zero)
6. [Como Capturar Imagens para o Sikuli](#6-como-capturar-imagens-para-o-sikuli)
7. [Criando o Arquivo de Keywords](#7-criando-o-arquivo-de-keywords)
8. [Criando o Arquivo de Test Case](#8-criando-o-arquivo-de-test-case)
9. [Reutilizando Keywords Existentes](#9-reutilizando-keywords-existentes)
10. [Convenções de Nomenclatura](#10-convenções-de-nomenclatura)
11. [Como Executar os Testes](#11-como-executar-os-testes)
12. [Depuração: O que Fazer Quando um Teste Falha](#12-depuração-o-que-fazer-quando-um-teste-falha)
13. [Checklist Rápido](#13-checklist-rápido)
14. [Exemplos Reais do Projeto](#14-exemplos-reais-do-projeto)

---

## 1. Visão Geral do Projeto

Este projeto automatiza testes no sistema ERP desktop **myCommerce** usando reconhecimento visual de imagens. Em vez de interagir com elementos HTML (como em testes web), a automação **tira prints de pedaços da tela** e usa esses prints para localizar botões, campos e janelas no sistema.

### Tecnologias Utilizadas

| Tecnologia | Para quê serve |
|---|---|
| **Robot Framework** | Linguagem de automação de testes (arquivos `.robot`) |
| **SikuliLibrary** | Reconhecimento visual — encontra imagens na tela e clica nelas |
| **ImageHorizonLibrary** | Pressionar teclas especiais e combinações de teclas |
| **DatabaseLibrary** | Consultar e validar dados diretamente no banco de dados MySQL |
| **FakerLibrary** | Gerar dados aleatórios (nomes, CPFs, etc.) |
| **Python** | Bibliotecas auxiliares de validação |

### Como funciona na prática

```
1. O teste abre o myCommerce
2. Usa imagens .png para RECONHECER elementos na tela (telas, botões, campos)
3. Clica, digita e navega usando essas imagens como referência
4. Valida no banco de dados se a operação foi registrada corretamente
```

---

## 2. Pré-Requisitos

Antes de começar, certifique-se de ter instalado:

```bash
# Python 3.9.13 ou superior
python --version

# Instalar as dependências
pip install robotframework
pip install robotframework-SikuliLibrary
pip install robotframework-imagehorizonlibrary
pip install robotframework-faker
pip install robotframework-databaselibrary
pip install mysql-connector-python
pip install pymysql
```

> ⚠️ **IMPORTANTE**: Configure o Python Path no VS Code. Vá em Settings do VS Code e edite o Python Path para apontar para as libs Python do projeto com `\\` no caminho.

**Também é necessário:**
- VS Code (editor de código)
- Java (necessário para o Sikuli funcionar)
- Acesso ao banco de dados MySQL do myCommerce

---

## 3. Entendendo a Estrutura de Pastas

```
mycommerce-automacao/
├── Executar_Automacao.py          ← Script que roda TODOS os testes em sequência
├── readme.md                      ← Documentação básica
│
└── Testes_BancoAleatorio/         ← PASTA PRINCIPAL DO PROJETO
    │
    ├── images/                    ← 🖼️ TODAS as imagens .png ficam AQUI
    │   ├── tela_LoginSistema.png
    │   ├── tela_Condicionais.png
    │   ├── aviso_DesejaExcluir.png
    │   ├── bt_FecharX.png
    │   ├── lb_CodCliente.png
    │   └── ... (149+ imagens)
    │
    ├── KeyWords/                  ← 🔧 KEYWORDS (as ações/passos do teste)
    │   ├── Login/
    │   │   └── KeyLoginSistema1.robot
    │   ├── Comercial/
    │   │   ├── Condicional/
    │   │   │   └── KeyCondicional1.robot
    │   │   ├── Vendas/
    │   │   │   └── keyVendas1.robot
    │   │   ├── Devolucao/
    │   │   ├── Doacao/
    │   │   ├── Orcamento/
    │   │   └── Ordem de Servico/
    │   ├── Financeiro/
    │   ├── Descontos/
    │   ├── Emissão/
    │   ├── Faturamento/
    │   ├── MyMonitorFaturamento/
    │   └── Pré-Venda/
    │
    ├── TestsCases/                ← 🧪 TEST CASES (os testes em si)
    │   ├── Login/
    │   │   └── Teste_LoginSistema1.robot
    │   ├── Comercial/
    │   │   ├── Condicional/
    │   │   │   └── Teste_Condicional1.robot
    │   │   ├── Vendas/
    │   │   ├── Devolucao/
    │   │   ├── Orcamentos/
    │   │   └── Ordem de Servico/
    │   ├── Financeiro/
    │   └── ... (espelha KeyWords/)
    │
    ├── utils/                     ← 🛠️ KEYWORDS COMPARTILHADAS
    │   ├── utils.robot            ← Keywords genéricas (inserir produto, selecionar cliente, etc.)
    │   ├── validacaoAviso.robot   ← Tratamento de avisos/popups do sistema
    │   ├── montadorDeCenarios.robot ← Cenários compostos (venda completa, devolução, etc.)
    │   ├── parametros_pre_condicoes.robot ← Preparação do ambiente
    │   ├── parametros_admin_sistema.robot ← Config de admin do sistema
    │   └── myCommerce.robot       ← Abrir/fechar o myCommerce
    │
    └── libs/                      ← 🐍 BIBLIOTECAS PYTHON
        ├── validaParametros.py    ← Valida configurações do ERP
        ├── validaComissoes.py     ← Valida cálculos de comissão
        ├── estoque.py             ← Valida movimentação de estoque
        ├── verificacoesExtras.py  ← Verificações auxiliares
        └── leituraConfig.py       ← Lê configuração de conexão com o BD
```

### Regra de Ouro: Separação entre Keywords e TestCases

```
TestsCases/ → DEFINE O QUE testar (cenários)
KeyWords/   → DEFINE COMO executar cada passo
```

O **TestCase** chama as **Keywords**. As Keywords fazem o trabalho pesado (clicar, digitar, validar). Essa separação permite reutilizar keywords em múltiplos testes.

---

## 4. Conceitos Fundamentais

### 4.1 Estrutura de um Arquivo `.robot`

Todo arquivo `.robot` tem até 4 seções:

```robot
*** Settings ***
# Imports de bibliotecas e resources
Library    SikuliLibrary
Resource   ../../utils/utils.robot

*** Variables ***
# Declaração de variáveis (imagens, configurações)
${TELA_EXEMPLO}    tela_Exemplo.png

*** Test Cases ***
# Apenas em arquivos de TEST CASE
Nome Do Teste
    Keyword Um
    Keyword Dois

*** Keywords ***
# Apenas em arquivos de KEYWORD
Nome Da Keyword
    # Passos da keyword
```

### 4.2 Como o Sikuli Encontra Elementos na Tela

O Sikuli funciona assim:

```
1. Você captura um pedaço da tela (screenshot recortado) → salva como .png
2. No código, cria uma variável apontando para esse .png
3. No teste, usa keywords como "Click" ou "Wait Until Screen Contain" com essa variável
4. O Sikuli procura na tela inteira por algo que se pareça com aquele .png
5. Quando encontra → clica, espera, ou valida
```

### 4.3 Separador de Colunas no Robot Framework

O Robot Framework usa **2 ou mais espaços** como separador entre argumentos. A convenção do projeto é usar **4 espaços**.

```robot
# ✅ CORRETO (4 espaços entre keyword e argumento)
Click    ${BOTAO}
Wait Until Screen Contain    ${TELA}    25

# ❌ ERRADO (1 espaço — seria interpretado como parte do nome)
Click ${BOTAO}
```

### 4.4 Tipos de Variáveis

```robot
${VARIAVEL}     ← Variável escalar (texto, número)
@{LISTA}        ← Lista
&{DICIONARIO}   ← Dicionário (chave=valor)
```

---

## 5. Passo a Passo: Criando um Teste do Zero

Vamos criar um teste para um módulo fictício chamado **"Cadastro de Clientes"**. Siga cada passo na ordem.

### Passo 1: Identifique o Módulo

Pergunte-se:
- O módulo já existe em `KeyWords/` e `TestsCases/`?
- Se **SIM** → crie novos arquivos dentro da pasta existente
- Se **NÃO** → crie uma nova pasta para o módulo

Para o nosso exemplo, "Cadastro de Clientes" não existe, então:

```
Criar: KeyWords/Cadastro/Clientes/KeyClientes1.robot
Criar: TestsCases/Cadastro/Clientes/Teste_Clientes1.robot
```

### Passo 2: Mapeie o Fluxo Manual

Antes de automatizar, faça o processo **manualmente** no myCommerce e anote:

```
1. Qual tecla/menu abre a tela? (F2, F3, F11...?)
2. Que tela aparece ao abrir?
3. Quais campos preciso preencher?
4. Quais botões preciso clicar?
5. Quais avisos/popups podem aparecer?
6. Como confirmo que a operação foi feita? (tela que aparece, dado no banco, etc.)
```

### Passo 3: Capture as Imagens Necessárias

Veja a [Seção 6](#6-como-capturar-imagens-para-o-sikuli) para instruções detalhadas.

### Passo 4: Crie o Arquivo de Keywords

Veja a [Seção 7](#7-criando-o-arquivo-de-keywords) para instruções detalhadas.

### Passo 5: Crie o Arquivo de Test Case

Veja a [Seção 8](#8-criando-o-arquivo-de-test-case) para instruções detalhadas.

### Passo 6: Execute e Valide

Veja a [Seção 11](#11-como-executar-os-testes) para instruções de execução.

---

## 6. Como Capturar Imagens para o Sikuli

Esta é a parte **mais importante** do processo. A qualidade das imagens determina se o teste vai funcionar ou não.

### 6.1 Ferramenta de Captura

Use a **Ferramenta de Recorte do Windows** (Snipping Tool) ou **Win + Shift + S**:

1. Abra o myCommerce e navegue até a tela desejada
2. Pressione `Win + Shift + S` (ou abra a Ferramenta de Recorte)
3. Selecione **apenas o elemento que você quer capturar** (ver regras abaixo)
4. Salve como `.png`

### 6.2 O que Capturar e Como Recortar

#### Capturando uma **TELA** (para reconhecer que uma janela abriu)

Capture **apenas a barra de título da janela**, incluindo o nome/título da tela. Não capture a janela inteira — apenas o suficiente para identificá-la de forma única.

```
┌─────────────────────────────────────────┐
│ ╔═══════════════════════════════╗       │  ← Capture APENAS esta região
│ ║  📋 Condicionais             ║       │     (barra de título com o nome)
│ ╚═══════════════════════════════╝       │
│                                         │
│   [campos e dados da tela]              │  ← NÃO capture isso
│                                         │
└─────────────────────────────────────────┘
```

**Por que?** Se capturar a tela inteira, qualquer mudança no conteúdo (dados diferentes) fará o Sikuli não reconhecer a imagem.

#### Capturando um **BOTÃO**

Capture o botão inteiro, incluindo bordas:

```
╔═══════════╗
║ Confirmar  ║  ← Capture assim, com bordas visíveis
╚═══════════╝
```

#### Capturando um **CAMPO/INPUT** (label ao lado do campo)

Capture o **label** (rótulo) ao lado do campo, não o campo em si:

```
    Código Cliente: [________]
    ^^^^^^^^^^^^^^^
    Capture ESTE label, pois o campo pode mudar de conteúdo
```

#### Capturando um **AVISO/MODAL**

Capture o texto **mais específico** do aviso, sem capturar dados variáveis:

```
┌─────────────────────────────────────┐
│  ⚠️ Deseja realmente excluir       │  ← Capture esta linha de texto
│     este registro?                   │
│                                      │
│    [Sim]        [Não]               │
└─────────────────────────────────────┘
```

#### Capturando uma **ROW** (linha de confirmação no grid)

Capture um pedaço da linha que confirma a inclusão (ex: ícone de check ou indicador visual):

```
│ ✓ │ Produto ABC │ 1 │ R$ 10,00 │
  ^
  Capture apenas o indicador de inclusão
```

### 6.3 Regras de Ouro para Capturas

| Regra | Motivo |
|---|---|
| ✅ Capture a **menor área possível** que identifique o elemento | Menos chance de erro por variação |
| ✅ Capture **elementos estáticos** (títulos, labels, ícones) | Dados mudam, labels não |
| ❌ **NÃO** capture dados variáveis (números, nomes, valores) | Mudam a cada execução |
| ❌ **NÃO** capture com scroll parcial | A posição muda |
| ✅ Capture na **mesma resolução** que o teste vai rodar | 1920x1080 é o padrão |
| ✅ Salve sempre como **PNG** (nunca JPG) | JPG perde qualidade e o Sikuli não reconhece |

### 6.4 Onde Salvar as Imagens

**TODAS** as imagens devem ser salvas em:

```
Testes_BancoAleatorio/images/
```

> ⚠️ Este é o **ÚNICO** diretório de imagens. Não crie subpastas. Todas as imagens ficam na raiz de `images/`.

### 6.5 Como Nomear as Imagens

Siga estas convenções de nomenclatura rigorosamente:

| Tipo de Elemento | Prefixo | Exemplo |
|---|---|---|
| Tela / Janela | `tela_` | `tela_CadastroClientes.png` |
| Modal / Popup | `modal_` | `modal_ConfirmarExclusao.png` |
| Aviso / Alerta | `aviso_` | `aviso_DesejaExcluir.png` |
| Botão | `bt_` | `bt_Confirmar.png` |
| Label / Rótulo | `lb_` | `lb_CodigoCliente.png` |
| Input / Campo | `input_` | `input_NomeCliente.png` |
| Linha de grid | `row_` | `row_ProdutoIncluso.png` |
| Aba | `aba_` | `aba_Pagamentos.png` |
| Ícone | `icone_` | `icone_UsuarioVisual.png` |

**Padrão de nome**: `prefixo_NomeDescritivoEmCamelCase.png`

### 6.6 Exemplo Prático de Captura

Suponha que você vai automatizar o fluxo de cadastro de clientes:

```
Imagens necessárias:
1. tela_CadastroClientes.png        ← Barra de título da tela
2. tela_CadastroClientesAdicionar.png ← Barra de título ao clicar em Adicionar
3. lb_CodCliente.png                ← Label "Código" ao lado do campo (se já não existir)
4. lb_NomeCliente.png               ← Label "Nome" ao lado do campo
5. row_ClienteIncluso.png           ← Indicador visual de que o cliente foi salvo
6. aviso_ClienteJaExiste.png        ← Texto do aviso (se aplicável)
```

---

## 7. Criando o Arquivo de Keywords

O arquivo de Keywords é onde **vive toda a lógica do teste**. Aqui você define cada passo que o teste vai executar.

### 7.1 Estrutura Obrigatória

Crie o arquivo em: `Testes_BancoAleatorio/KeyWords/<Módulo>/<SubMódulo>/Key<Nome>1.robot`

```robot
*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../../libs/verificacoesExtras.py

Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot

*** Variables ***
# Repositório de Imagens (SEMPRE este caminho)
${IMAGENS}                  ./Testes_BancoAleatorio/images

# Conexão com o Banco de Dados (SEMPRE estas variáveis)
${DBHost}                   ${config.IpServidor}
${DBName}                   ${config.Database}
${DBPass}                   vssql
${DBPort}                   ${config.Porta}
${DBUser}                   root

# Sleep's (SEMPRE estes valores padrão)
${SLEEP_BAIXO}              0.7
${SLEEP_MEDIO}              1.5
${SLEEP_ALTO}               3
${TEMPO_TELA}               25

# ═══════════════════════════════════════════════
# Suas variáveis de imagem ficam AQUI
# ═══════════════════════════════════════════════

# Telas
${TELA_CADASTRO_CLIENTES}           tela_CadastroClientes.png
${TELA_CADASTRO_CLIENTES_ADICIONAR} tela_CadastroClientesAdicionar.png

# Avisos
${AVISO_CLIENTE_JA_EXISTE}          aviso_ClienteJaExiste.png

# Labels/Inputs
${LB_NOME_CLIENTE}                  lb_NomeCliente.png

# Rows
${ROW_CLIENTE_INCLUSO}              row_ClienteIncluso.png

*** Keywords ***
# ═══════════════════════════════════════════════
# KEYWORD OBRIGATÓRIA: Ler imagens iniciais
# ═══════════════════════════════════════════════
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

# ═══════════════════════════════════════════════
# Suas keywords ficam AQUI
# Use nomes descritivos em português, estilo BDD
# ═══════════════════════════════════════════════

Dado que acesso a tela de cadastro de clientes

    # Pressiona a tecla de atalho para abrir o cadastro
    Press Special Key    F5

    # Espera a tela abrir (usa a imagem para confirmar)
    Wait Until Screen Contain    ${TELA_CADASTRO_CLIENTES}    ${TEMPO_TELA}

E adiciono um novo cliente

    Sleep    ${SLEEP_BAIXO}

    # Clica no botão Adicionar (atalho ALT+A)
    Press Combination    KEY.ALT    KEY.A

    # Espera a tela de adição abrir
    Wait Until Screen Contain    ${TELA_CADASTRO_CLIENTES_ADICIONAR}    ${TEMPO_TELA}

Quando preencho os dados do cliente

    # Clica no campo Nome usando a imagem do label como referência
    SikuliLibrary.Click    ${LB_NOME_CLIENTE}
    Sleep    ${SLEEP_BAIXO}

    # Digita o nome
    Input Text    ${EMPTY}    Cliente Teste Automação
    Sleep    ${SLEEP_BAIXO}

    # Avança para o próximo campo
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

Então salvo o cadastro

    # Finaliza/Grava (atalho ALT+G ou ALT+F dependendo da tela)
    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}

    # Confirma que voltou para a tela de listagem
    Wait Until Screen Contain    ${TELA_CADASTRO_CLIENTES}    ${TEMPO_TELA}
```

### 7.2 Keywords Mais Usadas — Referência Rápida

#### Interação Visual (SikuliLibrary)

```robot
# Esperar uma tela/elemento aparecer (com timeout em segundos)
Wait Until Screen Contain    ${IMAGEM}    25

# Verificar se uma imagem está na tela
Screen Should Contain    ${IMAGEM}

# Verificar se uma imagem NÃO está na tela
Screen Should Not Contain    ${IMAGEM}

# Clicar em uma imagem
SikuliLibrary.Click    ${IMAGEM}

# Duplo clique em uma imagem
SikuliLibrary.Double Click    ${IMAGEM}

# Verificar se existe (retorna True/False sem falhar)
${existe}    Exists    ${IMAGEM}

# Digitar texto no campo atualmente focado
Input Text    ${EMPTY}    texto para digitar

# Alternativa para digitar
Type    ${EMPTY}    texto para digitar
```

> ⚠️ Use `SikuliLibrary.Click` (com prefixo) para evitar conflitos com outras bibliotecas que também têm keyword `Click`.

#### Teclas e Atalhos (ImageHorizonLibrary)

```robot
# Teclas especiais
Press Special Key    ENTER
Press Special Key    TAB
Press Special Key    ESC
Press Special Key    F1
Press Special Key    F5
Press Special Key    F11
Press Special Key    SPACE

# Combinações de teclas (atalhos do myCommerce)
Press Combination    KEY.ALT    KEY.A    # Adicionar
Press Combination    KEY.ALT    KEY.E    # Editar
Press Combination    KEY.ALT    KEY.x    # Excluir
Press Combination    KEY.ALT    KEY.G    # Gravar/Gerar
Press Combination    KEY.ALT    KEY.F    # Finalizar
Press Combination    KEY.ALT    KEY.D    # Detalhes
Press Combination    KEY.ALT    KEY.S    # Sim/Confirmar
Press Combination    KEY.ALT    KEY.N    # Não
Press Combination    KEY.ALT    KEY.U    # Visualizar
Press Combination    KEY.ALT    KEY.P    # Produto
Press Combination    KEY.ALT    KEY.r    # Retornar
Press Combination    KEY.ALT    KEY.I    # Incluir
Press Combination    KEY.ALT    KEY.C    # Confirmar
```

#### Banco de Dados (DatabaseLibrary)

```robot
# Executar uma consulta SELECT
${resultado}    Query    SELECT Codigo FROM clientes ORDER BY Codigo DESC LIMIT 1;

# Acessar o resultado (lista de tuplas)
${valor}    Set Variable    ${resultado[0][0]}

# Verificar se registro existe no banco
Check If Exists In Database    SELECT * FROM clientes WHERE Codigo = 123;

# Verificar se registro NÃO existe
Check If Not Exists In Database    SELECT * FROM clientes WHERE Status = 'x';

# Executar INSERT, UPDATE ou DELETE
Execute Sql String    UPDATE config SET parametro = 1;
```

#### Controle de Fluxo

```robot
# Sleep (esperar entre ações)
Sleep    ${SLEEP_BAIXO}     # 0.7 segundos
Sleep    ${SLEEP_MEDIO}     # 1.5 segundos
Sleep    ${SLEEP_ALTO}      # 3 segundos

# Variáveis de teste
Set Test Variable    ${MINHA_VAR}    valor

# IF/ELSE
IF    ${condicao}
    Keyword A
ELSE
    Keyword B
END

# FOR loop
FOR    ${item}    IN RANGE    5
    Log    Iteração: ${item}
END

# Executar keyword e pegar status (sem falhar o teste)
${sucesso}    Run Keyword And Return Status    Wait Until Screen Contain    ${IMAGEM}    ${SLEEP_ALTO}
```

---

## 8. Criando o Arquivo de Test Case

O Test Case é o arquivo que **orquestra a execução** chamando as keywords na ordem correta.

### 8.1 Estrutura Obrigatória

Crie o arquivo em: `Testes_BancoAleatorio/TestsCases/<Módulo>/<SubMódulo>/Teste_<Nome>1.robot`

```robot
*** Settings ***
Documentation    Testes de Cadastro de Clientes

Resource    ../../../KeyWords/Cadastro/Clientes/KeyClientes1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    KeyClientes1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Cadastro de novo cliente
    [Tags]    Teste01

    Dado que acesso a tela de cadastro de clientes
    E adiciono um novo cliente
    Quando preencho os dados do cliente
    Então salvo o cadastro

Teste 02 - Edição de cliente existente
    [Tags]    Teste02

    Dado que acesso a tela de cadastro de clientes
    E seleciono um cliente existente
    Quando edito os dados do cliente
    Então salvo as alterações

Teste 03 - Exclusão de cliente
    [Tags]    Teste03

    Dado que acesso a tela de cadastro de clientes
    E seleciono um cliente existente
    Então excluo o cliente
```

### 8.2 Elementos Obrigatórios do Test Case

| Elemento | O que é | Exemplo |
|---|---|---|
| `Resource` para Keywords | Import do arquivo de keywords do módulo | `Resource    ../../../KeyWords/.../KeyNome1.robot` |
| `Resource` para pré-condições | Import do preparador de ambiente | `Resource    ../../../utils/parametros_pre_condicoes.robot` |
| `Suite Setup` | Executa ANTES de todos os testes | `Start Sikuli Process` + `Ler imagens iniciais` + `Conectar ao Banco de Dados` + `Preparar Ambiente MyCommerce` |
| `Suite Teardown` | Executa DEPOIS de todos os testes | `Stop Remote Server` |
| `[Tags]` | Tag para executar testes individualmente | `[Tags]    Teste01` |

### 8.3 Padrão de Nomes dos Testes

```
Teste XX - Descrição curta da ação
```

Exemplos:
```
Teste 01 - Cadastro de novo cliente
Teste 02 - Edição de cliente existente
Teste 03 - Exclusão de cliente
Teste 04 - Visualização de cliente
Teste 05 - Busca por nome do cliente
```

### 8.4 Nomenclatura BDD para Keywords

O projeto usa o estilo **BDD (Dado/Quando/Então)**:

```robot
# Prefixos usados:
Dado que ...      # Pré-condição / setup da ação
E ...             # Passo adicional (and)
Quando ...        # Ação principal
Então ...         # Verificação / resultado esperado
```

---

## 9. Reutilizando Keywords Existentes

Antes de criar uma keyword nova, verifique se ela já existe nos arquivos `utils/`:

### Keywords Prontas em `utils/utils.robot`

| Keyword | O que faz | Como usar |
|---|---|---|
| `Adicionar Vendedor e Cliente(${TELA})` | Seleciona vendedor e cliente aleatórios do banco | `utils.Adicionar Vendedor e Cliente(Venda)` |
| `Inserir Produto normal - Necessita de estoque` | Insere produto aleatório com estoque | `utils.Inserir Produto normal - Necessita de estoque` |
| `Inserir Produto normal - Permite sem estoque` | Insere produto aleatório sem checar estoque | `utils.Inserir Produto normal - Permite sem estoque` |
| `E saio da tela(${TELA})` | Fecha a tela atual e volta ao menu | `E saio da tela(Condicional)` |
| `Valida solicitação de senha do usuário supervisor` | Trata popup de senha de supervisor | `utils.Valida solicitação de senha do usuário supervisor` |
| `Valida parametros após incluir produto` | Valida parâmetros pós-inclusão de produto | `utils.Valida parametros após incluir produto` |
| `Seleciona vendedor` | Seleciona vendedor aleatório do banco | `${cod}    Seleciona vendedor` |
| `Seleciona cliente` | Seleciona cliente aleatório do banco | `${cod}    Seleciona cliente` |

### Keywords Prontas em `utils/montadorDeCenarios.robot`

Cenários completos prontos para uso:

```robot
Dado que realizo uma venda completa, com produto normal
Dado que realizo um pedido, com produto normal
Dado que realizo uma devolução completa da venda
```

### Keywords Prontas em `utils/validacaoAviso.robot`

```robot
Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})
Valida impressao direta de venda(${Parametro})
Valida indicação de venda(${Parametro})
Carregar parâmetros do sistema
```

### Como Referenciar Keywords de Outros Arquivos

Quando duas keywords têm o **mesmo nome** em arquivos diferentes, use o prefixo:

```robot
# Prefixo com o nome do arquivo de keyword
KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
keyVendas1.E acesso a aba pagamentos
utils.E saio da tela(Venda)
validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})
```

---

## 10. Convenções de Nomenclatura

### Arquivos

| Tipo | Padrão | Exemplo |
|---|---|---|
| Keyword | `Key<NomeModulo>1.robot` | `KeyCondicional1.robot` |
| Test Case | `Teste_<NomeModulo>1.robot` | `Teste_Condicional1.robot` |
| Imagem | `prefixo_NomeCamelCase.png` | `tela_Condicionais.png` |

### Variáveis de Imagem

```robot
# Padrão: ${TIPO_NOME_DESCRITIVO}    arquivo.png

# Telas
${TELA_CONDICIONAIS}                tela_Condicionais.png
${TELA_ADICIONAR_CONDICIONAL}       tela_CondicionaisAdicionar.png

# Avisos
${AVISO_DESEJA_EXCLUIR}             aviso_DesejaExcluir.png

# Modais
${MODAL_GERAR_VENDA_CONDICIONAL}    modal_GerarVendaCondicional.png

# Botões
${BT_CONFIRMAR}                     bt_Confirmar.png

# Labels
${LABEL_CODIGO_EMPRESA}             lb_CodigoEmpresa.png

# Inputs
${INPUT_COD_CLIENTE}                lb_CodCliente.png

# Rows
${ROW_PROD_INCLUSO}                 row_ProdIncluso.png
```

### Variáveis de Configuração

```robot
# Sleep's (tempos de espera) — sempre os mesmos valores
${SLEEP_BAIXO}     0.7
${SLEEP_MEDIO}     1.5
${SLEEP_ALTO}      3
${TEMPO_TELA}      25

# Banco de Dados — sempre a mesma estrutura
${DBHost}          ${config.IpServidor}
${DBName}          ${config.Database}
${DBPass}          vssql
${DBPort}          ${config.Porta}
${DBUser}          root
```

---

## 11. Como Executar os Testes

### Executar Todos os Testes de um Arquivo

```bash
# A partir da raiz do projeto (Testes_BancoAleatorio/)
robot -d ./results ./TestsCases/Comercial/Condicional/Teste_Condicional1.robot
```

### Executar Apenas um Teste Específico (por tag)

```bash
# Executa apenas o teste com [Tags] Teste01
robot -d ./results -i Teste01 ./TestsCases/Comercial/Condicional/Teste_Condicional1.robot
```

### Executar Apenas um Teste Específico (por nome)

```bash
robot -d ./results --test "Teste 01 - Lançamento de condicional" ./TestsCases/Comercial/Condicional/Teste_Condicional1.robot
```

### Executar Todos os Testes do Projeto (automatizado)

```bash
# Usa o script Python que gerencia login, falhas e relatórios
python Executar_Automacao.py
```

> ⚠️ **IMPORTANTE**: Após pressionar ENTER para rodar um teste, **clique na tela do myCommerce** para garantir que o foco esteja nele. Caso contrário, o teste pode falhar porque o Sikuli tenta interagir com outra janela.

### Onde Ficam os Resultados

```
./results/            ← Resultados do último teste executado manualmente
├── log.html          ← Log detalhado com screenshots
├── report.html       ← Relatório resumido (PASS/FAIL)
└── output.xml        ← Dados brutos do resultado

Relatorios/           ← Resultados quando rodados via Executar_Automacao.py
└── YYYY-MM-DD_HH-MM-SS/
    ├── Resultados Finais/
    │   ├── log.html
    │   └── report.html
    └── sikuli_java/
```

---

## 12. Depuração: O que Fazer Quando um Teste Falha

### Passo 1: Leia o Log

Abra `results/log.html` no navegador. O log mostra:
- Cada keyword executada
- Screenshot do momento da falha
- Mensagem de erro detalhada

### Passo 2: Identifique o Tipo de Falha

| Tipo de Falha | Sintoma | Solução |
|---|---|---|
| **Imagem não encontrada** | `Wait Until Screen Contain` timeout | Re-capture a imagem na resolução correta |
| **Elemento em posição errada** | Clicou no lugar errado | Verifique se a imagem tem elementos únicos suficientes |
| **Aviso inesperado** | Popup apareceu e bloqueou | Adicione tratamento para o aviso em `validacaoAviso.robot` |
| **Dados do banco** | Query não retorna resultados | Verifique se o banco tem os dados necessários |
| **Timing** | Ação executada rápido demais | Aumente o `Sleep` antes da ação |
| **Foco da janela** | Teclas foram para outra janela | Adicione um `Click` na tela antes da ação |

### Passo 3: Isole o Teste

Não execute todos os testes — rode apenas o que falhou:

```bash
# Se foi o Teste 07 que falhou, rode apenas ele:
robot -d ./results -i Teste07 ./TestsCases/.../arquivo.robot
```

### Passo 4: Faça Manualmente

Execute o mesmo fluxo manualmente no myCommerce para verificar se:
- O sistema mudou (atualização?)
- Há dados faltando no banco
- Algum popup novo apareceu

### Passo 5: Verifique as Imagens

Se o problema é de reconhecimento visual:
1. Abra a imagem em `images/`
2. Compare com o que aparece na tela
3. Se estiver diferente, **re-capture** a imagem
4. Salve com o **mesmo nome** para substituir

---

## 13. Checklist Rápido

Use esta checklist sempre que for criar um novo teste:

```
PREPARAÇÃO
□ Identifiquei o módulo/funcionalidade a testar
□ Executei o fluxo manualmente e anotei os passos
□ Verifiquei se já existem keywords reutilizáveis em utils/

IMAGENS
□ Capturei todas as telas necessárias
□ Capturei avisos/popups que podem aparecer
□ Capturei labels e campos necessários
□ Salvei TODAS as imagens em Testes_BancoAleatorio/images/
□ Nomeei as imagens seguindo o padrão: prefixo_NomeCamelCase.png
□ Salvei como PNG (nunca JPG)
□ Capturei na mesma resolução que o teste vai rodar

ARQUIVO DE KEYWORDS
□ Criei em KeyWords/<Módulo>/<SubMódulo>/Key<Nome>1.robot
□ Incluí todas as Libraries necessárias (SikuliLibrary, ImageHorizonLibrary, etc.)
□ Incluí Resource para utils.robot e validacaoAviso.robot
□ Defini as variáveis de imagem (${TELA_...}, ${AVISO_...}, etc.)
□ Criei a keyword "Ler imagens iniciais" com Add Image Path
□ Defini as variáveis de conexão DB e Sleep's
□ Escrevi keywords com nomes BDD (Dado/Quando/Então)

ARQUIVO DE TEST CASE
□ Criei em TestsCases/<Módulo>/<SubMódulo>/Teste_<Nome>1.robot
□ Coloquei Resource apontando para o arquivo de Keywords
□ Coloquei Resource apontando para parametros_pre_condicoes.robot
□ Configurei Suite Setup com: Start Sikuli Process + Ler imagens + Conectar BD + Preparar Ambiente
□ Configurei Suite Teardown com: Stop Remote Server
□ Cada teste tem [Tags] único (Teste01, Teste02...)
□ Cada teste tem nome descritivo: "Teste XX - Descrição"

EXECUÇÃO
□ Executei o teste isoladamente com tag
□ Teste passou? → Executei junto com outros testes
□ Verifiquei se o login roda antes (obrigatório)
```

---

## 14. Exemplos Reais do Projeto

### Exemplo 1: Test Case de Login (o mais simples)

**Arquivo**: `TestsCases/Login/Teste_LoginSistema1.robot`

```robot
*** Settings ***
Resource    ../../KeyWords/Login/KeyLoginSistema1.robot
Resource    ../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyLoginSistema1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Login no MyCommerce
    [Tags]    Teste01

    Dado que eu abro o MyCommerce
    Então realizo o login no MyCommerce
```

**Arquivo**: `KeyWords/Login/KeyLoginSistema1.robot` (resumido)

```robot
*** Variables ***
${TELA_LOGIN_SISTEMA}       tela_LoginSistema.png
${TELA_INICIAL_SISTEMA}     tela_TelaInicialSistema.png
${EXECUTAVEL_MYCOMMERCE}    C://Visual Software//MyCommerce//myCommerce.exe

*** Keywords ***
Dado que eu abro o MyCommerce
    Press Combination    KEY.WIN    KEY.r        # Abre o Executar
    Type    ${EMPTY}    ${EXECUTAVEL_MYCOMMERCE} # Digita o caminho
    Press Special Key    ENTER                    # Executa
    Wait Until Screen Contain    ${TELA_LOGIN_SISTEMA}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${TELA_LOGIN_SISTEMA}  # Foco na tela

Então realizo o login no MyCommerce
    Type    ${EMPTY}    FELIPE                     # Usuário
    Press Special Key    ENTER
    Type    ${EMPTY}    zwBt4@24                    # Senha
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_INICIAL_SISTEMA}    ${TEMPO_TELA}
```

### Exemplo 2: Fluxo Completo de Condicional

Veja como o teste de Condicional segue o padrão completo:

**Test Case** chama → **Keywords** que usam → **Imagens** + **SQL** + **Utils**

```
Teste_Condicional1.robot
    │
    ├── Dado que acesso a tela de condicionais
    │   └── Press F11 → Wait TELA_CONDICIONAIS
    │
    ├── E adiciono uma nova condicional
    │   └── ALT+A → Wait TELA_ADICIONAR → Query SQL (último código)
    │
    ├── Quando insiro vendedor e cliente
    │   └── utils.Adicionar Vendedor e Cliente(Condicional) → Query SQL aleatória
    │
    ├── Quando insiro um produto normal informando a quantidade(1)
    │   └── utils.Inserir Produto → Query SQL aleatória com estoque
    │
    ├── Então finalizo a condicional
    │   └── ALT+D → Detalhes → ALT+F → Finalizar → Valida estoque
    │
    └── E saio da tela(Condicional)
        └── ESC → Wait TELA_CONDICIONAIS → ESC
```

---

## 🎯 Resumo Final

| Pergunta | Resposta |
|---|---|
| **Onde ficam as imagens?** | `Testes_BancoAleatorio/images/` |
| **Onde ficam as keywords?** | `Testes_BancoAleatorio/KeyWords/<Módulo>/` |
| **Onde ficam os testes?** | `Testes_BancoAleatorio/TestsCases/<Módulo>/` |
| **Como nomeio imagens?** | `prefixo_NomeCamelCase.png` (tela_, aviso_, bt_, lb_, input_, row_) |
| **Como nomeio keywords?** | `Key<Nome>1.robot` |
| **Como nomeio test cases?** | `Teste_<Nome>1.robot` |
| **O que todo arquivo de keyword DEVE ter?** | SikuliLibrary, ImageHorizonLibrary, variáveis de DB, Sleep's, `Ler imagens iniciais` |
| **O que todo test case DEVE ter?** | Suite Setup/Teardown, Resource para keywords e pré-condições, Tags |
| **Como executo um teste?** | `robot -d ./results -i Teste01 ./TestsCases/.../arquivo.robot` |
| **O que faço se falhar?** | Leia o log.html, isole o teste, verifique as imagens, faça manualmente |

---

> 📝 **Dica Final**: Em caso de dúvida, abra um arquivo de keyword existente (como `KeyCondicional1.robot` ou `keyVendas1.robot`) e use-o como modelo. Os padrões são consistentes em todo o projeto!
