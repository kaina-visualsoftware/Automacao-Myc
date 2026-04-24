*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Comercial/Condicional/KeyCondicional1.robot
#Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    KeyCondicional1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***
Teste 01 - Lançamento de condicional
    [Tags]    Teste01

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo a condicional
    E saio da tela(Condicional)

Teste 02 - Visualização de condicional
    [Tags]    Teste02

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo a condicional
    Então visualizo a condicional
    E saio da tela(Condicional)

Teste 03 - Edição de condicional
    [Tags]    Teste03

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo a condicional
    KeyCondicional1.Quando clico em editar
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo a condicional
    E saio da tela(Condicional)

Teste 04 - Exclusão de condicional
    [Tags]    Teste04

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo a condicional
    Então excluo a condicional
    E saio da tela(Condicional)

Teste 05 - Geração de venda total da condicional
    [Tags]    Teste05

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo a condicional
    Quando clico em gerar venda
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    Validação de vendas após a geração do condicional
    utils.E saio da tela(Venda)

Teste 06 - Geração de venda parcial da condicional
    [Tags]    Teste06

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    E insiro mais de um produto normal(3)
    Então finalizo a condicional
    Quando clico em gerar venda parcial
    E gero a venda de parte dos produtos(2)
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.E saio da tela(Venda)

Teste 07 - Cancelamento da geração da venda total da condicional
    [Tags]    Teste07

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    Então finalizo a condicional
    Quando clico em gerar venda
    Então cancelo a geração da venda
    E saio da tela(Condicional)

Teste 08 - Cancelamento da geração da venda parcial da condicional
    [Tags]    Teste08
    
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    E insiro mais de um produto normal(3)
    Então finalizo a condicional
    Quando clico em gerar venda parcial
    E gero a venda de parte dos produtos(2)
    Então cancelo a geração da venda
    E saio da tela(Condicional)

Teste 09 - Devolução parcial de condicional com múltiplos produtos, utilizando a opção de itens selecionados
    [Tags]    Teste09

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    E insiro mais de um produto normal(3)
    Então finalizo a condicional
    E pesquiso pela condicional gerada
    Quando acesso a devolução de condicional
    E acesso a guia Itens Disponíveis
    E seleciono os produtos para devolução(2)
    E acesso a guia Finalizar
    Então gravo a devolução
    E saio da tela(Condicional)
    # VERIFICAR, POIS AS VEZES É FECHADO A TELA DE CONDICIONAIS AO FECHAR A MENSAGEM DE SUCESSO DA DEVOLUÇÃO.

Teste 10 - Devolução total de condicional com múltiplos produtos, utilizando a opção de seleção de produtos
    [Tags]    Teste10

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    E insiro mais de um produto normal(2)
    Então finalizo a condicional
    E pesquiso pela condicional gerada
    Quando acesso a devolução de condicional
    E seleciono os produtos para devolução(2)
    E acesso a guia Finalizar
    Então gravo a devolução
    E saio da tela(Condicional)
    # VERIFICAR, POIS AS VEZES É FECHADO A TELA DE CONDICIONAIS AO FECHAR A MENSAGEM DE SUCESSO DA DEVOLUÇÃO.

Teste 11 - Lançamento de condicional com 2 produtos e visualização
    [Tags]    Teste11

    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional
    Quando insiro vendedor e cliente
    E insiro mais de um produto normal(2)
    Então finalizo a condicional
    Então visualizo a condicional
    E saio da tela(Condicional)