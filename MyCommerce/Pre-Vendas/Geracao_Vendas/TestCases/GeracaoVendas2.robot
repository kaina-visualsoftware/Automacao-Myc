*** Settings ***
Documentation    Testes Separação e Conferencia - Extras

Resource    ../KeyWords/KeyGeracaoVendas2.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}    3
${COD_PRODUTO_SERIAL}    187
${COD_PRODUTO_KIT}       9
${COD_PRODUTO_LOTE}      5

*** Test Cases ***
Teste 01 - Gerando venda de pedido já separado - Venda como Entregue
    [Tags]    Teste01
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista - Venda como Entregue
    Então finalizo a venda - A vista - Venda como Entregue

Teste 02 - Gerando venda de pedido já separado - Pedido agrupado
    [Tags]    Teste02
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista - Venda agrupada
    Então finalizo a venda - A vista

Teste 03 - Gerando venda de pedido já separado - Mais de um pedido
    [Tags]    Teste03
    Dado que acesso a tela de geração de vendas 
    E seleciono mais de um pedido
    Quando clico em gerar - A vista
    Então finalizo as vendas

Teste 04 - Gerando venda de pedido já separado - Imprimindo Venda
    [Tags]    Teste04
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista - Imprimindo venda
    Então finalizo a venda - A vista - Imprimindo Venda

Teste 05 - Gerando venda de pedido já separado
    [Tags]    Teste05
    Dado que acesso a tela de geração de vendas
    E seleciono um pedido - Imprimir boletos
    Quando clico em gerar - A vista
    Então finalizo as vendas

Teste 06 - Gerando venda de pedido já separado - Faturando Venda 
    [Tags]    Teste06
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Então finalizo as vendas - Faturando Venda
