*** Settings ***
Resource     ../../../KeyWords/Descontos/Venda de Balcão/KeyDescontoVendaBalcao.robot
Resource    ../../../utils/parametros_pre_condicoes.robot

Suite Setup    Run Keywords     Start Sikuli Process    AND    Conectar ao Banco de Dados    AND    Preparar Ambiente MyCommerce
Suite Teardown      Stop Remote Server

*** Test Cases ***

Venda com produto normal
    Dado que acesso a tela de vendas de balcão
    Quando pressiono o atalho de adicionar
    E adiciono o vendedor de código(6)
    E adiciono o cliente de código(3)
    E insiro um produto normal de código(42)
    E acesso a aba pagamentos
    E insiro um desconto de [15]%
    E insiro a senha [123] do vendedor de código [3]
    # E clico no botão na tela Venda de Balcão  Desdobrar
    # E clico no botão na tela Venda de Balcão  Finalizar
    # E clico no botão na tela Impressao        Sair
    # Então a venda deve ser salva no banco, sendo a tabela com a coluna com valor    VENDAS    STATUS                 f
    # E a venda deve ser salva no banco, sendo a tabela com a coluna com valor        VENDAS    VALORFINALPAGAMENTOS  15,5
    # Então valido a baixa de estoque do produto utilizado na venda
    # E pressiono o atalho do botão Sair da tela de vendas