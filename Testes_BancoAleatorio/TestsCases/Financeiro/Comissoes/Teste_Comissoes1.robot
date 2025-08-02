*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../../../KeyWords/Financeiro/comissoes/KeyComissoes1.robot
Resource     ../../../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyComissoes1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

*** Test Cases ***
Teste 01 - Gerando comissao sobre venda simples - Total Venda
    [Tags]    Teste01
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

Teste 02 - Gerando comissão sobre venda e devolução - Linha
    [Tags]    Teste02 
    [Setup]    montadorDeCenarios.Dado que realizo uma devolução avulsa 
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissão da venda e devolução 
    E baixo a comissao recém recebida
    # KeyComissoes1.Quando acesso o caixa aberto
    # KeyComissoes1.E vou para a aba de contas a pagar
    #Então faço o pagamento da comissao

Teste 03 - Gerando comissão sobre venda e devolução - Linha
    [Tags]    Teste03
    [Setup]    montadorDeCenarios.Dado que realizo uma devolução com mais de um produto(2)
    Dado que acesso o menu de vale compras
    E seleciono o vale gerado pela devolução
    Quando faço a baixa do mesmo
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissão da venda e devolução 
    E baixo a comissao recém recebida

Teste 04 - Gerando comissao sobre somente recebidas - Total Venda
    [Tags]    Teste04
    [Setup]    montadorDeCenarios.Dado que realizo uma venda totalmente recebida(3)
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    Então visualizo os detalhes da comissao recem paga

Teste 05 - Gerando comissão escalonada sobre mesmos produtos, com desconto diferentes - Escalonada
    [Tags]    Teste05
    [Setup]    montadorDeCenarios.Realizando vendas com o mesmo produto porém com descontos diferentes
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono as comissaos das vendas
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

Teste 06 - Gerando comissao de venda oriunda de pedidp - Linha
    [Tags]    Teste06
    [Setup]    montadorDeCenarios.Dado que realizo um pedido e gero uma venda total sobre ele 
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

Teste 07 - Gerando comissao de venda oriunda de pedido - Total Venda
    [Tags]    Teste07
    [Setup]    montadorDeCenarios.Dado que realizo um pedido e gero uma venda total sobre ele totalmente recebida 
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    Então visualizo os detalhes da comissao recem paga

Teste 08 - Gerando comissao de uma venda oriunda de uma condicional - Linha
    [Tags]    Teste08
    [Setup]    montadorDeCenarios.Dado que realizo uma venda total de uma condicional
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

Teste 09 - Gerando comissao de uma venda parcial oriunda de uma condicional - Total Venda
    [Tags]    Teste09
    [Setup]    montadorDeCenarios.Dado que realizo uma venda parcial de uma condicional
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

Teste 10 - Gerando comissao de uma venda parcial oriunda de uma condicional totalmente recebida - Total Venda
    [Tags]    Teste10
    [Setup]    montadorDeCenarios.Dado que realizo uma venda parcial oriunda de uma condicional que esteja totalmente paga
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao
    Então visualizo os detalhes da comissao recem paga

Teste 11 - Gerando comissao por servico - Linha
    [Tags]    Teste11
    [Setup]    montadorDeCenarios.Dado que realizo uma ordem de serviço com funcionário comissionado por serviço 
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E vou para a aba de servicos
    E seleciono a comissao do servico
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

Teste 12 - Gerando comissao por servico totalmente recebido - Linha
    [Tags]    Teste12
    [Setup]    montadorDeCenarios.Dado que realizo uma ordem de serviço com funcionário comissionado por serviço - Totalmente recebida
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono somente as recebidas
    E vou para a aba de servicos
    E seleciono a comissao do servico
    E baixo a comissao recém recebida
    KeyComissoes1.Quando acesso o caixa aberto
    KeyComissoes1.E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

    