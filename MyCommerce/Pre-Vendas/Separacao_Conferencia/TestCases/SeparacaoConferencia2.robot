*** Settings ***
Documentation    Testes Separação e Conferencia - Extras

Resource    ../KeyWords/KeySeparacaoConferencia2.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}    3
${COD_PRODUTO_SERIAL}    43
${COD_PRODUTO_KIT}       9
${COD_PRODUTO_LOTE}      5

*** Test Cases ***
Teste 01 - Realizando a conferência de pedido - Recomeçando separação
    [Tags]    Teste01
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos
    Quando finalizo a separação
    E recomeço a separação
    E informo o codigo dos produtos
    Então finalizo a separação

Teste 02 - Realizando a conferência de pedido - Recomeçando separação - Item
    [Tags]    Teste02
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido 
    E informo o codigo dos produtos
    Quando finalizo a separação
    E recomeço a separação - Item
    E informo o codigo dos produtos
    Então finalizo a separação

Teste 03 - Realizando a conferência de pedido - Recomeçando separação
    [Tags]    Teste03
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido
    E informo o código dos produtos - Mais de um produto(2)
    Quando finalizo a separação
    E recomeço a separação
    E informo o código dos produtos - Mais de um produto(2)
    Então finalizo a separação

Teste 04 - Realizando a conferência de pedido - Recomeçando separação - Item
    [Tags]    Teste04
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido
    E informo o código dos produtos - Mais de um produto(2)
    Quando finalizo a separação
    E recomeço a separação - Item
    Então finalizo a separação - 1 Produto

Teste 05 - Realizando a conferência de pedido - Cortando item
    [Tags]    Teste05
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - 30 Dias
    E abro a separação e conferência
    Quando seleciono o último pedido
    E informo o código dos produtos - Mais de um produto(1)
    Quando seleciono o produto e corto ele
    Então finalizo a separação

Teste 06 - Realizando a conferência de pedido - Cortando Geral
    [Tags]    Teste06
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido
    E informo o código dos produtos - Mais de um produto(1)
    Quando corto os produtos restantes
    Então finalizo a separação

Teste 07 - Realizando a conferência de pedido - Exluindo itens restantes
    [Tags]    Teste07
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - A vista
    E abro a separação e conferência
    Quando seleciono o último pedido
    E informo o código dos produtos - Mais de um produto(1)
    Quando pressiono o botão excluir
    Então finalizo a separação
