*** Settings ***
Resource    ../KeyWords/Emissão/Ordem de Entrega-Novo/KeyOrdemDeEntregaNovo1.robot
Resource     ../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    KeyOrdemDeEntregaNovo1.Ler imagens iniciais    AND    Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal, sem excluir a ordem de entrega

*** Test Cases ***

Teste 01 - Lançando uma nova Ordem de Entrega - Novo
    Dado que eu acesso o menu de Emissão/Ordem de Entrega Novo
    E inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada