*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1
...    Parametros Relevantes do Atacado: Incluir Direto | Desmembra igualmente o desconto final, respeitando o desconto máximo dos itens | Não gera venda caixa fechado | Gera NFC-e automatico
...    

Resource    ../KeyWords/KeyAtacado3.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando condicional com produto normal
    [Tags]    Teste01
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então finalizo a condicional

Teste 02 - Adicionando condicional com produto com desconto
    [Tags]    Teste02
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(5)
    Então finalizo a condicional

Teste 03 - Adicionando condicional com mais de um produto normal
    [Tags]    Teste03
    Dado que acesso a tela de condicionais
    E adiciono uma nova condicional 
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Então finalizo a condicional
