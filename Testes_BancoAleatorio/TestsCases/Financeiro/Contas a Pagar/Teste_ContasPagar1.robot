*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Financeiro/Contas a Pagar/keyContasPagar1.robot
Resource    ../../../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    keyContasPagar1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Lançamento de conta a pagar avulsa
    [Tags]    Teste01

    Dado que acesso a tela de cadastro avulso de contas a pagar
    E insiro um cliente qualquer
    Quando clico em adicionar
    E insiro as informações necessárias(100)
    Então gravo o lançamento de conta a pagar avulsa
    E saio da tela(ContasAPagar)