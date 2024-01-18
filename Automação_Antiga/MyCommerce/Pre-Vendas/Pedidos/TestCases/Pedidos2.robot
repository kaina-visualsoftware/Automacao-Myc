*** Settings ***
Documentation    Testes Pedidos pré-venda - Gerando Venda

Resource    ../KeyWords/KeyPedidos2.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_SERIAL}        188
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_LOTE}          5

*** Test Cases ***
Teste 01 - Gerando venda de um pedido com produto normal - A vista
    [Tags]    Teste01
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o pedido - A vista
    E pressiono o botão de gerar venda
    Então pressiono gerar total - A vista

Teste 02 - Gerando venda de um pedido com produto normal - Personalizada
    [Tags]    Teste02
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o pedido - Personalizado
    E pressiono o botão de gerar venda
    Então pressiono gerar total

Teste 03 - Gerando venda de um pedido com produto grade - Personalizada
    [Tags]    Teste03
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto do tipo Grade
    Quando finalizo o pedido - Personalizado
    E pressiono o botão de gerar venda
    Então pressiono gerar total

Teste 04 - Gerando venda total de um pedido com mais de um produto - Personalizada
    [Tags]    Teste04
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - Personalizado
    E pressiono o botão de gerar venda
    Então pressiono gerar total

Teste 05 - Gerando venda parcial de um pedido - Personalizada
    [Tags]    Teste05
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - Personalizado
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar
    Então pressiono o botão parcialmete

Teste 06 - Gerando venda parcial de um pedido - Personalizada
    [Tags]    Teste06
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - Personalizado
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar
    Então pressiono o botão parcialmete

Teste 07 - Gerando venda parcial de um pedido - Produto Grade - Personalizada
    [Tags]    Teste07
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto do tipo Grade
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando finalizo o pedido - Personalizado
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar - Grade
    Então pressiono o botão parcialmete

Teste 08 - Gerando venda parcial de um pedido - A vista
    [Tags]    Teste08
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - A vista
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar
    Então pressiono o botão parcialmete - A vista

Teste 09 - Gerando venda parcial de um pedido - A vista - Com desconto
    [Tags]    Teste09
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - A vista
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar
    Então pressiono o botão parcialmete - A vista(5)

Teste 10 - Gerando venda parcial de um pedido - A vista - Com desconto 
    [Tags]    Teste10
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - A vista
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar
    Então pressiono o botão parcialmete - Desconto Excedido(20)

Teste 11 - Gerando venda parcial de um pedido - 30 Dias - Alterando valor final da venda 
    [Tags]    Teste11
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - 30 Dias
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar
    Então pressiono o botão parcialmete - Alterando valor final(10)

Teste 12 - Gerando venda parcial de um pedido - 30 Dias - Alterando valor final da venda
    [Tags]    Teste12
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro mais de um produto do tipo normal
    Quando finalizo o pedido - 30 Dias
    E pressiono o botão de gerar venda
    Quando seleciono uma quantidade a gerar
    Então pressiono o botão parcialmete - Alterando valor final - Desconto Excedido(20)

Teste 13 - Gerando venda de produto lote - Sem estar separado 
    [Tags]    Teste13
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_LOTE})
    Quando finalizo o pedido - 30 Dias
    Então pressiono o botão de gerar venda - Produto lote 