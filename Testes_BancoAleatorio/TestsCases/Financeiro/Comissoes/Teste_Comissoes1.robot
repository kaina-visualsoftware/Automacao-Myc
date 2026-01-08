*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Financeiro/comissoes/KeyComissoes1.robot
Resource    ../../../utils/montadorDeCenarios.robot
Resource    ../../../utils/parametros_pre_condicoes.robot
Resource    ../../../utils/parametros_admin_sistema.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyComissoes1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal
Test Teardown    parametros_pre_condicoes.Restaurar Parametros Alterados

*** Variables ***
@{Teste_18_Quantidades}    1    3
@{Teste_18_Descontos}      10   15

*** Test Cases ***
Teste 01 - Comissão sobre total da venda e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste01

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)

Teste 02 - Comissão por linha de produto sobre venda e devolução completa, incluindo comissão com valor zerado - Linha
    [Tags]    Teste02 
    [Setup]    montadorDeCenarios.Dado que realizo uma venda e uma devolução completa, com um produto normal
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos - Devolução
    E baixo a comissao recém recebida

Teste 03 - Comissão sobre venda e devolução com múltiplos produtos e baixa de vale-compra da devolução - Linha
    [Tags]    Teste03
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    VALE_COMPRA_DEV_MENOR_ZERO    1    AND    
    ...    Inicializar Pré-Condições    AND    
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
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)
    Então visualizo os detalhes da comissao recem paga
    utils.E saio da tela(Comissoes)

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

Teste 06 - Comissão por linha sobre venda oriunda de uma pré-venda e pagamento da comissão no caixa - Linha
    [Tags]    Teste06
    [Setup]    montadorDeCenarios.Dado que realizo um pedido e gero uma venda total sobre ele

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)

Teste 07 - Comissão sobre total da venda oriunda de uma pré-venda, gerada sobre somente recebidas, e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste07
    [Setup]    montadorDeCenarios.Dado que realizo um pedido e gero uma venda total sobre ele totalmente recebida
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)
    Então visualizo os detalhes da comissao recem paga
    utils.E saio da tela(Comissoes)

Teste 08 - Comissão por linha sobre venda oriunda de uma condicional e pagamento da comissão no caixa - Linha
    [Tags]    Teste08
    [Setup]    montadorDeCenarios.Dado que realizo uma venda total de uma condicional
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)

Teste 09 - Comissão sobre total da venda parcial oriunda de uma condicional e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste09
    [Setup]    montadorDeCenarios.Dado que realizo uma venda parcial de uma condicional
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)

Teste 10 - Comissão sobre total de venda parcial oriunda de uma condicional, gerada sobre somente recebidas, e pagamento da comissão no caixa - Total Venda
    [Tags]    Teste10
    [Setup]    montadorDeCenarios.Dado que realizo uma venda parcial oriunda de uma condicional que esteja totalmente paga

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)
    Então visualizo os detalhes da comissao recem paga
    utils.E saio da tela(Comissoes)

Teste 11 - Comissão por linha de serviço e pagamento da comissão no caixa sem receber a Ordem de Serviço - Linha
    [Tags]    Teste11
    [Setup]    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)

Teste 12 - Comissão por linha de serviço e pagamento da comissão no caixa após a baixa da comissão de uma Ordem de Serviço totalmente recebida - Linha
    [Tags]    Teste12
    [Setup]    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço - Totalmente recebida
    
    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)

Teste 13 - Gerando comissão de venda com múltiplos produtos, recebendo parcela por parcela - Linha
    # Tarefa: 176401 | CT: 1-593
    [Tags]    Teste13
    [Setup]    montadorDeCenarios.Dado que realizo uma venda com mais de um produto e finalizo com múltiplas parcelas personalizadas(3)

    FOR    ${i}    IN RANGE    ${QTDE_PARCELAS_PAG_PERSONALIZADA}

        Set Test Variable    ${POSICAO_PARCELA}    ${i}

        montadorDeCenarios.Dado que realizo o recebimento de uma venda com múltiplas parcelas personalizadas
        
        Dado que acesso a tela de comissões
        Quando insiro o vendedor comissionado
        E seleciono somente as recebidas
        E seleciono a comissão de produtos
        E baixo a comissao recém recebida
        utils.E saio da tela(Comissoes)
        KeyComissoes1.Quando acesso o caixa aberto
        KeyComissoes1.E vou para a aba de contas a pagar
        Então faço o pagamento da comissao
        utils.E saio da tela(CaixaPrincipal)
        Então visualizo os detalhes da comissao recem paga
        utils.E saio da tela(Comissoes)
        
    END

Teste 14 - Comissão por linha sobre venda e devolução somente recebidas e pagamento da comissão no caixa - Linha
    # Tarefa: 172964 | 1-595
    [Tags]    Teste14
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    VALE_COMPRA_DEV_MENOR_ZERO    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    montadorDeCenarios.Dado que realizo uma venda e uma devolução parcial da venda totalmente recebidos no caixa

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão de produtos - Devolução
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)

Teste 15 - Comissão sobre o total da venda em Ordem de Serviço com produto e serviço comissionados por vendedor, aplicando a comissão também ao executor do serviço - Total Venda
    # Tarefa: 176024 | CT: 1-600
    [Tags]    Teste15
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    OS_COMISSAO_VENDEDOR_EXECUTOR    1    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND    
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    utils.E saio da tela(Comissoes)
    Dado que acesso a tela de relatório de comissão
    E gero o relatório de comissões(Pendentes)

Teste 16 - Comissão por linha de produto gerada sobre venda recebida e pagamento da comissão no caixa - Linha
    # CT: 1-362
    [Tags]    Teste16
    [Setup]    Run Keyword    montadorDeCenarios.Dado que realizo uma venda com um produto normal totalmente recebida no caixa - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão da venda
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)

Teste 17 - Comissão por linha de serviço gerada sobre ordem de serviço recebida e pagamento da comissão no caixa - Linha
    # CT: 1-363
    [Tags]    Teste17
    [Setup]    Run Keywords    
    ...    Set Test Variable    @{PARAMS_PRE_CONDICOES}    SELECIONA_FUNCIONARIO_OS    0    AND    
    ...    Inicializar Pré-Condições    AND
    ...    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço totalmente recebida no caixa - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)

Teste 18 - Comissão sobre formas de parcelamento em vendas com múltiplos produtos com desconto, recebidas no caixa, incluindo a geração do relatório de vendas somente recebidas - Forma Parcelamento
    # Tarefa: 173680 | CT: 1-599
    [Tags]    Teste18
    [Setup]    montadorDeCenarios.Dado que realizo uma venda com múltiplos produtos com desconto totalmente recebida no caixa    ${Teste_18_Quantidades}    ${Teste_18_Descontos}

    Dado que acesso a tela de comissões
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissão da venda
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    utils.E saio da tela(CaixaPrincipal)
    Dado que acesso a tela de relatório de comissão
    E gero o relatório de comissões(Pendentes)

Teste 19 - Comissão sobre total da venda com alíquota individual por serviço após inclusão e edição da ordem de serviço - Total Venda
    # Tarefa: 175729 | CT: 1-598
    [Tags]    Teste19
    [Setup]    montadorDeCenarios.Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    utils.E saio da tela(Comissoes)
    montadorDeCenarios.Dado que acesso a edição da ordem de serviço e do serviço lançado
    Dado que acesso a tela de comissões
    Quando insiro o técnico executor de serviço comissionado
    E vou para a aba de servicos
    E seleciono a comissão de serviços
    E baixo a comissao recém recebida
    utils.E saio da tela(Comissoes)