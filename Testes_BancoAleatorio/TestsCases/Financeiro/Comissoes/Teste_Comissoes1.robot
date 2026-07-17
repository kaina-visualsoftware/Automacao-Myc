*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Financeiro/comissoes/KeyComissoes1.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal
Test Teardown    parametros_pre_condicoes.Teardown Restaurar Parametros Alterados E Reiniciar MyCommerce Se Necessário

*** Variables ***
@{Teste_18_Quantidades}    1    3
@{Teste_18_Descontos}      10    15

*** Test Cases ***
Teste 01 - Comissão sobre total da venda e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste01

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)

Teste 02 - Comissão por linha de produto sobre venda e devolução completa, incluindo comissão com valor zerado - Linha Simples
    [Tags]    Teste02
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    Set Test Variable    ${Comissao_Zerada_Por_Devolucao}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda e uma devolução completa, com um produto normal
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos - Devolução
    E baixo a comissao recém recebida

Teste 03 - Comissão sobre venda e devolução com múltiplos produtos e baixa de vale-compra da devolução - Linha Simples
    [Tags]    Teste03
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    VALE_COMPRA_DEV_MENOR_ZERO    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    Set Test Variable    ${Comissao_Zerada_Por_Devolucao}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma devolução com mais de um produto(2)

    Dado que acesso o menu de vale compras
    E seleciono o vale gerado pela devolução
    Quando faço a baixa do mesmo
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos - Devolução
    E baixo a comissao recém recebida

Teste 04 - Comissão sobre total da venda com múltiplos produtos gerada sobre somente recebidas e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste04
    [Setup]    montadorDeCenarios.Dado que realizo uma venda com múltiplos produtos totalmente recebida no caixa(3)

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)
    Então visualizo os detalhes da comissão recém paga
    E saio da tela(Comissoes)

# Teste 05 - Comissão escalonada sobre mesmos produtos, com desconto diferentes - Escalonada
#     [Tags]    Teste05
#     [Setup]    montadorDeCenarios.Realizando vendas com o mesmo produto porém com descontos diferentes
    
#     Dado que acesso a tela de comissões
#     Quando insiro o vendedor comissionado
#     E seleciono as comissaos das vendas
#     E baixo a comissao recém recebida
#     utils.E saio da tela(Comissoes)
#     KeyComissoes1.Quando acesso o caixa aberto
#     KeyComissoes1.E vou para a aba de contas a pagar
#     Então faço o pagamento da comissao

Teste 06 - Comissão por linha sobre venda oriunda de uma pré-venda e pagamento da comissão no caixa - Linha Simples
    [Tags]    Teste06
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo um pedido e gero uma venda total sobre ele

    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)

Teste 07 - Comissão sobre total da venda oriunda de uma pré-venda, gerada sobre somente recebidas, e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste07
    [Setup]    montadorDeCenarios.Dado que realizo um pedido e gero uma venda total sobre ele totalmente recebida
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)
    Então visualizo os detalhes da comissão recém paga
    E saio da tela(Comissoes)

Teste 08 - Comissão por linha sobre venda oriunda de uma condicional e pagamento da comissão no caixa - Linha Simples
    [Tags]    Teste08
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda total de uma condicional
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)

Teste 09 - Comissão sobre total da venda parcial oriunda de uma condicional e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste09
    [Setup]    montadorDeCenarios.Dado que realizo uma venda parcial de uma condicional
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)

Teste 10 - Comissão sobre total de venda parcial oriunda de uma condicional, gerada sobre somente recebidas, e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste10
    [Setup]    montadorDeCenarios.Dado que realizo uma venda parcial oriunda de uma condicional que esteja totalmente paga

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)
    Então visualizo os detalhes da comissão recém paga
    E saio da tela(Comissoes)

Teste 11 - Comissão por linha de serviço e pagamento da comissão no caixa sem receber a Ordem de Serviço - Linha Simples
    [Tags]    Teste11
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)

Teste 12 - Comissão por linha de serviço e pagamento da comissão no caixa após a baixa da comissão de uma Ordem de Serviço totalmente recebida - Linha Simples
    [Tags]    Teste12
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço - Totalmente recebida
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)

Teste 13 - Comissão por linha de produto com múltiplos produtos, com recebimento de parcela por parcela no caixa - Linha Simples
    # Tarefa: 176401 | CT: 1-593
    [Tags]    Teste13
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda com mais de um produto e finalizo com múltiplas parcelas personalizadas(3)

    FOR    ${i}    IN RANGE    ${QTDE_PARCELAS_PAG_PERSONALIZADA}

        Set Test Variable    ${POSICAO_PARCELA}    ${i}

        montadorDeCenarios.Dado que realizo o recebimento de uma venda com múltiplas parcelas personalizadas
        
        Dado que acesso a tela de comissões
        Quando insiro o vendedor comissionado
        E seleciono somente as recebidas
        E seleciono a comissão de produtos
        E baixo a comissao recém recebida
        E saio da tela(Comissoes)
        KeyComissoes1.Quando acesso o caixa aberto
        KeyComissoes1.E vou para a aba de contas a pagar
        Então faço o pagamento da comissao
        E saio da tela(CaixaPrincipal)
        Então visualizo os detalhes da comissão recém paga
        E saio da tela(Comissoes)
        
    END

