*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1
...    Parametros Relevantes do Atacado: Incluir Direto | Desmembra igualmente o desconto final, respeitando o desconto máximo dos itens | Não gera venda caixa fechado | Gera NFC-e automatico
...    

Resource    ../KeyWords/KeyAtacado1.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Venda com produto normal, sem desconto - Faturando NFC 
    [Tags]    Teste01
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Então finalizo a venda

Teste 02 - Venda com mais de um produto normal, sem desconto - Faturando NFC 
    [Tags]    Teste02
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(3)
    E acesso a aba pagamentos
    Então finalizo a venda

Teste 03 - 
    [Tags]    Teste03
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    E acesso a aba pagamentos
    Então finalizo a venda
