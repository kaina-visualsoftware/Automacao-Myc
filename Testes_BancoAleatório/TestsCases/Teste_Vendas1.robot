*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/keyVendas1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Venda com produto Normal
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a venda