Teste 14 - Comissão por linha sobre venda e devolução somente recebidas e pagamento da comissão no caixa - Linha Simples
    # Tarefa: 172964 | 1-595
    [Tags]    Teste14
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    VALE_COMPRA_DEV_MENOR_ZERO    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda e uma devolução parcial da venda totalmente recebidos no caixa

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos - Devolução
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 15 - Comissão sobre o total da venda em Ordem de Serviço com produto e serviço comissionados por vendedor, aplicando a comissão também ao executor do serviço - Total Venda
    # Tarefa: 176024 | CT: 1-600
    [Tags]    Teste15
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_COMISSAO_VENDEDOR_EXECUTOR    1    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E saio da tela(Comissoes)
    Dado que acesso a tela de relatório de comissão
    E valido os filtros de produtos e serviços    ${True}    ${True}
    E informo o vendedor comissionado
    E seleciono o tipo da comissão(Pendentes)
    E seleciono para gerar sobre(Vendas)
    Set Test Variable    ${Relatorio_Deve_Conter_Dados}    ${True}
    E gero o relatório de comissões
    E saio da tela(RelatorioComissao)

Teste 16 - Comissão por linha de produto gerada sobre venda recebida e pagamento da comissão no caixa - Linha Simples
    # CT: 1-362
    [Tags]    Teste16
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda com um produto normal totalmente recebida no caixa - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 17 - Comissão por linha de serviço gerada sobre ordem de serviço recebida e pagamento da comissão no caixa - Linha Simples
    # CT: 1-363
    [Tags]    Teste17
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço totalmente recebida no caixa - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 18 - Comissão sobre formas de parcelamento em vendas com múltiplos produtos com desconto, recebidas no caixa, incluindo a geração do relatório de vendas somente recebidas - Forma Parcelamento
    # Tarefa: 173680 | CT: 1-599
    [Tags]    Teste18
    [Setup]    montadorDeCenarios.Dado que realizo uma venda com múltiplos produtos com desconto totalmente recebida no caixa    ${Teste_18_Quantidades}    ${Teste_18_Descontos}

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)
    Dado que acesso a tela de relatório de comissão
    E valido os filtros de produtos e serviços    ${True}    ${False}
    E informo o vendedor comissionado
    E seleciono o tipo da comissão(Pendentes)
    E seleciono para gerar sobre(Somente Recebidas)
    Set Test Variable    ${Relatorio_Deve_Conter_Dados}    ${False}
    E gero o relatório de comissões
    E saio da tela(RelatorioComissao)

Teste 19 - Comissão sobre total da venda com alíquota individual por serviço após inclusão e edição da ordem de serviço - Total Venda
    # Tarefa: 175729 | CT: 1-598
    [Tags]    Teste19
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E saio da tela(Comissoes)
    montadorDeCenarios.Dado que acesso a edição da ordem de serviço e do serviço lançado
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 20 - Comissão por linha de venda com múltiplos produtos gerada sobre somente recebidas e pagamento da comissão no caixa - Linha Simples
    [Tags]    Teste20
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    SIMPLES    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda com múltiplos produtos totalmente recebida no caixa(3)
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    E saio da tela(CaixaPrincipal)
    Então visualizo os detalhes da comissão recém paga
    E saio da tela(Comissoes)

Teste 21 - Comissão sobre total da venda com exclusão e reinserção de produto na edição, e validação no relatório de comissões pendentes - Total Venda
    # Tarefa: 175947 | CT: 1-588
    [Tags]    Teste21
    [Setup]    montadorDeCenarios.Dado que realizo uma venda com apenas um produto e finalizo com múltiplas parcelas personalizadas

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    Set Test Variable    ${comissao_anterior}    ${Total_Comissao}
    E saio da tela(Comissoes)
    Dado que acesso a tela de relatório de comissão
    E informo o vendedor comissionado
    E seleciono o tipo da comissão(Pendentes)
    E seleciono para gerar sobre(Vendas)
    E valido os filtros de produtos e serviços    ${True}    ${False}
    E gero o relatório de comissões
    E saio da tela(RelatorioComissao)
    montadorDeCenarios.Dado que realizo a edição da venda e exclusão e inserção do produto lançado
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E comparo a comissão antes e após a edição da venda
    E saio da tela(Comissoes)
    Dado que acesso a tela de relatório de comissão
    E informo o vendedor comissionado
    E seleciono o tipo da comissão(Pendentes)
    E seleciono para gerar sobre(Vendas)
    E valido os filtros de produtos e serviços    ${True}    ${False}
    E gero o relatório de comissões
    E saio da tela(RelatorioComissao)

