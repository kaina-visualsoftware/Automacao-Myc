*** Settings ***
Documentation    Testes Pedidos pré-venda

Resource    ../KeyWords/KeySeparacaoConferencia1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server


*** Variables ***
${COD_PRODUTO_NORMAL}    3
${COD_PRODUTO_SERIAL}    187
${COD_PRODUTO_KIT}       9
${COD_PRODUTO_LOTE}      5

*** Test Cases ***
Teste 01 - Realizando a conferência de pedido - 1 Produto
    [Tags]    Teste01
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos
    Então finalizo a separação
    
Teste 02 - Realizando a conferência de pedido - 1 Produto Kit
    [Tags]    Teste02
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos
    Então finalizo a separação

Teste 03 - Realizando a conferência de pedido - 1 Produto Lote - Selecionando Lote
    [Tags]    Teste03
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_LOTE})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos - Lote Seleção(0)
    Então finalizo a separação - Lote(0)

Teste 04 - Realizando a conferência de pedido - 1 Produto Lote - Baixa Lote mais velho
    [Tags]    Teste04
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_LOTE})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos - Lote Seleção(1)
    Então finalizo a separação - Lote(1)

Teste 05 - Realizando a conferência de pedido - Produto Serial
    [Tags]    Teste05
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_SERIAL})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos - Serial
    Então finalizo a separação

Teste 06 - Realizando a conferência de pedido - Produto Grade 
    [Tags]    Teste06
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto do tipo Grade
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos - Grade
    Então finalizo a separação


