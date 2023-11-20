*** Settings ***
Documentation    Testes em Banco Aleatório

Resource     ../KeyWords/keyOrcamento1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando Orcamento com produto normal
    [Tags]    Teste01 
    Dado que acesso a tela de orçamento 
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente