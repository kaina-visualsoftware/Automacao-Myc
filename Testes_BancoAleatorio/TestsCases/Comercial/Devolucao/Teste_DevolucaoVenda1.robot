*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Comercial/Devolucao/KeyDevolucaoVenda1.robot
Resource    ../../../utils/montadorDeCenarios.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal
Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***
Teste 01 - Lançamento de devolução de venda
    [Tags]    Teste01

    Dado que acesso a tela de devoluções de vendas/OS
    Quando adiciono uma nova devolução
    E insiro os dados da venda no cabeçalho da devolução(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Então finalizo a devolução
    E saio da tela(Devolução)

Teste 02 - Visualização de devolução de venda
    [Tags]    Teste02

    Dado que acesso a tela de devoluções de vendas/OS
    Quando adiciono uma nova devolução
    E insiro os dados da venda no cabeçalho da devolução(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Então finalizo a devolução
    E pesquiso pela devolução gerada
    Então visualizo a devolução
    E saio da tela(Devolução)

#O teste de edição só funciona se os parametros de Dev. Avulsa e permite aberta estiverem habilitados!
Teste 03 - Edição de devolução de venda
    [Tags]    Teste03

    Dado que acesso a tela de devoluções de vendas/OS
    Quando adiciono uma nova devolução
    E insiro os dados da venda no cabeçalho da devolução(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Quando finalizo a devolução como aberta
    E pesquiso pela devolução gerada
    E edito a devolução
    Quando insiro um produto para a troca
    Então finalizo a devolução após a edição
    E saio da tela(Devolução)

Teste 04 - Exclusão de devolução de venda 
    [Tags]    Teste04

    Dado que acesso a tela de devoluções de vendas/OS
    Quando adiciono uma nova devolução
    E insiro os dados da venda no cabeçalho da devolução(Devolução)
    Quando seleciono um produto para a devolução
    E vou para a aba de pagamentos
    Então finalizo a devolução
    E pesquiso pela devolução gerada
    Então excluo a devolução
    E saio da tela(Devolução)

Teste 05 - Lançamento de devolução de venda com múltiplos produtos
    [Tags]    Teste05
    [Setup]    montadorDeCenarios.Dado que realizo uma venda com mais de um produto(2)
    
    Dado que acesso a tela de devoluções de vendas/OS
    Quando adiciono uma nova devolução
    E insiro os dados da venda no cabeçalho da devolução(Devolução)
    Quando seleciono os produtos para a devolução(2)
    E vou para a aba de pagamentos
    Então finalizo a devolução
    E saio da tela(Devolução)