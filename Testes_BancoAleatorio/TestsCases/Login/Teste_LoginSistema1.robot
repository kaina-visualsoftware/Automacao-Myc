*** Settings ***
Resource    ../../KeyWords/Login/KeyLoginSistema1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyLoginSistema1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Login no MyCommerce
    [Tags]    Teste01
    
    Dado que eu abro o MyCommerce
    Então realizo o login no MyCommerce