# ============================================================================================
# Testes de Comissão por Linha em Serviços — Linha Diferenciada Por Vendedor
# ============================================================================================

# cpv -> tabela `comissaoporlinha_vendedor`
Teste 22 - Comissão por linha diferenciada de serviço com mesmo vendedor, alíquota de venda positiva e parâmetro de vendedor/executor desabilitado - Linha Diferenciada Por Vendedor
    # Parâmetro desabilitado, mesmo vendedor, cpv.Aliquota > 0 --> comissão com cpv.Aliquota
    [Tags]    Teste22
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 23 - Comissão por linha diferenciada de serviço com mesmo vendedor, alíquota de venda zerada e parâmetro de vendedor/executor desabilitado - Linha Diferenciada Por Vendedor
    # Parâmetro desabilitado, mesmo vendedor, cpv.Aliquota = 0 --> comissão = 0
    [Tags]    Teste23
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 24 - Comissão por linha diferenciada de serviço com vendedores diferentes, executor com alíquota de venda positiva e parâmetro de vendedor/executor desabilitado - Linha Diferenciada Por Vendedor
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota > 0 --> só executor recebe
    [Tags]    Teste24
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 25 - Comissão por linha diferenciada de serviço com vendedores diferentes, executor com alíquota de venda zerada e parâmetro de vendedor/executor desabilitado - Linha Diferenciada Por Vendedor
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota = 0 --> NINGUÉM recebe
    [Tags]    Teste25
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 26 - Comissão por linha diferenciada de serviço com mesmo vendedor, alíquota de venda positiva, alíquota de execução zerada e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # Parâmetro habilitado, mesmo vendedor, cpv.Aliquota > 0 e cpv.AliquotaExecucao = 0 --> usa cpv.Aliquota
    [Tags]    Teste26
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 27 - Comissão por linha diferenciada de serviço com mesmo vendedor, alíquota de venda zerada, alíquota de execução positiva e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # Parâmetro habilitado, mesmo vendedor, cpv.Aliquota = 0, cpv.AliquotaExecucao > 0 --> usa cpv.AliquotaExecucao
    [Tags]    Teste27
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 28 - Comissão por linha diferenciada de serviço com mesmo vendedor, ambas alíquotas positivas e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # Parâmetro habilitado, mesmo vendedor, cpv.Aliquota > 0 E cpv.AliquotaExecucao > 0 --> Soma as duas alíquotas
    [Tags]    Teste28
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 29 - Comissão por linha diferenciada de serviço com vendedores diferentes, executor com alíquota de execução positiva e vendedor com alíquota de venda positiva e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao > 0, vendedor com cpv.Aliquota > 0 --> ambos recebem
    [Tags]    Teste29
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E preparo a baixa do executor após baixa do vendedor OS
    E saio da tela(Comissoes)
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços do executor
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    Então visualizo os detalhes da comissão paga do vendedor OS e do executor
    E saio da tela(Comissoes)

Teste 30 - Comissão por linha diferenciada de serviço com vendedores diferentes, executor com alíquota de execução positiva e vendedor com alíquota de venda zerada e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao > 0, vendedor com cpv.Aliquota = 0 --> só executor recebe
    [Tags]    Teste30
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 31 - Comissão por linha diferenciada de serviço com vendedores diferentes, executor com alíquota de execução zerada e vendedor com alíquota de venda positiva e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao = 0, vendedor com cpv.Aliquota > 0 --> só vendedor recebe
    [Tags]    Teste31
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 32 - Comissão por linha diferenciada de serviço com vendedores diferentes, executor e vendedor ambos com alíquotas zeradas e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao = 0, vendedor com cpv.Aliquota = 0 --> NINGUÉM recebe
    [Tags]    Teste32
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__DIF_POR_VEND__DIF_EXEC__EXEC_SEM_ALIQEXEC__VEND_SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# ============================================================================================
# Testes de Comissão por Linha em Serviços — Linha Mista
# ============================================================================================

