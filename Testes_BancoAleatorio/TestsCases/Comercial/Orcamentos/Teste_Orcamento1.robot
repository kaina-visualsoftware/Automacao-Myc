*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Comercial/Orcamento/keyOrcamento1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***
Teste 01 - Lançamento de orçamento
    [Tags]    Teste01

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(1)
    Então gravo o orçamento
    E saio da tela(Orçamento)

Teste 02 - Visualização de orçamento
    [Tags]    Teste02

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(1)
    Então gravo o orçamento
    E pesquiso pelo orçamento gerado
    Então visualizo o orçamento
    E saio da tela(Orçamento)

Teste 03 - Edição de orçamento
    [Tags]    Teste03

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(1)
    Então gravo o orçamento
    E pesquiso pelo orçamento gerado
    keyOrcamento1.Quando clico em editar
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(1)
    Então gravo o orçamento
    E saio da tela(Orçamento)

Teste 04 - Exclusão de orçamento
    [Tags]    Teste04

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(1)
    Então gravo o orçamento
    E pesquiso pelo orçamento gerado
    Quando clico em excluir
    Então finalizo a exclusão
    E saio da tela(Orçamento)

Teste 05 - Lançamento de orçamento com mais de um produto normal
    [Tags]    Teste05

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro mais de um produto normal(3)
    Então gravo o orçamento
    E saio da tela(Orçamento)

Teste 06 - Geração de venda de orçamento
    [Tags]    Teste06

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(1)
    Então gravo o orçamento
    E pesquiso pelo orçamento gerado
    keyOrcamento1.Quando clico em gerar venda
    Validação da venda gerada a partir do orçamento
    utils.E saio da tela(Venda)
    utils.E saio da tela(Orçamento)

Teste 07 - Geração de pré-venda durante o lançamento do orçamento
    [Tags]    Teste07

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(2)
    E acesso a guia Pagamentos
    Então gero pré-venda do orçamento
    utils.E saio da tela(Orçamento)

Teste 08 - Geração de pré-venda após o lançamento do orçamento
    [Tags]    Teste08

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(2)
    Então gravo o orçamento
    E pesquiso pelo orçamento gerado
    E clico em Gerar Pré-Ven
    utils.E saio da tela(Orçamento)

Teste 09 - Geração de pré-venda após o lançamento do orçamento com múltiplos produtos com baixa de estoque na pré-venda
    [Tags]    Teste09
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    BAIXA_ESTOQUE_PREVENDA    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro mais de um produto normal(3)
    Então gravo o orçamento
    E pesquiso pelo orçamento gerado
    E clico em Gerar Pré-Ven
    utils.E saio da tela(Orçamento)

Teste 10 - Alteração de status do orçamento
    [Tags]    Teste10

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro um produto normal informando a quantidade(1)
    Então gravo o orçamento
    E pesquiso pelo orçamento gerado
    E pressiono o atalho de alterar status
    Então altero o status do orçamento
    E saio da tela(Orçamento)

Teste 11 - Lançamento de orçamento somente com múltiplos serviços
    [Tags]    Teste11

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro mais de um serviço(3)
    Então gravo o orçamento
    E saio da tela(Orçamento)

Teste 12 - Lançamento de orçamento com múltiplos serviços e múltiplos produtos
    [Tags]    Teste12

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro mais de um serviço(3)
    keyOrcamento1.Quando insiro mais de um produto normal(3)
    Então gravo o orçamento
    E saio da tela(Orçamento)

Teste 13 - Lançamento de orçamento com agrupamento de produtos
    # Tarefa: 184584
    [Tags]    Teste13

    Dado que acesso a tela de orçamentos
    keyOrcamento1.Quando pressiono o atalho de adicionar
    keyOrcamento1.E adiciono vendedor e cliente
    keyOrcamento1.Quando insiro mais de um produto normal(2)
    Então gravo o orçamento
    E saio da tela(Orçamento)

