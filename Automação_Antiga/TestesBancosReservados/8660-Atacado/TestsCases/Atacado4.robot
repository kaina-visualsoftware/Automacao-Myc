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

Teste 02 - Gerando devolução de item normal com troca
    [Tags]    Teste02
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente
    Quando insiro produtos que o cliente já tenha comprado(1)
    Quando seleciono produtos para a troca(1)
    E vou para a aba de pagamentos
    Quando desdobro os pagamentos
    Então finalizo a devolução

Teste 03 - Gerando devolução de mais produtos
    [Tags]    Teste03
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente
    Quando insiro produtos que o cliente já tenha comprado(3)
    E vou para a aba de pagamentos
    Então finalizo a devolução

Teste 04 - Gerando devolução de mais produtos com trocas
    [Tags]    Teste04
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente
    Quando insiro produtos que o cliente já tenha comprado(3)
    Quando seleciono produtos para a troca(4)
    E vou para a aba de pagamentos
    Quando desdobro os pagamentos
    Então finalizo a devolução

Teste 05 - Editando uma devolução
    [Tags]    Teste05
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente
    Quando insiro produtos que o cliente já tenha comprado(3)
    Quando seleciono produtos para a troca(1)
    E vou para a aba de pagamentos
    Quando gravo a devolução 
    E edito a mesma
    Quando removo um produto da devolução
    E vou para a aba de pagamentos
    Quando desdobro os pagamentos
    Então finalizo a devolução

Teste 06 - Editando um produto da devolução
    [Tags]    Teste06
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente
    Quando insiro produtos que o cliente já tenha comprado(3)
    Quando seleciono produtos para a troca(1)
    E vou para a aba de pagamentos
    Quando gravo a devolução 
    E edito a mesma
    Quando edito um produto
    E vou para a aba de pagamentos
    Quando desdobro os pagamentos
    Então finalizo a devolução

Teste 07 - Excluindo uma devolução
    [Tags]    Teste07
    Dado que acesso a tela de devolução
    E adiciono uma nova devolução
    E adiciono vendedor e cliente
    Quando insiro produtos que o cliente já tenha comprado(2)
    Quando seleciono produtos para a troca(2)
    E vou para a aba de pagamentos
    Quando desdobro os pagamentos
    Então finalizo a devolução
    Quando clico em excluir
    E informo o motivo
    Então excluo a devolução