Teste 33 - Comissão por linha mista de serviço com mesmo vendedor, alíquota de venda diferenciada positiva e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, mesmo vendedor, cpv.Aliquota > 0 (dif. por vend.) --> usa cpv.Aliquota
    [Tags]    Teste33
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 34 - Comissão por linha mista de serviço com mesmo vendedor, alíquota de venda diferenciada zerada e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, mesmo vendedor, cpv.Aliquota = 0 --> comissão 0
    [Tags]    Teste34
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 35 - Comissão por linha mista de serviço com mesmo vendedor, sem registro de aliquota de venda diferenciada, usando alíquota geral mista e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, mesmo vendedor, SEM registro na tabela `comissaoporlinha_vendedor` --> usa Aliquota Geral Mista
    [Tags]    Teste35
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 36 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de venda diferenciada positiva, vendedor com alíquota de venda diferenciada positiva e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota > 0, vendedor com cpv.Aliquota > 0 --> só executor recebe
    [Tags]    Teste36
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 37 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de venda diferenciada positiva e vendedor com alíquota de venda diferenciada zerada e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota > 0, vendedor com cpv.Aliquota = 0 --> só executor recebe
    [Tags]    Teste37
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_COM_ALIQ_ZERO    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 38 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de venda diferenciada positiva, vendedor sem registro de alíquota de venda diferenciada e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota > 0, vendedor SEM registro na tabela `comissaoporlinha_vendedor`--> só executor recebe
    [Tags]    Teste38
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ__VEND_SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 39 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de venda diferenciada zerada, vendedor com alíquota de venda diferenciada positiva e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota = 0 --> NINGUÉM recebe
    [Tags]    Teste39
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 40 - Comissão por linha mista de serviço com vendedores diferentes, executor e vendedor ambos com alíquota de venda diferenciada zerada e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota = 0, vendedor com cpv.Aliquota = 0 --> NINGUÉM recebe
    [Tags]    Teste40
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 41 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de venda diferenciada zerada, vendedor sem registro de alíquota de venda diferenciada e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor com cpv.Aliquota = 0, vendedor SEM registro na tabela `comissaoporlinha_vendedor` --> NINGUÉM recebe
    [Tags]    Teste41
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_COM_ALIQ_ZERO__VEND_SEM_REG_CPLV    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 42 - Comissão por linha mista de serviço com mesmo vendedor, alíquota de venda diferenciada positiva, alíquota de execução diferenciada zerada e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, mesmo vendedor, cpv.Aliquota > 0, cpv.AliquotaExecucao = 0 --> usa cpv.Aliquota
    [Tags]    Teste42
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 43 - Comissão por linha mista de serviço com mesmo vendedor, alíquota de venda diferenciada zerada, alíquota de execução diferenciada positiva e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, mesmo vendedor, cpv.Aliquota = 0, cpv.AliquotaExecucao > 0 --> usa cpv.AliquotaExecucao
    [Tags]    Teste43
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 44 - Comissão por linha mista de serviço com mesmo vendedor, ambas alíquotas diferenciadas positivas e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, mesmo vendedor, cpv.Aliquota > 0 E cpv.AliquotaExecucao > 0 --> Soma as duas alíquotas
    [Tags]    Teste44
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 45 - Comissão por linha mista de serviço com mesmo vendedor, sem registro de alíquotas diferenciadas, usando alíquota geral mista dobrada e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, mesmo vendedor, SEM registro na tabela `comissaoporlinha_vendedor` --> 2 × Aliquota Geral Mista
    [Tags]    Teste45
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 46 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de execução diferenciada positiva, vendedor com alíquota de venda diferenciada positiva e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao > 0, vendedor com cpv.Aliquota > 0 --> ambos recebem
    [Tags]    Teste46
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E preparo a baixa do executor após baixa do vendedor OS
    E saio da tela(Comissoes)
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços do executor
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    Então visualizo os detalhes da comissão paga do vendedor OS e do executor
    E saio da tela(Comissoes)

Teste 47 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de execução diferenciada positiva, vendedor com alíquota de venda diferenciada zerada e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao > 0, vendedor com cpv.Aliquota = 0 --> só executor recebe
    [Tags]    Teste47
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_COM_ALIQ_ZERO    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 48 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de execução diferenciada positiva, vendedor sem registro de alíquotas diferenciadas, usando alíquota geral mista e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao > 0, vendedor SEM registro na tabela `comissaoporlinha_vendedor` --> executor c/ AliqExec, vendedor OS c/ alíquota geral
    [Tags]    Teste48
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC__VEND_SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E preparo a baixa do executor após baixa do vendedor OS
    E saio da tela(Comissoes)
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços do executor
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    Então visualizo os detalhes da comissão paga do vendedor OS e do executor
    E saio da tela(Comissoes)

Teste 49 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de execução diferenciada zerada, vendedor com alíquota de venda diferenciada positiva e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao = 0, vendedor com cpv.Aliquota > 0 --> só vendedor OS recebe
    [Tags]    Teste49
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 50 - Comissão por linha mista de serviço com vendedores diferentes, executor e vendedor ambos sem registro de alíquotas diferenciadas, usando alíquota geral mista e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor SEM registro na tabela `comissaoporlinha_vendedor`, vendedor SEM registro na tabela `comissaoporlinha_vendedor` --> ambos usam Aliquota Geral Mista
    [Tags]    Teste50
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E preparo a baixa do executor após baixa do vendedor OS
    E saio da tela(Comissoes)
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços do executor
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    Então visualizo os detalhes da comissão paga do vendedor OS e do executor
    E saio da tela(Comissoes)

