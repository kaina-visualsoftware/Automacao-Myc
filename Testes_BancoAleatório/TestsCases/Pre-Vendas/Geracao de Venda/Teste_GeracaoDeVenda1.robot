*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/Pré-Venda/Geracao Venda/KeyGeracaoDeVenda1.robot
Resource     ../utils/montadorDeCenarios.robot
Resource     ../KeyWords/Comercial/Vendas/keyVendas1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyGeracaoDeVenda1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo um pedido, com produto normal

*** Test Cases ***
Teste 01 - Fazendo a geração de venda de um pedido 
    [Tags]    Teste01

    Dado que acesso a tela de geração de vendas
    Quando seleciono o ultimo pedido feito
    E clico em gerar
    Então confirmo a geração da venda 

Teste 02 - Visualizando o pedido antes de gerar a venda
    [Tags]    Teste02

    Dado que acesso a tela de geração de vendas
    Quando seleciono o ultimo pedido feito
    E clico em visualizar
    Quando volto para a tela de geração de venda
    E clico em gerar
    Então confirmo a geração da venda 

Teste 03 - Excluindo venda feita pelo gerar venda 
    [Tags]    Teste03

    Dado que acesso a tela de geração de vendas
    Quando seleciono o ultimo pedido feito
    E clico em gerar
    Então confirmo a geração da venda 
    keyVendas1.Dado que acesso a tela de vendas de balcao
    keyVendas1.Então clico em excluir
    Então verifico se o pedido retornou como aberto

Teste 04 - Gerando venda de mais de um pedido 
    [Tags]    Teste04
    [Setup]    montadorDeCenarios.Dado que realizo mais de um pedido(2)
    
    Dado que acesso a tela de geração de vendas
    Quando seleciono os ultimos pedidos feitos
    E clico em gerar
    Então confirmo a geração dos pedidos
