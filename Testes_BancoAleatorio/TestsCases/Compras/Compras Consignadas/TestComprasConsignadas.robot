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

*** Test Cases ***
Teste 01 – Lançamento de Compra Consignada
    [Documentation]    Valida o lançamento simples de uma compra consignada
    [Tags]    Teste01    Lancamento
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    keyCompras_Consignadas.E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E saio da tela(ComprasConsignada)

Teste 02 - Visualização de Compra Consignada
    [Documentation]    Valida a visualização de uma compra consignada finalizada
    [Tags]    Teste02    Visualizacao
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    keyCompras_Consignadas.E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E seleciono compra consignada gerada
    Então visualizo compra consignada
    E saio da tela(LancamentoDeCompraConsignada)
    E saio da tela(ComprasConsignada)

Teste 03 - Exclusão de Compra Consignada
    [Documentation]    Valida a exclusão de uma compra consignada
    [Tags]    Teste03    Exclusao
  
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    keyCompras_Consignadas.E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E seleciono compra consignada gerada
    Então pressiono Excluir
    E saio da tela(ComprasConsignada)
    
Teste 04 - Edição de Compra Consignada
    [Documentation]    Valida a edição de uma compra consignada
    [Tags]    Teste04    Edicao
    
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    keyCompras_Consignadas.E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E seleciono compra consignada gerada
    Então pressiono Editar
    Então edito a quantidade do produto para(${QTDE_EDITADA})
    Então finalizo a compra consignada
    E saio da tela(ComprasConsignada)

Teste 05 - Exclusão de Compras consignadas em lote
    [Documentation]    Valida a exclusão de compras consignadas em lote
    [Tags]    Teste05    Exclusao_Lote

    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    keyCompras_Consignadas.E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E seleciono todas as compras consignadas geradas
    Então pressiono Excluir
    E saio da tela(ComprasConsignada)

Teste 06 - Lançamento de Devolução de Compra Consignada
    [Documentation]    Valida o lançamento de uma compra consignada com devolução
    [Tags]    Teste06    Lancamento_Devolucao

    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    E Abro Aba de Devolução
    E insiro o mesmo produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E valido se a devolução foi lançada com sucesso
    E saio da tela(ComprasConsignada)

Teste 07 - Pagamento de Compra Consignada 
    [Documentation]    Valida o pagamento de uma compra consignada no caixa
    [Tags]    Teste07    Pagamento_Caixa
    
    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E seleciono compra consignada gerada
    Então pressiono pagar
    Então desdobro forma de pagamento
    Então finalizo pagamento
    E valido contas a receber em caixa      
    E saio da tela(ComprasConsignada)

#caso de teste baseado na Tarefa #101167 VALOR DE COMPRA INCORRETO - COMPRA CONSIGNADA
Teste 08 - Validação do valor da conta a pagar gerada para compra consignada
    [Documentation]    Valida se o valor da conta a pagar gerada para a compra consignada está correto no banco de dados
    [Tags]    Teste08    Validacao_Valor_Conta_Pagar

    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})  
    E Abro Aba de Devolução
    E insiro o mesmo produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então excluo o produto da compra consignada
    Então finalizo a compra consignada
    E valido valor da compra     
    E saio da tela(ComprasConsignada)

Teste 09 - Validação do valor da conta a pagar gerada para compra consignada com devolução
    [Documentation]    Valida se o valor da conta a pagar gerada para a compra consignada com devolução está correto no banco de dados
    [Tags]    Teste09    Validacao_Valor_Conta_Pagar_Devolucao

    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})  
    E Abro Aba de Devolução
    E insiro o mesmo produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então finalizo a compra consignada
    E valido valor da compra     
    E saio da tela(ComprasConsignada)



Teste 10 - Validação do pagamento de compra consignada com devolução
    [Documentation]    Valida o pagamento no caixa de uma compra consignada com devolução
    [Tags]    Teste10    Validacao_Pagamento_Compra_Consignada_Devolucao

    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})  
    E Abro Aba de Devolução
    E insiro o mesmo produto normal informando a quantidade(1)
    Então finalizo a compra consignada
    E valido valor da compra
    E seleciono compra consignada gerada
    Então pressiono pagar
    Então desdobro forma de pagamento
    Então finalizo pagamento
    E valido contas a receber em caixa      
    E saio da tela(ComprasConsignada)

Teste 11 - Validação do pagamento de compra consignada com devolução e exclusão de produto
    [Documentation]    Valida o pagamento no caixa de uma compra consignada com devolução e exclusão de produto
    [Tags]    Teste11    Validacao_Pagamento_Compra_Consignada_Devolucao_Exclusao

    Dado que eu acesso a tela de Compras Consignadas
    Quando eu pressionar em adicionar
    E adiciono Fornecedor
    E insiro um produto normal informando a quantidade(${QTDE_PADRAO_TESTES})  
    E Abro Aba de Devolução
    E insiro o mesmo produto normal informando a quantidade(${QTDE_PADRAO_TESTES})
    Então excluo o produto da compra consignada
    Então finalizo a compra consignada
    E seleciono compra consignada gerada
    Então pressiono pagar
    Então desdobro forma de pagamento
    Então finalizo pagamento
    E valido contas a receber em caixa      
    E saio da tela(ComprasConsignada)


