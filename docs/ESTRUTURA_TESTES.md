# Estrutura de Testes — myCommerce Automação

Este documento descreve a estrutura completa dos testes no projeto mycommerce-automacao.

---

## 1. Visão Geral da Estrutura

O projeto segue o princípio de **separação de responsabilidades**:

```
TestsCases/  → Define O QUE testar (fluxo de testes)
KeyWords/    → Define COMO executar (implementação)
```

---

## 2. Estrutura de Diretórios

### 2.1 Diretório Principal

```
Testes_BancoAleatorio/
├── images/              ← Todas as imagens .png (sem subpastas)
├── KeyWords/           ← Keywords organizadas por módulo
├── TestsCases/         ← Test Cases (espelhando KeyWords/)
├── utils/              ← Keywords compartilhadas/reutilizáveis
└── libs/               ← Bibliotecas Python auxiliares
```

### 2.2 Módulos de Testes

```
KeyWords/ e TestsCases/
├── Comercial/
│   ├── Condicional/       ← Testes de vendas condicionais
│   ├── Devolucao/        ← Testes de devolução de vendas
│   ├── Doacao/           ← Testes de doações
│   ├── Orcamento/        ← Testes de orçamentos
│   ├── OrdemDeServico/   ← Testes de ordens de serviço
│   ├── Vendas/           ← Testes de vendas
│   └── ...
├── Emissao/
│   ├── Carregamento/     ← Testes de carregamento
│   ├── NotaFiscal/       ← Testes de notas fiscais
│   └── ...
├── Financeiro/
│   ├── Caixa/            ← Testes de caixa
│   ├── Comissoes/        ← Testes de comissões
│   └── ContasPagar/       ← Testes de contas a pagar
├── Login/                ← Testes de login
└── PreVenda/
    └── Pedidos/          ← Testes de pedidos
```

---

## 3. Arquivos de Keywords

### 3.1 Nomenclatura

```
Key<Nome><N>.robot

Exemplos:
- KeyCondicional1.robot
- KeyOrdemDeServico1.robot
- KeyComissoes1.robot
```

### 3.2 Estrutura de um Arquivo de Keywords

```robot
*** Settings ***
Library           SikuliLibrary
Library           ImageHorizonLibrary
Library           DatabaseLibrary
Library           ../../../libs/validaParametros.py
Library           Process
Library           ../../../libs/verificacoesExtras.py
Library           Telnet
Variables         ../../../libs/leituraConfig.py

Resource          ../../../utils/validacaoAviso.robot
Resource          ../../../utils/utils.robot

*** Variables ***
# Imagens
${IMAGENS}        ./Testes_BancoAleatorio/images
${TELA_...}       tela_xxx.png
${BT_...}         bt_xxx.png

# Banco de Dados
${DBHost}         ${config.IpServidor}
${DBName}         ${config.Database}
${DBPass}         vssql
${DBPort}         ${config.Porta}
${DBUser}         root

# Sleeps
${SLEEP_BAIXO}    0.7
${SLEEP_MEDIO}    1.5
${SLEEP_ALTO}     3
${TEMPO_TELA}     25

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

# ============================================
# NAVEGAÇÃO
# ============================================

Dado que acesso a tela de <nome>
    Press Special Key    <ATALHO>
    Wait Until Screen Contain    ${TELA_...}    ${TEMPO_TELA}

# ============================================
# OPERAÇÕES
# ============================================

E adiciono um novo <item>
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.A
    Wait Until Screen Contain    ${TELA_...}    ${TEMPO_TELA}
```

---

## 4. Arquivos de Test Cases

### 4.1 Nomenclatura

```
Teste_<Nome><N>.robot

Exemplos:
- Teste_Condicional1.robot
- Teste_OrdemDeServico1.robot
- Teste_Comissoes1.robot
```

### 4.2 Estrutura de um Arquivo de Test Cases

```robot
*** Settings ***
Documentation    Testes de <módulo> - <descrição>

Resource    ../../../KeyWords/<Módulo>/<SubMódulo>/Key<Nome><N>.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords
...    Start Sikuli Process
...    AND    Key<Nome><N>.Ler imagens iniciais
...    AND    Conectar ao Banco de Dados
...    AND    Preparar Ambiente MyCommerce

Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - <Descrição do teste>
    [Tags]    Teste01
    Dado que acesso a tela de <módulo>
    E adiciono um novo <item>
    Quando insiro vendedor e cliente
    Key<Nome><N>.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo o <item>
    E saio da tela(<NomeTela>)

Teste 02 - <Descrição do teste>
    [Tags]    Teste02
    ...
```

