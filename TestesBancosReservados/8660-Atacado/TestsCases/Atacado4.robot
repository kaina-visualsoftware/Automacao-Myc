*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1
...    Parametros Relevantes do Atacado: Incluir Direto | Desmembra igualmente o desconto final, respeitando o desconto máximo dos itens | Não gera venda caixa fechado | Gera NFC-e automatico
...    

Resource    ../KeyWords/KeyAtacado4.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Gerando devolução de item normal
    [Tags]    Teste01
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente
    Quando insiro um produto normal para ser devolvido
    E vou para a aba de pagamentos
    Então finalizo a devolução

Teste 02 - Gerando devolução de item normal
    [Tags]    Teste02
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente