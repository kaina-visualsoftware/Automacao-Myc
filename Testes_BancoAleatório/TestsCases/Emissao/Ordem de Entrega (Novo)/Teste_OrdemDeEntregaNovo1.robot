*** Settings ***
Resource    ../KeyWords/Emissão/Ordem de Entrega-Novo/KeyOrdemDeEntregaNovo1.robot
Resource     ../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    KeyOrdemDeEntregaNovo1.Ler imagens iniciais    AND    Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal, sem excluir a ordem de entrega

*** Test Cases ***

Teste 01 - Lançando uma nova Ordem de Entrega
    [Tags]    Teste01
    
    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 02 - Lançando uma nova Ordem de Entrega com mais de uma venda
    [Tags]    Teste02
    [Setup]    montadorDeCenarios.Dado que realizo mais de uma venda(2)

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono as últimas vendas feitas
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 03 - Lançando uma nova Ordem de Entrega de uma doação
    [Tags]    Teste03
    [Setup]    montadorDeCenarios.Dado que eu realizo uma doação

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última doação gerada
    E seleciono o produto
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 04 - Lançando uma Ordem de Entrega e definindo detalhes

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 05 - Edição de Entrega

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E edito a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 06 - Visualização de Entrega

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E visualizo a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 07 - Exclusão de Entrega

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E excluo a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 08 - Visualizando Workflow de Entrega

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E visualizo o Workflow da entrega
    Então saio das telas de Entrega e Ordem de Entrega