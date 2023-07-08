*** Settings ***
Documentation    Testes com cenários reais de bugs externos

Resource    ../KeyWords/keyOrcamentos4.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Variables ***
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        43

*** Test Cases ***
Teste 01 - Processo tarefa 136665 - 1 produto com insert - Clicando selecionar
    [Tags]    Teste01
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro o produto com insert(1)
    E seleciono clicando no botão
    Então finalizo o orçamento como a vista

Teste 02 - Processo tarefa 136665 - 2 produtos com insert - Clicando selecionar
    [Tags]    Teste02
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro o produto com insert(2)
    E seleciono clicando no botão
    Então finalizo o orçamento como a vista

Teste 03 - Processo tarefa 136665 - 1 produto com insert - Clicando selecionar
    [Tags]    Teste03
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro o produto com insert(1)
    E seleciono clicando no atalho botão
    Então finalizo o orçamento como a vista

Teste 04 - Processo tarefa 136665 - 2 produtos com insert - Clicando selecionar
    [Tags]    Teste04
    Dado que acesso a tela de orçamentos
    Quando pressiono o atalho de adicionar
    E insiro Vendedor e Cliente
    Quando insiro o produto com insert(2)
    E seleciono clicando no atalho botão
    Então finalizo o orçamento como a vista