---

## 5. Regras de Espelhamento

**IMPORTANTE**: A estrutura de diretórios em `KeyWords/` e `TestsCases/` deve ser **espelhada**:

```
KeyWords/Comercial/Condicional/KeyCondicional1.robot
TestsCases/Comercial/Condicional/Teste_Condicional1.robot
```

Se você criar um novo diretório em `KeyWords/`, crie o mesmo em `TestsCases/`.

---

## 6. Keywords Reutilizáveis (utils/)

### 6.1 Arquivos em `utils/`

| Arquivo | Responsabilidade |
|---------|-----------------|
| `utils.robot` | Funções reutilizáveis de UI |
| `montadorDeCenarios.robot` | Cenários compostos prontos |
| `validacaoAviso.robot` | Tratamento de popups/avisos |
| `parametros_pre_condicoes.robot` | Validação de parâmetros do banco |
| `myCommerce.robot` | Login/logout do sistema |

### 6.2 Como Usar

Em qualquer arquivo de Keywords, importe:

```robot
Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot
```

### 6.3 Principais Keywords

```robot
# Adicionar vendedor e cliente
utils.Adicionar Vendedor e Cliente(<NomeTela>)

# Inserir produto
utils.Inserir Produto normal - Necessita de estoque
utils.Inserir Produto normal - Permite sem estoque

# Sair da tela
E saio da tela(<NomeTela>)

# Cenários compostos
Dado que realizo uma venda completa, com produto normal
Dado que realizo um pedido, com produto normal
Dado que realizo uma devolução completa da venda
```

---

## 7. Bibliotecas Python (libs/)

### 7.1 Arquivos em `libs/`

| Arquivo | Responsabilidade |
|---------|-----------------|
| `leituraConfig.py` | Lê configurações do myCommerce |
| `validaParametros.py` | Valida parâmetros do sistema |
| `validaComissoes.py` | Valida cálculos de comissão |
| `estoque.py` | Valida movimentação de estoque |
| `verificacoesExtras.py` | Verificações auxiliares |

### 7.2 Como Usar

```robot
Library    ../../../libs/validaParametros.py
Library    ../../../libs/validaComissoes.py
```

---

## 8. Variáveis de Conexão

Sempre inclua estas variáveis nos arquivos de Keywords:

```robot
# Conexão com Banco de Dados
${DBHost}    ${config.IpServidor}
${DBName}    ${config.Database}
${DBPass}    vssql
${DBPort}    ${config.Porta}
${DBUser}    root
```

Essas variáveis são preenchidas automaticamente pelo arquivo `leituraConfig.py`.

---

## 9. Padrões de Código

### BDD em Português

```robot
Dado que acesso a tela de vendas
Quando insiro o vendedor comissionado
E seleciono a comissão de produtos
Então baixo a comissão recebida
```

### Tags Sequenciais

```robot
Teste 01 - Descrição
    [Tags]    Teste01

Teste 02 - Descrição
    [Tags]    Teste02
```

### Namespacing

Quando houver ambiguidade de keywords:

```robot
SikuliLibrary.Click    ${BTN_SALVAR}
SikuliLibrary.Double Click    ${INPUT_CAMPO}
```

---

## 10. Checklist de Novo Teste

Antes de criar um novo teste, verifique:

- [ ] Diretório espelhado criado em `KeyWords/` e `TestsCases/`?
- [ ] Nome do arquivo segue o padrão (`Key<Nome>N.robot` / `Teste_<Nome>N.robot`)?
- [ ] Variáveis de imagem com prefixo correto (`${TELA_}`, `${BT_}`, etc.)?
- [ ] Conexão com banco de dados configurada?
- [ ] Keywords em BDD em português?
- [ ] Test cases com tags sequenciais?
- [ ] Suite Setup com Start Sikuli + Ler imagens + Conectar BD?
- [ ] Suite Teardown com Stop Remote Server?
- [ ] Images referenciadas existem em `images/`?
- [ ] Caminhos relativos (`../../../`) estão corretos?

---

## 11. Executando os Testes

### Teste específico

```powershell
robot -d .\results\ .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Por tag

```powershell
robot -d .\results\ -i Teste01 .\TestsCases\Comercial\Condicional\Teste_Condicional1.robot
```

### Todos os testes

```powershell
python Executar_Automacao.py
```