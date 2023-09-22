*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1
...    Parametros Relevantes do Atacado: Incluir Direto | Desmembra igualmente o desconto final, respeitando o desconto máximo dos itens | Não gera venda caixa fechado | Gera NFC-e automatico
...    

Resource    ../KeyWords/KeyAtacado5.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Adicionando Acerto de Estoque
    [Tags]    Teste01 
    Dado que acesso a tela de acerto de estoque
    Quando adiciono um novo acerto
    Quando insiro um produto normal para ser devolvido
    E insiro uma quantidade para o acerto(10)
    Então adiciono o acerto

Teste 02 - Adicionando acerto de estoque sem finalizar 
    [Tags]    Teste02
    Dado que acesso a tela de acerto de estoque
    Quando adiciono um novo acerto
    Quando insiro um produto normal para ser devolvido
    E insiro uma quantidade para o acerto(10)
    Então saio da tela sem realizar o acerto

Teste 03 - Adicionando acerto de estoque e excluindo 
    [Tags]    Teste03
    Dado que acesso a tela de acerto de estoque
    Quando adiciono um novo acerto
    Quando insiro um produto normal para ser devolvido
    E insiro uma quantidade para o acerto(10)
    Então adiciono o acerto
    Então excluo o acerto 