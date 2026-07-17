*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***
Teste 01 - Lançamento de venda com produto normal
    [Tags]    Teste01

    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a venda
    E saio da tela(Venda)

Teste 02 - Lançamento e visualização de venda
    [Tags]    Teste02

    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a venda
    E pesquiso pela venda gerada
    Então visualizo a venda
    E saio da tela(Venda)

Teste 03 - Lançamento e edição de venda
    [Tags]    Teste03

    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a venda - A Prazo
    E pesquiso pela venda gerada
    Quando clico em editar
    E excluo os pagamentos lançados
    Quando insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a venda - A Prazo
    E saio da tela(Venda)

Teste 04 - Lançamento e exclusão de venda
    [Tags]    Teste04

    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a venda - A Prazo
    E pesquiso pela venda gerada
    Então clico em excluir
    E saio da tela(Venda)

Teste 05 - Lançamento de venda com múltiplos produtos
    [Tags]    Teste05

    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um produto normal(2)
    E acesso a aba pagamentos
    Então finalizo a venda
    E saio da tela(Venda)

Teste 06 – Lançamento de venda com aplicação de desconto na finalização
    [Tags]    Teste06

    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal informando a quantidade(1)
    E acesso a aba pagamentos
    Então finalizo a venda - Desconto(5)
    E saio da tela(Venda)

Teste 07 – Lançamento de venda com múltiplos produtos e aplicação de desconto na finalização
    [Tags]    Teste07

    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um produto normal(2)
    E acesso a aba pagamentos
    Então finalizo a venda - Desconto(25)
    E saio da tela(Venda)

# Teste 08 – Lançamento de venda com desconto acima do limite de liberação do supervisor e do desconto máximo do produto
#     [Tags]    Teste08

#     Dado que acesso a tela de vendas de balcão
#     Quando pressiono o atalho de adicionar
#     E adiciono vendedor e cliente
#     Quando insiro um produto normal informando a quantidade(1)
#     E acesso a aba pagamentos
#     Então finalizo a venda - Desconto(25)
    