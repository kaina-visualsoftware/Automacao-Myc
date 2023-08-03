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

Teste 03 - Venda com produto com desconto - Dentro do limite
    [Tags]    Teste03
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(5)
    E acesso a aba pagamentos
    Então finalizo a venda

Teste 04 - Venda com produto com desconto - ultrapassando o limite
    [Tags]    Teste04
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto - Ultrapassando(15)
    E acesso a aba pagamentos
    Então finalizo a venda

Teste 05 - Venda com Desconto ao finalizar
    [Tags]    Teste05
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos - Aplicando desconto(10)
    Então finalizo a venda

Teste 06 - Venda com Desconto ao finalizar - Ultrapassando limite
    [Tags]    Teste06
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos - Aplicando desconto(50)
    Então finalizo a venda

Teste 07 - Venda com mais de um produto, inserindo o desconto no final
    [Tags]    Teste07
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(5)
    E acesso a aba pagamentos - Aplicando desconto(15)
    Então finalizo a venda

Teste 08 - Processo tarefa 133691
    [Tags]    Teste08
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos - Aplicando desconto(20)
    Quando seleciono a forma 30 dias e desdobro
    E excluo o pagamento
    Quando incluo um pagamento
    Então finalizo a venda - 30 dias 

Teste 09 - Venda com um produto, inserindo o desconto no final - 30 dias 
    [Tags]    Teste09
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos - Aplicando desconto(20)
    Quando seleciono a forma 30 dias e desdobro
    Então finalizo a venda - 30 dias 

Teste 10 - Venda com mais de um produto, inserindo o desconto no final - 30 dias 
    [Tags]    Teste10
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(8)
    E acesso a aba pagamentos - Aplicando desconto(20)
    Quando seleciono a forma 30 dias e desdobro
    Então finalizo a venda - 30 dias 

Teste 11 - Venda com produto com desconto - ultrapassando o limite - 30 dias 
    [Tags]    Teste11
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto - Ultrapassando(15)
    E acesso a aba pagamentos - Aplicando desconto(0)
    Quando seleciono a forma 30 dias e desdobro
    Então finalizo a venda - 30 dias 

Teste 12 - Venda com produto normal, sem desconto - Faturando NFC - 30 dias 
    [Tags]    Teste12
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos - Aplicando desconto(0)
    Quando seleciono a forma 30 dias e desdobro
    Então finalizo a venda - 30 dias

Teste 13 - Venda com produto com desconto - Dentro do limite - 30 dias 
    [Tags]    Teste13
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(5)
    E acesso a aba pagamentos - Aplicando desconto(0)
    Quando seleciono a forma 30 dias e desdobro
    Então finalizo a venda - 30 dias

Teste 14 - Venda com produto normal, sem desconto - Faturando NFC - Personalizada
    [Tags]    Teste14
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Quando seleciono a forma Personalizada
    Então finalizo a venda - Personalizada

Teste 15 - Venda com produto com desconto - Dentro do limite - Personalizada
    [Tags]    Teste15
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto(5)
    E acesso a aba pagamentos
    Quando seleciono a forma Personalizada
    Então finalizo a venda - Personalizada

Teste 16 - Venda com um produto, inserindo o desconto no final - Personalizada
    [Tags]    Teste16
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Quando seleciono a forma Personalizada
    E acesso a aba pagamentos - Aplicando desconto(15)
    Então finalizo a venda - Personalizada

Teste 17 - Venda com mais de um produto, inserindo o desconto no final - Personalizada
    [Tags]    Teste17
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro mais de um um produto normal(8)
    E acesso a aba pagamentos
    Quando seleciono a forma Personalizada
    E acesso a aba pagamentos - Aplicando desconto(15)
    Então finalizo a venda - Personalizada

Teste 18 - Venda com produto com desconto - ultrapassando o limite - Personalizada 
    [Tags]    Teste18
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto com desconto - Ultrapassando(15)
    E acesso a aba pagamentos
    Quando seleciono a forma Personalizada
    Então finalizo a venda - Personalizada

Teste 19 - Venda com Desconto ao finalizar - Ultrapassando limite - Personalizada 
    [Tags]    Teste19
    Dado que acesso a tela de vendas de balcao
    Quando pressiono o atalho de adicionar
    E adiciono vendedor e cliente
    Quando insiro um produto normal
    E acesso a aba pagamentos
    Quando seleciono a forma Personalizada
    E acesso a aba pagamentos - Aplicando desconto(50)
    Então finalizo a venda - Personalizada



Teste - Processo tarefa 137639
    [Tags]    Teste
    #Aplicar a validação da quantidade de parcelas desdobradas
    Dado que acesso a tela de vendas de balcao
