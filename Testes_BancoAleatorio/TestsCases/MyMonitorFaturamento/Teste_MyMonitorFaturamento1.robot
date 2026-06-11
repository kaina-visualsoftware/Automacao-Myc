*** Settings ***
Resource    ../../KeyWords/MyMonitorFaturamento/KeyMyMonitorFaturamento1.robot
Resource    ../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce

*** Test Cases ***
Teste 01 - Abertura do MyMonitorFaturamento
    [Tags]    Teste01

    Dado que acesso o MyMonitorFaturamento
    E acesso a guia 'Configurações'
    E acesso a guia 'Contigência'
    E acesso a guia 'Configurações extras'
    Então salvo as configurações
    E encerro o myMonitorFaturamento    

