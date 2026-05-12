---
name: Geração de Test Cases
description: Gera novos test cases e keywords completos seguindo os padrões do projeto mycommerce-automacao
---

# Skill: Geração de Test Cases

## Objetivo

Gerar arquivos `.robot` completos (Test Cases e Keywords) seguindo rigorosamente os padrões do projeto.

## Quando Usar

- Quando o usuário pedir para **criar um teste** para algum módulo do ERP
- Quando for necessário **expandir** cobertura de testes existentes
- Quando for necessário gerar **templates** para novos módulos

---

## Processo de Geração

### 1. Entender a Solicitação

Antes de gerar, obter do usuário:
- **Módulo do ERP**: Qual funcionalidade? (ex: Venda, Devolução, Condicional)
- **Cenários de teste**: Quais operações testar? (CRUD? Fluxos específicos?)
- **Pré-condições**: O teste depende de algo estar pronto antes? (ex: ter uma venda para devolver)
- **Imagens disponíveis**: As imagens das telas já foram capturadas?

### 2. Verificar Estrutura Existente

Antes de criar arquivos:

1. Verificar se o diretório do módulo já existe em `KeyWords/` e `TestsCases/`
2. Se existir, verificar numeração do próximo arquivo (ex: `Key<Nome>2.robot`)
3. Verificar keywords reutilizáveis em `utils/utils.robot` e `utils/montadorDeCenarios.robot`

### 3. Gerar Keyword File

Localização: `KeyWords/<Módulo>/<SubMódulo>/Key<Nome><N>.robot`

#### Template Completo

```robot
*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Library    Telnet
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                              ./Testes_BancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                               ${config.IpServidor}
${DBName}                               ${config.Database}
${DBPass}                               vssql
${DBPort}                               ${config.Porta}
${DBUser}                               root

# Sleep's
${SLEEP_BAIXO}                          0.7
${SLEEP_MEDIO}                          1.5
${SLEEP_ALTO}                           3
${TEMPO_TELA}                           25

# Telas
${TELA_PRINCIPAL}                       tela_NomeTelaPrincipal.png
${TELA_ADICIONAR}                       tela_NomeTelaAdicionar.png
# ... mais variáveis de imagem conforme necessário

# Telas Avisos
# ${AVISO_EXEMPLO}                      aviso_Exemplo.png

# Outros
# ${INPUT_EXEMPLO}                      input_Exemplo.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

# ============================================================
# NAVEGAÇÃO
# ============================================================

Dado que acesso a tela de <nome_modulo>
    
    Press Special Key    <TECLA_ATALHO>
    Wait Until Screen Contain    ${TELA_PRINCIPAL}    ${TEMPO_TELA}

# ============================================================
# OPERAÇÕES CRUD
# ============================================================

E adiciono um novo <item>

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.A
    Wait Until Screen Contain    ${TELA_ADICIONAR}    ${TEMPO_TELA}

    # Consulta para obter último código inserido
    ${Consulta}    Query    SELECT Codigo FROM <tabela> ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_<ITEM>}    ${Consulta[0][0]}
    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_<ITEM>}

Quando insiro vendedor e cliente

    utils.Adicionar Vendedor e Cliente(<NomeTela>)
    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})

    IF    ${Parametro_RealizaVendaSemEstoque}
        utils.Inserir Produto normal - Permite sem estoque
    ELSE
        utils.Inserir Produto normal - Necessita de estoque
    END

    # Informar quantidade
    SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Quantidade_Produto}
    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Produto}
    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}

    utils.Valida parametros após incluir produto

E insiro mais de um produto normal(${QuantidadeDeProduto})

    ${Quantidade_Produto}    Set Variable    1
    ${Codigos_Produtos}    Create List
    
    FOR    ${I}    IN RANGE    ${QuantidadeDeProduto}
        Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})
        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}
    END

    Set Test Variable    ${Codigos_Produtos}
    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QuantidadeDeProduto}

# ============================================================
# FINALIZAÇÃO
# ============================================================

Então finalizo o <item>
    
    Press Combination    KEY.ALT    KEY.F
    Wait Until Screen Contain    ${TELA_PRINCIPAL}    ${TEMPO_TELA}

# ============================================================
# VISUALIZAÇÃO
# ============================================================

Então visualizo o <item>

    Press Combination    KEY.ALT    KEY.U
    Wait Until Screen Contain    ${TELA_VISUALIZA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.r
    Wait Until Screen Contain    ${TELA_PRINCIPAL}    ${TEMPO_TELA}

# ============================================================
# EDIÇÃO
# ============================================================

Quando clico em editar

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.E
    utils.Valida solicitação de senha do usuário supervisor
    Wait Until Screen Contain    ${TELA_ADICIONAR}    ${TEMPO_TELA}

# ============================================================
# EXCLUSÃO
# ============================================================

Então excluo o <item>

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.x
    Wait Until Screen Contain    ${AVISO_DESEJA_EXCLUIR}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    Valida solicitação de senha do usuário supervisor

    # Validação no banco
    Check If Exists In Database    SELECT * FROM <tabela> WHERE Codigo = ${COD_<ITEM>} AND Status = 'x';
    Wait Until Screen Contain    ${TELA_PRINCIPAL}    ${TEMPO_TELA}
```