Teste 51 - Comissão por linha mista de serviço com vendedores diferentes, executor sem registro de alíquotas diferenciadas, usando alíquota geral mista, vendedor com alíquota de venda diferenciada positiva e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor SEM registro na tabela `comissaoporlinha_vendedor`, vendedor com cpv.Aliquota > 0 --> Vendedor não recebe, Executor recebe (usa Aliquota Geral Mista);
    [Tags]    Teste51
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 52 - Comissão por linha mista de serviço com vendedores diferentes, executor sem registro de alíquotas diferenciadas, usando alíquota geral mista, vendedor com alíquota de venda diferenciada zerada e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor SEM registro na tabela `comissaoporlinha_vendedor`, vendedor com cpv.Aliquota = 0 --> Vendedor não recebe, Executor recebe (usa Aliquota Geral Mista);
    [Tags]    Teste52
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 53 - Comissão por linha mista de serviço com vendedores diferentes, executor e vendedor ambos sem registro de alíquotas diferenciadas, usando alíquota geral mista e parâmetro de vendedor/executor desabilitado - Linha Mista
    # Parâmetro desabilitado, vendedores diferentes, executor SEM registro na tabela `comissaoporlinha_vendedor`, vendedor OS SEM registro na tabela `comissaoporlinha_vendedor` → Vendedor não recebe, Executor recebe (usa Aliquota Geral Mista)
    [Tags]    Teste53
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_DESAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 54 - Comissão por linha mista de serviço com vendedores diferentes, executor com alíquota de execução diferenciada zerada, vendedor com alíquota de venda diferenciada zerada e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor com cpv.AliquotaExecucao = 0, vendedor com cpv.Aliquota = 0 → NINGUÉM recebe
    [Tags]    Teste54
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_COM_ALIQEXEC_ZERO__VEND_COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 55 - Comissão por linha mista de serviço com vendedores diferentes, executor sem registro de alíquotas diferenciadas, usando alíquota geral mista, vendedor com alíquota de venda diferenciada zerada e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor SEM registro na tabela `comissaoporlinha_vendedor`, vendedor com cpv.Aliquota = 0 → Vendedor não recebe, Executor recebe (usa Aliquota Geral Mista);
    [Tags]    Teste55
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ_ZERO    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 56 - Comissão por linha mista de serviço com vendedores diferentes, executor sem registro de alíquotas diferenciadas, usando alíquota geral mista, vendedor com alíquota de venda diferenciada positiva e parâmetro de vendedor/executor habilitado - Linha Mista
    # Parâmetro habilitado, vendedores diferentes, executor SEM registro na tabela `comissaoporlinha_vendedor` --> Aliquota Geral Mista, vendedor com cpv.Aliquota > 0 --> ambos recebem;
    [Tags]    Teste56
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PARAM_HAB__MISTA__DIF_EXEC__EXEC_SEM_REG_CPLV__VEND_COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E preparo a baixa do executor após baixa do vendedor OS
    E saio da tela(Comissoes)
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços do executor
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    Então visualizo os detalhes da comissão paga do vendedor OS e do executor
    E saio da tela(Comissoes)

# ============================================================================================
# Testes de Comissão por Linha em Produtos — Linha Diferenciada Por Vendedor
# ============================================================================================

Teste 57 - Comissão por linha diferenciada de produto, com alíquota de venda diferenciada positiva, sobre venda de balcão - Linha Diferenciada Por Vendedor
    # Venda balcão, cpv.Aliquota > 0 --> gera comissão
    [Tags]    Teste57
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 58 - Comissão por linha diferenciada de produto, com alíquota de venda diferenciada positiva, sobre OS somente com produto - Linha Diferenciada Por Vendedor
    # OS somente com produto, cpv.Aliquota > 0 --> gera comissão de produto
    [Tags]    Teste58
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 59 - Comissão por linha diferenciada de produto, com alíquota de venda diferenciada zerada, sobre venda de balcão - Linha Diferenciada Por Vendedor
    # Venda balcão, cpv.Aliquota = 0 --> comissão = 0
    [Tags]    Teste59
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 60 - Comissão por linha diferenciada de produto, com alíquota de venda diferenciada zerada, sobre OS somente com produto - Linha Diferenciada Por Vendedor
    # OS somente com produto, cpv.Aliquota = 0 --> comissão = 0
    [Tags]    Teste60
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# ============================================================================================
# Testes de Comissão por Linha em Produtos — Linha Mista
# ============================================================================================

