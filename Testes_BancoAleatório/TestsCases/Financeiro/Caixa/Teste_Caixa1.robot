*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/Financeiro/Caixa/keyCaixa1.robot
Resource     ../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    keyCaixa1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Recebendo conta de uma venda
    [Tags]    Teste01
    [Setup]    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal - A prazo
    Quando acesso o caixa aberto
    E vou para a aba de contas a receber
    Quando insiro o código do cliente
    E pesquiso pela conta receém gerada 
    Então faço o recebimento da conta 
    
Teste 02 - Realizando estorno de conta recém recebida
    [Tags]    Teste02
    [Setup]    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal - A prazo
    Quando acesso o caixa aberto
    E vou para a aba de contas a receber
    Quando insiro o código do cliente
    E pesquiso pela conta receém gerada 
    Então faço o recebimento da conta
    Quando acesso o caixa aberto
    E vou para a aba de contas a receber
    Quando desmarco a opção somente a receber
    Quando insiro o código do cliente
    E pesquiso pela conta receém gerada 
    E dou um duplo clique na conta recém paga 
    Então estorno a conta - A receber

Teste 03 - Realizando pagamento de conta 
    [Tags]    Teste03
    [Setup]    montadorDeCenarios.Dado que cadastro uma conta a pagar avulsa 
    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    Quando insiro o código do cliente
    E pesquiso pela conta a pagar gerada 
    Então concluo o pagamento da mesma

Teste 04 - Realizando estorno de conta recém paga 
    [Tags]    Teste04
    [Setup]    montadorDeCenarios.Dado que cadastro uma conta a pagar avulsa 
    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    Quando insiro o código do cliente
    E pesquiso pela conta a pagar gerada 
    Então concluo o pagamento da mesma
    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    Quando desmarco a opção somente a pagar
    Quando insiro o código do cliente
    E pesquiso pela conta a pagar gerada  
    E dou um duplo clique na conta a pagar já paga  
    Então estorno a conta - A pagar

Teste 05 - Realizando adiantamento do tipo pagamento 
    [Tags]    Teste05
    Quando acesso o caixa aberto
    E vou para a aba de adiantamentos
    Quando insiro um novo cliente
    E insiro as informações do adiantamento(50)
    Então finalizo o lançamento(Débito)

Teste 06 - Realizando adiantamento do tipo recebimento 
    [Tags]    Teste06
    Quando acesso o caixa aberto
    E vou para a aba de adiantamentos
    Quando insiro um novo cliente
    E insiro as informações do adiantamento - Recebimento(50)
    Então finalizo o lançamento(Crédito)

Teste 07 - Realizando um recebimento rápido
    [Tags]    Teste07
    Quando acesso o caixa aberto
    E vou para a aba de rec/pag rapido 
    Quando insiro um novo cliente
    E insiro as informações necessárias - recebimento rápido(20)
    Então finalizo o lançamento(Crédito)

Teste 08 - Realizando um pagamento rápido
    [Tags]    Teste08
    Quando acesso o caixa aberto
    E vou para a aba de rec/pag rapido 
    Quando insiro um novo cliente
    E insiro as informações necessárias - pagamento rápido(20)
    Então finalizo o lançamento(Débito)