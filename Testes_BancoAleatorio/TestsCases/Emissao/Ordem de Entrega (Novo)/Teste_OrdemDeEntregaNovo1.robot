*** Settings ***
Resource    ../../../KeyWords/Emissão/Ordem de Entrega-Novo/KeyOrdemDeEntregaNovo1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot
Resource    ../../../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal, sem excluir a ordem de entrega
Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***

Teste 01 - Lançamento de ordem de entrega com uma venda
    [Tags]    Teste01
    
    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 02 - Lançamento de ordem de entrega com múltiplas vendas
    [Tags]    Teste02
    [Setup]    montadorDeCenarios.Dado que realizo mais de uma venda(2)

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono as últimas vendas feitas
    E seleciono os produtos
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 03 - Lançamento de ordem de entrega de doação
    [Tags]    Teste03
    [Setup]    montadorDeCenarios.Dado que eu realizo uma doação

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última doação gerada
    E seleciono o produto
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 04 - Lançamento de ordem de entrega informando os detalhes da entrega
    [Tags]    Teste04

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 05 - Edição de entrega
    [Tags]    Teste05

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E edito a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 06 - Visualização de entrega
    [Tags]    Teste06

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E visualizo a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 07 - Exclusão de entrega
    [Tags]    Teste07

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E excluo a entrega
    Então saio das telas de Entrega e Ordem de Entrega

Teste 08 - Visualização do workflow da entrega
    [Tags]    Teste08

    Dado que eu inicio um lançamento de Ordem de Entrega Novo
    Quando seleciono a última venda gerada
    E seleciono o produto
    Então gero a entrega
    Dado que eu seleciono a entrega gerada
    E visualizo o Workflow da entrega
    Então saio das telas de Entrega e Ordem de Entrega