Teste 61 - Comissão por linha mista de produto, com alíquota de venda diferenciada positiva, sobre venda de balcão - Linha Mista
    # Venda balcão, cpv.Aliquota > 0 --> usa cpv.Aliquota
    [Tags]    Teste61
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 62 - Comissão por linha mista de produto, com alíquota de venda diferenciada positiva, sobre OS somente com produto - Linha Mista
    # OS somente com produto, cpv.Aliquota > 0 --> usa cpv.Aliquota
    [Tags]    Teste62
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 63 - Comissão por linha mista de produto, com alíquota de venda diferenciada zerada, sobre venda de balcão - Linha Mista
    # Venda balcão, cpv.Aliquota = 0 --> comissão = 0
    [Tags]    Teste63
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 64 - Comissão por linha mista de produto, com alíquota de venda diferenciada zerada, sobre OS somente com produto - Linha Mista
    # OS somente com produto, cpv.Aliquota = 0 --> comissão = 0
    [Tags]    Teste64
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 65 - Comissão por linha mista de produto, sem registro de alíquota de venda diferenciada, usando alíquota geral mista, sobre venda de balcão - Linha Mista
    # Venda balcão, vendedor SEM registro na tabela `comissaoporlinha_vendedor` --> usa Aliquota Geral Mista;
    [Tags]    Teste65
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 66 - Comissão por linha mista de produto, sem registro alíquota de venda diferenciada, usando alíquota geral mista, sobre OS somente com produto - Linha Mista
    # OS somente com produto, vendedor SEM registro na tabela `comissaoporlinha_vendedor` --> usa Aliquota Geral Mista
    [Tags]    Teste66
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# ============================================================================================
# Testes de Comissão por Linha em Produtos e Serviços — Linha Diferenciada Por Vendedor
# ============================================================================================

Teste 67 - Comissão por linha diferenciada de produto com alíquota de venda diferenciada positiva e serviço com alíquota de venda diferenciada positiva, sobre OS com produto e serviço e parâmetro de vendedor/executor desabilitado - Linha Diferenciada Por Vendedor
    # OS prod+serv | Produto: cpv.Aliq>0 → gera | Serviço: cpv.Aliq>0 → gera | Param desab
    [Tags]    Teste67
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__COM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 68 - Comissão por linha diferenciada de produto com alíquota de venda diferenciada zerada e serviço com alíquota de venda diferenciada zerada, sobre OS com produto e serviço e parâmetro de vendedor/executor desabilitado - Linha Diferenciada Por Vendedor
    # OS prod+serv | Produto: cpv.Aliq=0 → NÃO gera | Serviço: cpv.Aliq=0 → NÃO gera | Param desab
    [Tags]    Teste68
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_DESAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 69 - Comissão por linha diferenciada de produto com alíquota de venda diferenciada positiva e serviço com alíquota de venda positiva e alíquota de execução zerada, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # OS prod+serv | Produto: cpv.Aliq>0 → gera com cpv.Aliq | Serviço: Aliq>0, AliqExec=0 → gera com cpv.Aliq | Param hab
    [Tags]    Teste69
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__COM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_ALIQ__SEM_ALIQEXEC    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 70 - Comissão por linha diferenciada de produto com alíquota de venda diferenciada positiva e serviço com ambas alíquotas positivas, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # OS prod+serv | Produto: cpv.Aliq>0 → gera com cpv.Aliq | Serviço: Aliq>0 e AliqExec>0 → gera com cpv.Aliq | Param hab
    [Tags]    Teste70
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__COM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__DIF_POR_VEND__MESMO_VEND__COM_AMBAS_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 71 - Comissão por linha diferenciada de produto com alíquota de venda diferenciada zerada e serviço com alíquota de venda zerada e alíquota de execução positiva, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # OS prod+serv | Produto: cpv.Aliq=0 → NÃO gera | Serviço: Aliq=0, AliqExec>0 → gera com cpv.AliqExec | Param hab
    [Tags]    Teste71
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_ALIQ__COM_ALIQEXEC    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 72 - Comissão por linha diferenciada de produto com alíquota de venda diferenciada zerada e serviço com ambas alíquotas zeradas, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Diferenciada Por Vendedor
    # OS prod+serv | Produto: cpv.Aliq=0 → NÃO gera | Serviço: Aliq=0 e AliqExec=0 → NÃO gera | Param hab
    [Tags]    Teste72
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__DIF_POR_VEND__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__DIF_POR_VEND__MESMO_VEND__SEM_AMBAS_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# ============================================================================================
# Testes de Comissão por Linha em Produtos e Serviços — Linha Mista
# ============================================================================================

