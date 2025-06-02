*** Settings ***
Documentation    Testes em Banco Aleatório

Resource    ../KeyWords/Faturamento/Emissão Manual Saídas/KeyEmissaoManualSaidas1.robot

Suite Setup    Run Keywords    Start Sikuli Process    AND    KeyEmissaoManualSaidas1.Ler imagens iniciais    AND    Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Stop Remote Server

*** Test Cases ***

Teste 01 - Lançando uma nota fiscal de saída preenchimento Manual
    [Tags]    Teste01

    Dado que eu acesso a tela de lançamento de nota fiscal preenchimento manual
    E adiciono vendedor e cliente
    #Quando seleciono um produto
    Quando informo um produto normal
    E acesso a aba pagamentos
    Então finalizo a nota fiscal de saída manual