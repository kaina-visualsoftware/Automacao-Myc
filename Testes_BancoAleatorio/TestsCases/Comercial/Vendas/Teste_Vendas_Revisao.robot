*** Settings ***
Documentation    Teste de Revisao - Vendas

Resource    ../../../KeyWords/Comercial/Vendas/KeyVendasRevisao.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords
...    Start Sikuli Process
...    AND    KeyVendasRevisao.Ler imagens iniciais
...    AND    Conectar ao Banco de Dados
...    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Teardown Restaurar Parametros Alterados E Reiniciar MyCommerce Se Necessário


*** Test Cases ***
CT 1-565 - Selecionar cliente na venda com CPF existente
    [Tags]    CT 1-565

    Dado que acesso a tela de vendas de balcao para revisao
    Quando inicio uma nova venda
    E informo o vendedor
    E informo o cliente pelo CPF
    Então a venda com cliente CPF deve estar salva no banco
    E saio da tela(Vendas)