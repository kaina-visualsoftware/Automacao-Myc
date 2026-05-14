*** Settings ***
Documentation    Testes de Compras Consignadas - Banco Aleatório

Resource    ../../../KeyWords/Compras/compras_consignadas/keyCompras_Consignadas.robot
Resource    ../../../KeyWords/Financeiro/Caixa/keyCaixa1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup      Run Keywords    Start Sikuli Process    AND
...              Conectar ao Banco de Dados              AND
...              Preparar Ambiente MyCommerce
Suite Teardown   Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Variables ***
${QTDE_PADRAO_TESTES}    5
${QTDE_EDITADA}          10
*** Keywords ***
Fluxo Base Compra Consignada
    [Documentation]    Fluxo compartilhado: acessa tela, lança e seleciona compra consignada
    [Arguments]    ${quantidade}=${QTDE_PADRAO_TESTES}
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    Quando adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${quantidade})
    Então finalizo a compra consignada
    E seleciono compra consignada gerada

Fluxo Base Exclusão Compra Consignada
    [Documentation]    Fluxo compartilhado: acessa tela, lança e seleciona todas as compras consignadas para exclusão em lote
    [Arguments]    ${quantidade}=${QTDE_PADRAO_TESTES}
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    Quando adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${quantidade})
    Então finalizo a compra consignada
    E seleciono todas as compras consignadas geradas

*** Test Cases ***
Teste 01 – Lançamento de Compra Consignada
    [Documentation]    Valida o lançamento simples de uma compra consignada
    [Tags]    Teste01    Lancamento
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    Quando adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E saio da tela(ComprasConsignada)

Teste 02 - Visualização de Compra Consignada
    [Documentation]    Valida a visualização de uma compra consignada finalizada
    [Tags]    Teste02    Visualizacao
    [Setup]    Fluxo Base Compra Consignada
    Então visualizo compra consignada
    E saio da tela(LancamentoDeCompraConsignada)
    E saio da tela(ComprasConsignada)

Teste 03 - Exclusão de Compra Consignada
    [Documentation]    Valida a exclusão de uma compra consignada
    [Tags]    Teste03    Exclusao
    [Setup]    Fluxo Base Compra Consignada
    Então pressiono Excluir
    

Teste 04 - Edição de Compra Consignada
    [Documentation]    Valida a edição de uma compra consignada
    [Tags]    Teste04    Edicao
    [Setup]    Fluxo Base Compra Consignada
    Então pressiono Editar
    Então edito a quantidade do produto para(${QTDE_EDITADA})
    Então finalizo a compra consignada
    E saio da tela(ComprasConsignada)

Teste 05 - Exclusão de Compras consignadas em lote
    [Documentation]    Valida a exclusão de compras consignadas em lote
    [Tags]    Teste05    Exclusao_Lote
    [Setup]    Fluxo Base Exclusão Compra Consignada
    Então pressiono Excluir
    E saio da tela(ComprasConsignada)

Teste 06 - Lançamento de Devolução de Compra Consignada
    [Documentation]    Valida o lançamento de uma compra consignada com devolução
    [Tags]    Teste06    Lancamento_Devolucao
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    Quando adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então troco de guia
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E valido se a devolução foi lançada com sucesso