*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Financeiro/Caixa/keyCaixaRevisao1.robot
Resource    ../../../utils/montadorDeCenarios.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce

*** Test Cases ***

CT 1-392 Fechar tela do caixa principal após cancelar um fechamento de caixa

    [Tags]    CT 1-392

    Quando acesso o caixa aberto
    E clico em fechar caixa
    Então cancelo o fechamento do caixa
    E fecho a tela do caixa principal