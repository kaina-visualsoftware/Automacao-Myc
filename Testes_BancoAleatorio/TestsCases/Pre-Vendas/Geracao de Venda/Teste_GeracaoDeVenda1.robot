*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Pré-Venda/Geracao Venda/KeyGeracaoDeVenda1.robot
Resource    ../../../utils/montadorDeCenarios.robot
Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyGeracaoDeVenda1.Ler imagens iniciais    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo um pedido, com produto normal
Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***
Teste 01 – Geração de venda a partir de pedido
    [Tags]    Teste01

    Dado que acesso a tela de geração de vendas
    Quando seleciono o último pedido feito
    E clico em gerar
    Então confirmo a geração da venda

Teste 02 – Visualização do pedido antes da geração da venda
    [Tags]    Teste02

    Dado que acesso a tela de geração de vendas
    Quando seleciono o último pedido feito
    E clico em visualizar
    Quando volto para a tela de geração de venda
    E clico em gerar
    Então confirmo a geração da venda

Teste 03 – Exclusão da venda originada de pedido
    [Tags]    Teste03

    Dado que acesso a tela de geração de vendas
    Quando seleciono o último pedido feito
    E clico em gerar
    Então confirmo a geração da venda
    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.E pesquiso pela venda gerada
    keyVendas1.Então clico em excluir
    E saio da tela(Venda)
    Então verifico se o pedido retornou como aberto

Teste 04 – Geração de venda a partir de múltiplos pedidos
    [Tags]    Teste04
    [Setup]    montadorDeCenarios.Dado que realizo mais de um pedido(2)
    
    Dado que acesso a tela de geração de vendas
    Quando seleciono os ultimos pedidos feitos
    E clico em gerar
    Então confirmo a geração dos pedidos