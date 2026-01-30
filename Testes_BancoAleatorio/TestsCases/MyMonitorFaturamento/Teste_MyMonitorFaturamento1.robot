*** Settings ***
Resource    ../../KeyWords/MyMonitorFaturamento/KeyMyMonitorFaturamento1.robot
Resource    ../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyMyMonitorFaturamento1.Ler imagens iniciais    AND    Conectar ao Banco de Dados
Suite Teardown    Stop Remote Server

*** Test Cases ***
Teste 01 - Abertura do MyMonitorFaturamento
    [Tags]    Teste01

    Dado que acesso o MyMonitorFaturamento
    E acesso a guia 'Configurações'
    E acesso a guia 'Contigência'
    E acesso a guia 'Configurações extras'
    Então salvo as configurações
    E encerro o myMonitorFaturamento    

