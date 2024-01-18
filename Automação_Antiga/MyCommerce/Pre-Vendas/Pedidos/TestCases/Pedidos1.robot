*** Settings ***
Documentation    Testes Pedidos pré-venda

Resource    ../KeyWords/KeyPedidos1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_SERIAL}        188
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_LOTE}          5

*** Test Cases ***
Teste 01 - Pedido com produto normal - A vista
    [Tags]    Teste01
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Então finalizo o pedido - A vista

Teste 02 - Pedido com produto normal - 30 Dias
    [Tags]    Teste02
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Então finalizo o pedido - 30 Dias

Teste 03 - Pedido com produto normal - Personalizado
    [Tags]    Teste03
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Então finalizo o pedido - Personalizado

Teste 04 - Pedido com Produto serial - Personalizado
    [Tags]    Teste04
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_SERIAL})
    Então finalizo o pedido - Personalizado

Teste 05 - Pedido com produto kit - Personalizado
    [Tags]    Teste05
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_KIT})
    Então finalizo o pedido - Personalizado

Teste 06 - Pedido com Produto Grade - A vista 
    [Tags]    Teste06
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto do tipo Grade
    Então finalizo o pedido - A vista

Teste 07 - Pedido com Produto Grade - Personalizado
    [Tags]    Teste07
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto do tipo Grade
    Então finalizo o pedido - Personalizado

Teste 08 - Pedido com produto lote - A vista 
    [Tags]    Teste08
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_LOTE})
    Então finalizo o pedido - A vista

Teste 09 - Pedido com produto normal e transportadora - A Vista 
    [Tags]    Teste09
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto(${COD_PRODUTO_NORMAL})
    Quando preencho a aba de transportadora
    Então finalizo o pedido - A vista

Teste 10 - Pedido com produto Grade e transportadora - Personalizada
    [Tags]    Teste10
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro um produto do tipo Grade
    Quando preencho a aba de transportadora
    Então finalizo o pedido - Personalizado 

Teste 11 - Pedido com produtos de todas modalidades - Personalizada
    [Tags]    Teste11
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro todos os tipos de produtos
    Então finalizo o pedido - Personalizado 

Teste 12 - Pedido com produtos de todas modalidades - Personalizada
    [Tags]    Teste12
    Dado que acesso da tela de pedidos
    Quando clico em adicionar um pedido
    E insiro vendedor e cliente 
    Quando insiro todos os tipos de produtos
    Então finalizo o pedido - A vista

Teste 13 - Editando o último pedido gerado
    [Tags]    Teste13
    Dado que acesso da tela de pedidos
    Quando pressiono o botão de editar
    E estorno a auditoria
    E edito o último produto
    Então finalizo o pedido - 30 Dias

Teste 14 - Excluindo o último pedido feito
    [Tags]    Teste14
    Dado que acesso da tela de pedidos
    Então pressiono o atalho de excluir 
    