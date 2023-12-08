*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/KeyPedidos1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando Pedido
    Dado que acesso a tela de pedidos
    E clico em adicionar
    Quando adiciono vendedor e cliente
    E adiciono um produto
    Quando vou para a aba de pagamentos
    E audito o pedido 
    Então finalizo o pedido 