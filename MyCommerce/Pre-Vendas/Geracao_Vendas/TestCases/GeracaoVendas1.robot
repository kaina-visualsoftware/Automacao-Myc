*** Settings ***
Documentation    Testes Separação e Conferencia - Extras

Resource    ../KeyWords/KeyGeracaoVendas.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}    3
${COD_PRODUTO_SERIAL}    187
${COD_PRODUTO_KIT}       9
${COD_PRODUTO_LOTE}      5

*** Test Cases ***
Teste 01 - Gerando venda de pedido já separado
    [Tags]    Teste01
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista
    Então finalizo a venda - A vista

Teste 02 - Gerando venda de pedido já separado
    [Tags]    Teste02
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista
    Então finalizo a venda - A vista

Teste 03 - Gerando venda de pedido já separado - 30 dias 
    [Tags]    Teste03
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Então gero a venda - 30 Dias 

Teste 04 - Gerando venda de pedido ja separado - 10% de desconto
    [Tags]    Teste04
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista
    Então finalizo a venda - A vista(10)

Teste 05 - Gerando venda de pedido ja separado - Ultrapassando os 100% de desconto
    [Tags]    Teste05
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista
    Quando informo um desconto acima do previsto(110)
    Então finalizo a venda - A vista

Teste 06 - Gerando venda de pedido ja separado - Informando um valor maior que o do pedido 
    [Tags]    Teste06
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
    Quando clico em gerar - A vista
    Então finalizo a venda - A vista - Valor Superior