*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../../../KeyWords/Financeiro/Caixa/keyCaixa1.robot
Resource    ../../../utils/montadorDeCenarios.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown    Stop Remote Server

Test Teardown    parametros_pre_condicoes.Reiniciar MyCommerce Se Teste Falhar

*** Test Cases ***
Teste 01 - Recebendo conta de uma venda
    [Tags]    Teste01
    [Setup]    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal - A prazo

    Quando acesso o caixa aberto
    E vou para a aba de contas a receber
    Quando insiro o código do cliente(aReceber)
    E pesquiso pela conta recém gerada
    Então faço o recebimento da conta
    E saio da tela(CaixaPrincipal)
    
Teste 02 - Realizando estorno de conta recém recebida
    [Tags]    Teste02
    [Setup]    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal - A prazo

    Quando acesso o caixa aberto
    E vou para a aba de contas a receber
    Quando insiro o código do cliente(aReceber)
    E pesquiso pela conta recém gerada
    Então faço o recebimento da conta
    utils.E saio da tela(CaixaPrincipal)
    Quando acesso o caixa aberto
    E vou para a aba de contas a receber
    Quando desmarco a opção somente a receber
    Quando insiro o código do cliente(aReceber)
    E pesquiso pela conta recém gerada
    E dou um duplo clique na conta recém paga
    Então estorno a conta - A receber
    E saio da tela(CaixaPrincipal)

Teste 03 - Realizando pagamento de conta
    [Tags]    Teste03
    [Setup]    montadorDeCenarios.Dado que cadastro uma conta a pagar avulsa

    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    Quando insiro o código do cliente(aPagar)
    E pesquiso pela conta a pagar gerada
    Então concluo o pagamento da mesma
    E saio da tela(CaixaPrincipal)

Teste 04 - Realizando estorno de conta recém paga
    [Tags]    Teste04
    [Setup]    montadorDeCenarios.Dado que cadastro uma conta a pagar avulsa

    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    Quando insiro o código do cliente(aPagar)
    E pesquiso pela conta a pagar gerada
    Então concluo o pagamento da mesma
    utils.E saio da tela(CaixaPrincipal)
    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    Quando desmarco a opção somente a pagar
    E pesquiso pela conta a pagar gerada
    E dou um duplo clique na conta a pagar já paga
    Então estorno a conta - A pagar
    E saio da tela(CaixaPrincipal)

Teste 05 - Realizando adiantamento do tipo pagamento
    [Tags]    Teste05

    Quando acesso o caixa aberto
    E vou para a aba de adiantamentos
    Quando insiro um novo cliente
    E insiro as informações do adiantamento(50)
    Então concluo o pagamento
    E saio da tela(CaixaPrincipal)

Teste 06 - Realizando adiantamento do tipo recebimento
    [Tags]    Teste06

    Quando acesso o caixa aberto
    E vou para a aba de adiantamentos
    Quando insiro um novo cliente
    E insiro as informações do adiantamento - Recebimento(50)
    Então concluo o recebimento
    E saio da tela(CaixaPrincipal)

Teste 07 - Realizando um recebimento rápido
    [Tags]    Teste07

    Quando acesso o caixa aberto
    E vou para a aba de rec/pag rapido
    Quando insiro um novo cliente
    E insiro as informações necessárias - recebimento rápido(20)
    Então concluo o recebimento
    E saio da tela(CaixaPrincipal)

Teste 08 - Realizando um pagamento rápido
    [Tags]    Teste08

    Quando acesso o caixa aberto
    E vou para a aba de rec/pag rapido
    Quando insiro um novo cliente
    E insiro as informações necessárias - pagamento rápido(20)
    Então concluo o pagamento
    E saio da tela(CaixaPrincipal)