*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1
...    Parametros Relevantes do Atacado: Incluir Direto | Desmembra igualmente o desconto final, respeitando o desconto máximo dos itens | Não gera venda caixa fechado | Gera NFC-e automatico
...    

Resource    ../KeyWords/KeyAtacado2.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Ler imagens iniciais    AND    Connect To Database     pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown      Stop Remote Server

*** Test Cases ***
Teste 01 - Processo da tarefa 138064
    [Tags]    Teste01
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(10)
    Então finalizo o pedido
    E edito o último pedido
    Quando removo o desconto pelo botão X
    Então finalizo o pedido

Teste 02 - Processo da tarefa 138001
    [Tags]    Teste02
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    Quando pressiono CRTL + I para importar um pedido
    E importo o pedido "35448"
    Então cancelo o pedido

Teste 03 - Adicionando Pedido com produto normal 
    [Tags]    Teste03
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    Então finalizo o pedido

Teste 04 - Adicionando Pedido com produto normal - Desconto
    [Tags]    Teste04
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(10)
    Então finalizo o pedido

Teste 05 - Adicionando Pedido com produto normal - Desconto - Auditando
    [Tags]    Teste05
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(10)
    Quando audito o pedido
    Então finalizo o pedido depois de auditado

Teste 06 - Adicionando pedido com mais de um produto - Auditando
    [Tags]    Teste06
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Quando audito o pedido
    Então finalizo o pedido depois de auditado

Teste 07 - Adicionando pedido com desconto no final 
    [Tags]    Teste07
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos - Aplicando desconto(10)
    Quando audito o pedido
    Então finalizo o pedido depois de auditado

Teste 08 - Adicionando pedido com mais de um produto - desconto no final 
    [Tags]    Teste08
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    E acesso a aba pagamentos - Aplicando desconto(10)
    Quando audito o pedido
    Então finalizo o pedido depois de auditado

Teste 09 - Adicionando pedido com mais de um produto - Forma Personalizada
    [Tags]    Teste09
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Quando seleciono a forma Personalizada
    Quando audito o pedido
    Então finalizo o pedido depois de auditado

Teste 10 - Adicionando pedido com mais de um produto - Forma 30-60-90-120-180 Dias
    [Tags]    Teste10
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Quando seleciono a forma 30-60-90-120-180 Dias 
    Quando audito o pedido
    Então finalizo o pedido depois de auditado

Teste 11 - Adicionando pedido e gerando venda total com o mesmo
    [Tags]    Teste11
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Quando seleciono a forma 30-60-90-120-180 Dias 
    Quando audito o pedido
    Então finalizo o pedido depois de auditado
    Quando clico em Gerar Venda
    Então gero a venda total 

Teste 12 - Adicionando pedido e gerando venda Parcial com o mesmo
    [Tags]    Teste12
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Quando audito o pedido
    Então finalizo o pedido depois de auditado
    Quando clico em Gerar Venda
    Então gero a venda parcial(2)
    
Teste 13 - Adicionando pedido e gerando venda parcial - Com desconto
    [Tags]    Teste13
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    E acesso a aba pagamentos - Aplicando desconto(10)
    Quando audito o pedido
    Então finalizo o pedido depois de auditado
    Quando clico em Gerar Venda
    Então gero a venda parcial(2)

Teste 14 - Adicionando pedido e gerando venda parcial com todos os itens
    [Tags]    Teste14
    Dado que acesso a tela de pedidos
    E adiciono um novo pedido
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    Quando audito o pedido
    Então finalizo o pedido depois de auditado
    Quando clico em Gerar Venda
    Então gero a venda parcial(5)