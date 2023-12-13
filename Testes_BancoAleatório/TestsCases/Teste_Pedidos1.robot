*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/KeyPedidos1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando Pedido
    [Tags]    Teste01
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 

Teste 02 - Adicionando Pedido e visualizando
    [Tags]    Teste02
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 
    Então visualizo o pedido feito

Teste 03 - Adicionando Pedido e editando
    [Tags]    Teste03
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    Quando finalizo o pedido sem auditar
    E pressiono o atalho de editar
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 

Teste 04 - Adicionando Pedido e excluindo
    [Tags]    Teste04
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 
    Então excluo o pedido