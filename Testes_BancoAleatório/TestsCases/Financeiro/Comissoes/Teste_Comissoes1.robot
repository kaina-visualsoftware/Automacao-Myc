*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/Financeiro/comissoes/KeyComissoes1.robot
Resource     ../utils/montadorDeCenarios.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    KeyComissoes1.Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

Test Setup    montadorDeCenarios.Dado que realizo uma venda completa, com produto normal

*** Test Cases ***
Teste 01 - Gerando comissao sobre venda simples
    [Tags]    Teste01
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissao da venda
    E baixo a comissao recém recebida
    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    Então faço o pagamento da comissao

Teste 02 - Gerando comissão sobre venda e devolução
    [Tags]    Teste02 
    [Setup]    montadorDeCenarios.Dado que realizo uma devolução avulsa 
    Dado que acesso a tela de comissoes
    Quando insiro o vendedor comissionado
    E seleciono a comissão da venda e devolução 
    E baixo a comissao recém recebida
    Quando acesso o caixa aberto
    E vou para a aba de contas a pagar
    #Então faço o pagamento da comissao

Teste 03 - Gerando comissão sobre venda e devolução
    [Tags]    Teste03