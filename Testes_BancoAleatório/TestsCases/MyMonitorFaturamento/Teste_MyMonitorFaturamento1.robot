*** Settings ***

Resource    ../../KeyWords/MyMonitorFaturamento/KeyMyMonitorFaturamento1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyMyMonitorFaturamento1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Abertura do MyMonitorFaturamento

    Dado que acesso o MyMonitorFaturamento
    E acesso a guia 'Configurações'
    E acesso a guia 'Contigência'
    E acesso a guia 'Configurações extras'
    Então salvo as configurações
    

