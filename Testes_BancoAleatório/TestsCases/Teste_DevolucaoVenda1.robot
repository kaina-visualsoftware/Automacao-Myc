*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/KeyDevolucaoVenda1.robot
Resource     ../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyDevolucaoVenda1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando uma nova Devolução de venda
    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal
    