Teste 73 - Comissão por linha mista de produto com alíquota de venda diferenciada positiva e serviço com alíquota de venda diferenciada positiva, sobre OS com produto e serviço e parâmetro de vendedor/executor desabilitado - Linha Mista
    # OS prod+serv | Produto: cpv.Aliq>0 → gera com cpv.Aliq | Serviço: cpv.Aliq>0 → gera com cpv.Aliq | Param desab
    [Tags]    Teste73
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 74 - Comissão por linha mista de produto com alíquota de venda diferenciada zerada e serviço com alíquota de venda diferenciada zerada, sobre OS com produto e serviço e parâmetro de vendedor/executor desabilitado - Linha Mista
    # OS prod+serv | Produto: cpv.Aliq=0 → NÃO gera | Serviço: cpv.Aliq=0 → NÃO gera | Param desab
    [Tags]    Teste74
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_DESAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 75 - Comissão por linha mista de produto sem registro de alíquota de venda diferenciada usando alíquota geral mista e serviço sem registro de alíquota diferenciada usando alíquota geral mista, sobre OS com produto e serviço e parâmetro de vendedor/executor desabilitado - Linha Mista
    # OS prod+serv | Produto: sem cpv → gera com Aliq Geral Mista | Serviço: sem cpv → gera com Aliq Geral Mista | Param desab
    [Tags]    Teste75
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__SEM_REG_CPLV    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_DESAB__MISTA__MESMO_VEND__SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 76 - Comissão por linha mista de produto com alíquota de venda diferenciada positiva e serviço com alíquota de venda positiva e alíquota de execução zerada, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Mista
    # OS prod+serv | Produto: cpv.Aliq>0 → gera com cpv.Aliq| Serviço: Aliq>0, AliqExec=0 → gera com cpv.Aliq | Param hab
    [Tags]    Teste76
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ__COM_ALIQEXEC_ZERO    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 77 - Comissão por linha mista de produto com alíquota de venda diferenciada positiva e serviço com ambas alíquotas positivas, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Mista
    # OS prod+serv | Produto: cpv.Aliq>0 → gera com cpv.Aliq | Serviço: Aliq>0 e AliqExec>0 → gera com cpv.Aliq + cpv.AliqExec | Param hab
    [Tags]    Teste77
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__MISTA__MESMO_VEND__COM_AMBAS_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 78 - Comissão por linha mista de produto com alíquota de venda diferenciada zerada e serviço com alíquota de venda zerada e alíquota de execução positiva, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Mista
    # OS prod+serv | Produto: cpv.Aliq=0 → NÃO gera | Serviço: Aliq=0, AliqExec>0 → gera com cpv.AliqExec | Param hab
    [Tags]    Teste78
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 79 - Comissão por linha mista de produto com alíquota de venda diferenciada zerada e serviço com ambas alíquotas zeradas, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Mista
    # OS prod+serv | Produto: cpv.Aliq=0 → NÃO gera | Serviço: Aliq=0 e AliqExec=0 → NÃO gera | Param hab
    [Tags]    Teste79
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__COM_ALIQ_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__MISTA__MESMO_VEND__COM_ALIQ_ZERO__COM_ALIQEXEC_ZERO    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 80 - Comissão por linha mista de produto sem registro de alíquota de venda diferenciada usando alíquota geral mista e serviço sem registro de alíquota diferenciada usando dupla alíquota geral mista, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Linha Mista
    # OS prod+serv | Produto: sem cpv → usa Geral → gera com Aliq Geral Mista | Serviço: sem cpv → gera com 2xAliq Geral Mista | Param hab
    [Tags]    Teste80
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__MISTA__SEM_REG_CPLV    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha_Servico}    PARAM_HAB__MISTA__MESMO_VEND__SEM_REG_CPLV    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# ============================================================================================
# Comissão Escalonada — Tipo Padrão
# ============================================================================================

Teste 81 - Comissão escalonada de produto, com desconto aleatório sobre faixa de comissão, sobre venda de balcão - Escalonada
    # Venda balcão | Produto: comissão via faixa ce.Comissao baseada no desconto do produto
    [Tags]    Teste81
    [Setup]    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal e desconto escalonada

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 82 - Comissão escalonada de produto com mesmo vendedor comissionado por percentual de serviço, sobre OS com produto e serviço e parâmetro de vendedor/executor desabilitado - Escalonada
    # OS prod+serv | Param desab | Vendedor_OS: ComissaoPercentualServicos > 0 | Produto: ce.Comissao | Serviço: clientes.ComissaoPercentualServicos
    [Tags]    Teste82
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço e desconto escalonada

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 83 - Comissão escalonada de produto com mesmo vendedor sem percentual de serviço, sobre OS com produto e serviço e parâmetro de vendedor/executor desabilitado - Escalonada
    # OS prod+serv | Param desab | Vendedor_OS: ComissaoPercentualServicos = 0/NULL | Produto: ce.Comissao | Serviço: NÃO gera
    [Tags]    Teste83
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço e desconto escalonada

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 84 - Comissão escalonada de produto com mesmo vendedor comissionado por percentual de serviço, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Escalonada
    # OS prod+serv | Param hab | Mesmo vendedor | Vendedor_OS: ComissaoPercentualServicos > 0 | Produto: ce.Comissao | Serviço: clientes.ComissaoPercentualServicos
    [Tags]    Teste84
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço e desconto escalonada

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 85 - Comissão escalonada de produto com mesmo vendedor sem percentual de serviço, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Escalonada
    # OS prod+serv | Param hab | Mesmo vendedor | Vendedor_OS: ComissaoPercentualServicos = 0/NULL | Produto: ce.Comissao | Serviço: NÃO gera
    [Tags]    Teste85
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço e desconto escalonada

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 86 - Comissão escalonada de produto com vendedores diferentes e executor comissionado por percentual de serviço, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Escalonada
    # OS prod+serv | Param hab | Vendedores diferentes | Executor: ComissaoPercentualServicos > 0 | Produto: ce.Comissao (vend_os) | Serviço: clientes.ComissaoPercentualServicos (executor)
    [Tags]    Teste86
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço e desconto escalonada, com vendedor e técnico executor distintos

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços do executor
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 87 - Comissão escalonada de produto com vendedores diferentes e executor sem percentual de serviço, sobre OS com produto e serviço e parâmetro de vendedor/executor habilitado - Escalonada
    # OS prod+serv | Param hab | Vendedores diferentes | Executor: ComissaoPercentualServicos = 0/NULL | Produto: ce.Comissao (vend_os) | Serviço: NÃO gera para executor
    [Tags]    Teste87
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    OS_COMISSAO_VENDEDOR_EXECUTOR    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Servico}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço e desconto escalonada, com vendedor e técnico executor distintos

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# =================================================
# Comissão por Linha — Tabela de Preço
# =================================================

