*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Comercial/Orcamento/keyOrcamento1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    keyOrcamento1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

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