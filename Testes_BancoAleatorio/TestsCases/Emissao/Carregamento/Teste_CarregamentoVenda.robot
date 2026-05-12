*** Settings ***
Resource    ../../../KeyWords/Emissão/Carregamento/Venda/KeyCarregamentoVenda.robot
Resource    ../../../utils/parametros_pre_condicoes.robot
Resource    ../../../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

#Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal, sem excluir a ordem de entrega
Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar


*** Test Cases ***

Teste 01 - Lançamento de carregamento de venda
    [Tags]    Teste 01

    Dado que acesso o lançamento de carregamento de vendas
    Quando inicio um novo carregamento
    E informo uma descrição valida
    E gravo o carregamento da venda
    Então o carregamento da venda deve ser salvo com sucesso
    Então fecho a tela de carregamento


Teste 02 - Validar status inicial do carregamento
    [Tags]    Teste 02

    Dado que acesso o lançamento de carregamento de vendas
    Quando inicio um novo carregamento
    Então o status deve ser "Cadastrando"
    E gravo o carregamento da venda
    Então fecho a tela de carregamento


Teste 03 - Editar carregamento cadastrado
    [Tags]    Teste 03

    Dado que acesso o lançamento de carregamento de vendas
    E que existe um carregamento cadastrado
    Quando edito o carregamento cadastrado
    E informo uma descrição valida
    E gravo o carregamento da venda
    Então o carregamento da venda deve ser salvo com sucesso
    Então fecho a tela de carregamento


Teste 04 - Excluir carregamento com status cadastrando
    [Tags]    Teste 04

    Dado que acesso o lançamento de carregamento de vendas
    E que existe um carregamento com status    Cadastrando
    Quando excluo o carregamento
    Então o carregamento deve ser excluído com sucesso
    Então fecho a tela de carregamento


Teste 05 - Não permitir excluir carregamento fechado
    [Tags]    Teste 05

    Dado que acesso o lançamento de carregamento de vendas
    E que existe um carregamento com status    Fechada
    Quando excluo o carregamento
    Então o sistema deve impedir a exclusão
    Então fecho a tela de carregamento

Teste 06 - Incluir uma venda no carregamento
    [Tags]    Teste 06

    Dado que acesso o lançamento de carregamento de vendas
    E que existe um carregamento com status    Cadastrando
    Quando incluo uma venda no carregamento
    E gravo o carregamento da venda
    Então a venda deve ser incluída com sucesso no carregamento
    Então fecho a tela de carregamento

