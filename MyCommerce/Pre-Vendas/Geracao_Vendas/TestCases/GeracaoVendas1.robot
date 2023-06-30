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
    Dado que acesso a tela de geração de vendas 
    E seleciono um pedido