# cpt -> tabela `comissaoporlinha_tabpreco`
Teste 88 - Comissão por linha tabela de preço de produto, com alíquota positiva, sobre venda de balcão - Linha Tabela de Preco
    # Venda balcão | cpt.Aliquota > 0 --> gera comissão de produto
    [Tags]    Teste88
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__TAB_PRECO__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 89 - Comissão por linha tabela de preço de produto, com alíquota zerada, sobre venda de balcão - Linha Tabela de Preco
    # Venda balcão | cpt.Aliquota = 0 --> NÃO gera comissão
    [Tags]    Teste89
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__TAB_PRECO__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 90 - Comissão por linha tabela de preço de produto, com alíquota positiva, sobre OS somente com produto - Linha Tabela de Preco
    # OS somente com produto | cpt.Aliquota > 0 --> gera comissão de produto
    [Tags]    Teste90
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__TAB_PRECO__COM_ALIQ    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 91 - Comissão por linha tabela de preço de produto, com alíquota zerada, sobre OS somente com produto - Linha Tabela de Preco
    # OS somente com produto | cpt.Aliquota = 0 --> NÃO gera comissão
    [Tags]    Teste91
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Linha}    PROD__TAB_PRECO__SEM_ALIQ    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# ============================================================================================
# Comissão por Tabela de Preço — Geral
# ============================================================================================

Teste 92 - Comissão por tabela de preço geral de produto, com percentual de comissão positivo, sobre venda de balcão - Tabela de Preço Geral
    # Venda balcão | PermiteVariasTabelas = 1 | Produto sem vínculo comissão por linha | tp.PercentualComissao > 0 --> gera comissão
    [Tags]    Teste92
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    PERMITE_VARIAS_TABELAS    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Tabela_Preco}    PROD__TAB_PRECO_GERAL__COM_PERC    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto sem comissão por linha

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 93 - Comissão por tabela de preço geral de produto, com percentual de comissão zerado, sobre venda de balcão - Tabela de Preço Geral
    # Venda balcão | PermiteVariasTabelas = 1 | Produto sem vínculo comissão por linha | tp.PercentualComissao = 0 --> NÃO gera comissão
    [Tags]    Teste93
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    PERMITE_VARIAS_TABELAS    1    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Tabela_Preco}    PROD__TAB_PRECO_GERAL__SEM_PERC    AND    
    ...    Set Test Variable    ${Cenario_Sem_Comissao_Produto}    ${True}    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto sem comissão por linha

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

# ============================================================================================
# Comissão por Tabela de Preço — Escalonada (ComissaoDiferenciadapor = 'TPE')
# ============================================================================================

# tpe -> tabela `comissao_escalonadatab`
Teste 94 - Comissão por tabela de preço escalonada de produto, com desconto aleatório sobre faixa de comissão, sobre venda de balcão - Tabela de Preço Escalonada
    # Venda balcão | Vendedor com ComissaoDiferenciadapor = 'TPE' | Produto com desconto aleatório --> aplica faixa correspondente
    [Tags]    Teste94
    [Setup]    Run Keywords    
    ...    Set Test Variable    ${Cenario_Comissao_Tabela_Preco}    PROD__TAB_PRECO_ESCALONADA__COM_DESC    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal e desconto tabela de preço escalonada

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)

Teste 95 - Comissão por tabela de preço escalonada de produto, com desconto aleatório sobre faixa de comissão, sobre OS somente com produto - Tabela de Preço Escalonada
    # OS somente com produto | Vendedor com ComissaoDiferenciadapor = 'TPE' | Produto com desconto aleatório --> aplica faixa correspondente
    [Tags]    Teste95
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    Reiniciar MyCommerce Se Necessário    AND    
    ...    Set Test Variable    ${Cenario_Comissao_Tabela_Preco}    PROD__TAB_PRECO_ESCALONADA__COM_DESC    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com produto e desconto tabela de preço escalonada - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    E saio da tela(Comissoes)