### 4. Gerar Test Case File

Localização: `TestsCases/<Módulo>/<SubMódulo>/Teste_<Nome><N>.robot`

#### Template Completo

```robot
*** Settings ***
Documentation    Testes em Banco Aleatório - <Módulo> - <SubMódulo>

Resource    ../../../KeyWords/<Módulo>/<SubMódulo>/Key<Nome><N>.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Key<Nome><N>.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Lançamento de <item>
    [Tags]    Teste01

    Dado que acesso a tela de <módulo>
    E adiciono um novo <item>
    Quando insiro vendedor e cliente
    Key<Nome><N>.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo o <item>
    E saio da tela(<NomeTela>)

Teste 02 - Visualização de <item>
    [Tags]    Teste02

    Dado que acesso a tela de <módulo>
    E adiciono um novo <item>
    Quando insiro vendedor e cliente
    Key<Nome><N>.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo o <item>
    Então visualizo o <item>
    E saio da tela(<NomeTela>)

Teste 03 - Edição de <item>
    [Tags]    Teste03

    Dado que acesso a tela de <módulo>
    E adiciono um novo <item>
    Quando insiro vendedor e cliente
    Key<Nome><N>.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo o <item>
    Key<Nome><N>.Quando clico em editar
    Key<Nome><N>.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo o <item>
    E saio da tela(<NomeTela>)

Teste 04 - Exclusão de <item>
    [Tags]    Teste04

    Dado que acesso a tela de <módulo>
    E adiciono um novo <item>
    Quando insiro vendedor e cliente
    Key<Nome><N>.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo o <item>
    Então excluo o <item>
    E saio da tela(<NomeTela>)
```

---

## Placeholders de Substituição

Ao gerar um test case real, substituir todos os placeholders:

| Placeholder | Descrição | Exemplo real |
|---|---|---|
| `<Módulo>` | Módulo do ERP | `Comercial` |
| `<SubMódulo>` | Sub-módulo | `Condicional` |
| `<Nome>` | Nome base para arquivos | `Condicional` |
| `<N>` | Número sequencial | `1` |
| `<item>` | Nome do item no BDD | `condicional`, `venda`, `pedido` |
| `<nome_modulo>` | Nome no BDD | `condicionais` |
| `<NomeTela>` | Identificador da tela para `E saio da tela()` | `Condicional`, `Venda`, `Pedido` |
| `<TECLA_ATALHO>` | Atalho para abrir o módulo | `F11` |
| `<tabela>` | Tabela no MySQL | `condicionais`, `vendas` |

---

## Atalhos Comuns do myCommerce

| Atalho | Ação |
|---|---|
| `F11` | Abre Condicionais |
| `ALT+A` | Adicionar |
| `ALT+E` | Editar |
| `ALT+x` | Excluir |
| `ALT+F` | Finalizar |
| `ALT+G` | Gravar / Gerar |
| `ALT+S` | Sim / Confirmar |
| `ALT+D` | Detalhes |
| `ALT+U` | Visualizar |
| `ALT+V` | Venda parcial |
| `ALT+r` | Retornar |
| `ESC` | Cancelar / Voltar |
| `TAB` | Próximo campo |
| `ENTER` | Confirmar |
| `SPACE` | Selecionar item em grid |

---

## Checklist de Validação

Antes de entregar o código gerado, verificar:

- [ ] **Settings**: Todas as libraries e resources corretos?
- [ ] **Variáveis**: Conexão DB, imagens, sleeps definidos?
- [ ] **Nomenclatura**: BDD em português? Prefixos corretos?
- [ ] **Tags**: Sequenciais e presentes em todos os testes?
- [ ] **Suite Setup/Teardown**: Configurados?
- [ ] **Namespacing**: Keywords ambíguas com prefixo de arquivo?
- [ ] **Caminhos relativos**: Usar `../../../` correto para o nível de diretório?
- [ ] **Espelhamento**: Diretório de Keywords e TestsCases espelhados?
- [ ] **Imagens necessárias**: Listadas como variáveis, existem em `images/`?
- [ ] **Queries SQL**: Tabelas e campos existem no banco do myCommerce?
