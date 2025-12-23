*** Settings ***
Resource    ../KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ../KeyWords/Pré-Venda/Pedidos/KeyPedidos1.robot
Resource    ../KeyWords/Comercial/Devolucao/KeyDevolucaoVenda1.robot
Resource    ../KeyWords/Financeiro/Caixa/keyCaixa1.robot
Resource    ../KeyWords/Comercial/Condicional/KeyCondicional1.robot
Resource    ../KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot
Resource    ../KeyWords/Financeiro/Contas a Pagar/keyContasPagar1.robot
Resource    ../KeyWords/Emissão/Ordem de Entrega-Novo/KeyOrdemDeEntregaNovo1.robot
Resource    ../KeyWords/Comercial/Doacao/KeyDocao1.robot

Resource    ../utils/utils.robot
Library    SikuliLibrary
Library    Collections

*** Variables ***

*** Keywords ***
Dado que realizo uma venda completa, com produto normal
    
    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal informando a quantidade(1)
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.Exclui ordem de entrega(${COD_VENDA})
    utils.E saio da tela(Venda)

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_FINAL_VENDA}

Dado que realizo uma venda completa, com produto normal - A prazo
    
    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal informando a quantidade(1)
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda - A Prazo
    utils.Exclui ordem de entrega(${COD_VENDA})
    utils.E saio da tela(Venda)
    
    Set Test Variable    ${FORMA_PADRAO}    ${FORMA_PRAZO}

Dado que realizo um pedido, com produto normal
    
    KeyPedidos1.Dado que acesso a tela de pedidos
    KeyPedidos1.E clico em adicionar
    KeyPedidos1.Quando adiciono vendedor e cliente
    KeyPedidos1.E adiciono um produto
    KeyPedidos1.Quando vou para a aba de pagamentos
    KeyPedidos1.E audito o pedido
    KeyPedidos1.Então finalizo o pedido
    utils.E saio da tela(Pedido)

Dado que realizo um pedido e gero uma venda total sobre ele

    Dado que realizo um pedido, com produto normal
    KeyPedidos1.Quando clico em gerar venda
    KeyPedidos1.Então gero a venda totalmente
    utils.E saio da tela(Pedido)

Dado que realizo um pedido e gero uma venda total sobre ele totalmente recebida

    Dado que realizo um pedido e gero uma venda total sobre ele
    
    Set Suite Variable    ${FORMA_PADRAO}    ${FORMA_PADRAO_PEDIDO}

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${TOTAL_PEDIDO}

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
        
        keyCaixa1.Quando acesso o caixa aberto
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.E pesquiso pela conta recém gerada
        keyCaixa1.Então faço o recebimento da conta
        utils.E saio da tela(CaixaPrincipal)

    ELSE
        
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Dado que realizo mais de um pedido(${Quantidade_Pedidos})
    
    ${Codigos_Pedidos}     Create List
    ${Codigos_Produtos}    Create List

    FOR    ${I}    IN RANGE    ${Quantidade_Pedidos}
        
        Dado que realizo um pedido, com produto normal
        
        Append To List    ${Codigos_Pedidos}     ${Codigo_Pedido}
        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}

    END

    Set Test Variable    ${Codigos_Pedidos}
    Set Test Variable    ${Codigos_Produtos}

Dado que realizo uma devolução completa da venda com um produto normal

    KeyDevolucaoVenda1.Dado que acesso a tela de devoluções de vendas/OS
    KeyDevolucaoVenda1.Quando adiciono uma nova devolução
    KeyDevolucaoVenda1.E insiro os dados da venda no cabeçalho da devolução(Devolução)
    KeyDevolucaoVenda1.Quando seleciono um produto para a devolução
    KeyDevolucaoVenda1.E vou para a aba de pagamentos
    KeyDevolucaoVenda1.Então finalizo a devolução
    utils.E saio da tela(Devolução)

Dado que realizo uma venda e uma devolução completa, com um produto normal
    
    Dado que realizo uma venda completa, com produto normal
    Dado que realizo uma devolução completa da venda com um produto normal

Dado que realizo uma venda com mais de um produto(${QuantidadeDeProduto})

    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro mais de um produto normal(${QuantidadeDeProduto})
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.E saio da tela(Venda)
    utils.Exclui ordem de entrega(${COD_VENDA})

Dado que realizo uma devolução com mais de um produto(${QuantidadeDeProduto})

    Dado que realizo uma venda com mais de um produto(${QuantidadeDeProduto})
    
    KeyDevolucaoVenda1.Dado que acesso a tela de devoluções de vendas/OS
    KeyDevolucaoVenda1.Quando adiciono uma nova devolução
    KeyDevolucaoVenda1.E insiro os dados da venda no cabeçalho da devolução(Devolução)
    KeyDevolucaoVenda1.Quando seleciono os produtos para a devolução(${QuantidadeDeProduto})
    KeyDevolucaoVenda1.E vou para a aba de pagamentos
    KeyDevolucaoVenda1.Então finalizo a devolução
    utils.E saio da tela(Devolução)

Dado que realizo uma venda com múltiplos produtos totalmente recebida no caixa(${QuantidadeDeProduto})

    Dado que realizo uma venda com mais de um produto(${QuantidadeDeProduto})
    
    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
        
        keyCaixa1.Quando acesso o caixa aberto
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.E pesquiso pela conta recém gerada
        keyCaixa1.Então faço o recebimento da conta
        utils.E saio da tela(CaixaPrincipal)

    ELSE
        
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Realizando venda com desconto ao finalizar(${desconto})

    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal informando a quantidade(1)
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda - Desconto(${desconto})
    utils.E saio da tela(Venda)

Realizando vendas com o mesmo produto porém com descontos diferentes
    
    ${Codigo_Vendas}         Create List
    ${Valor_Final_Vendas}    Create List

    ${DESCONTOS_COMISSOES}    Pesquisa comissões por escalonamento
    
    Realizando venda com desconto ao finalizar(${DESCONTOS_COMISSOES[0][0]})
    
    Sleep    ${SLEEP_BAIXO}
    Append To List    ${Codigo_Vendas}         ${COD_VENDA}
    Append To List    ${Valor_Final_Vendas}    ${VALOR_FINAL_VENDA}

    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto já definido(${COD_PRODUTO})
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda - Desconto(${DESCONTOS_COMISSOES[1][0]})
    utils.E saio da tela(Venda)

    Sleep    ${SLEEP_BAIXO}
    Append To List    ${Codigo_Vendas}         ${COD_VENDA}
    Append To List    ${Valor_Final_Vendas}    ${VALOR_FINAL_VENDA}

    Log To Console    Codigo_Vendas: ${Codigo_Vendas}
    Log To Console    Valor_Final_Vendas: ${Valor_Final_Vendas}

    Set Test Variable    ${DESCONTOS_COMISSOES}
    Set Test Variable    ${Codigo_Vendas}
    Set Test Variable    ${Valor_Final_Vendas}

    ${somatorioVenda}    Evaluate    round(sum(${Valor_Final_Vendas}), 2)

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${somatorioVenda}

Dado que realizo uma venda total de uma condicional

    KeyCondicional1.Dado que acesso a tela de condicionais
    KeyCondicional1.E adiciono uma nova condicional
    KeyCondicional1.Quando insiro vendedor e cliente
    KeyCondicional1.Quando insiro um produto normal informando a quantidade(1)
    KeyCondicional1.Então finalizo a condicional
    KeyCondicional1.Quando clico em gerar venda
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.E saio da tela(Venda)
    KeyCondicional1.Validação de vendas após a geração do condicional

Dado que realizo uma venda parcial de uma condicional

    KeyCondicional1.Dado que acesso a tela de condicionais
    KeyCondicional1.E adiciono uma nova condicional
    KeyCondicional1.Quando insiro vendedor e cliente
    KeyCondicional1.E insiro mais de um produto normal(3)
    KeyCondicional1.Então finalizo a condicional
    KeyCondicional1.Quando cliclo em gerar venda parcial
    KeyCondicional1.E gero a venda de parte dos produtos(2)
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.E saio da tela(Venda)

Dado que realizo uma venda parcial oriunda de uma condicional que esteja totalmente paga

    Dado que realizo uma venda parcial de uma condicional

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
            
        keyCaixa1.Quando acesso o caixa aberto
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.E pesquiso pela conta recém gerada
        keyCaixa1.Então faço o recebimento da conta
        utils.E saio da tela(CaixaPrincipal)

    ELSE
            
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    # É necessário que o parametro 'Habilite está opção caso deseje selecionar os funcionários em uma lista' esteja ***DESABILITADO***

    KeyOrdemDeSevico1.Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    KeyOrdemDeSevico1.Quando insiro um serviço
    KeyOrdemDeSevico1.E insiro um produto normal informando a quantidade(1)
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    KeyOrdemDeSevico1.Então finalizo a ordem de serviço - A Prazo
    utils.E saio da tela(OrdemDeServico)

Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço - Totalmente recebida
    
    Dado que realizo uma ordem de serviço com produto e serviço incluso, considerando funcionário comissionado por serviço

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_FINAL_OS}

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
            
        keyCaixa1.Quando acesso o caixa aberto
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.E pesquiso pela conta recém gerada
        keyCaixa1.Então faço o recebimento da conta
        utils.E saio da tela(CaixaPrincipal)

    ELSE
        
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Dado que cadastro uma conta a pagar avulsa

    keyContasPagar1.Dado que acesso a tela de cadastro avulso de contas a pagar
    keyContasPagar1.E insiro um cliente qualquer
    keyContasPagar1.Quando clico em adicionar
    keyContasPagar1.E insiro as informações necessárias(100)
    keyContasPagar1.Então gravo o lançamento de conta a pagar avulsa
    utils.E saio da tela(ContasAPagar)

Dado que realizo uma venda completa, com produto normal, sem excluir a ordem de entrega

    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal informando a quantidade(1)
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.E saio da tela(Venda)

Dado que realizo mais de uma venda(${Quantidade_Vendas})
    
    ${Codigos_Vendas}         Create List
    ${Codigos_de_Produtos}    Create List

    FOR    ${I}    IN RANGE    ${Quantidade_Vendas}
        
        Dado que realizo uma venda completa, com produto normal, sem excluir a ordem de entrega
        Sleep    ${SLEEP_MEDIO}
        
        Append To List    ${Codigos_Vendas}         ${CODIGO_OPERACAO_MOV}
        Append To List    ${Codigos_Produtos_Interno}    ${COD_PRODUTO}

    END

    Set Test Variable    ${Codigos_Vendas}

    Set Test Variable    ${Codigos_Produtos_Interno}

Dado que eu realizo uma doação

    KeyDocao1.Dado que eu acesso a tela de doações
    KeyDocao1.Quando eu clico em adicionar
    KeyDocao1.E adiciono vendedor e cliente
    KeyDocao1.Quando insiro um produto normal
    KeyDocao1.E acesso a aba detalhes
    KeyDocao1.Então finalizo a doação

Dado que realizo uma venda com mais de um produto e finalizo com múltiplas parcelas personalizadas(${QuantidadeDeProduto})

    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro mais de um produto normal(${QuantidadeDeProduto})
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda personalizada com múltiplas parcelas(3)
    utils.E saio da tela(Venda)
    utils.Exclui ordem de entrega(${COD_VENDA})

Dado que realizo uma venda com mais de um produto e com múltiplas parcelas personalizadas - Totalmente recebida

    Dado que realizo uma venda com mais de um produto e finalizo com múltiplas parcelas personalizadas(3)

Dado que realizo o recebimento de uma venda com múltiplas parcelas personalizadas

    keyCaixa1.Quando acesso o caixa aberto
    keyCaixa1.E vou para a aba de contas a receber
    keyCaixa1.E pesquiso pela conta recém gerada
    keyCaixa1.Então faço o recebimento das parcelas da conta
    utils.E saio da tela(CaixaPrincipal)

Dado que realizo uma venda com mais de uma unidade de um mesmo produto(${Quantidade_Produto})

    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente
    keyVendas1.Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})
    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda
    utils.E saio da tela(Venda)
    utils.Exclui ordem de entrega(${COD_VENDA})

Dado que realizo uma venda e uma devolução parcial da venda

    Dado que realizo uma venda com mais de uma unidade de um mesmo produto(3)

    KeyDevolucaoVenda1.Dado que acesso a tela de devoluções de vendas/OS
    KeyDevolucaoVenda1.Quando adiciono uma nova devolução
    KeyDevolucaoVenda1.E insiro os dados da venda no cabeçalho da devolução(Devolução)
    KeyDevolucaoVenda1.Quando seleciono um produto para devolver parcialmente a quantidade vendida(1)
    KeyDevolucaoVenda1.E vou para a aba de pagamentos
    KeyDevolucaoVenda1.Então finalizo a devolução
    utils.E saio da tela(Devolução)

Dado que realizo uma venda e uma devolução parcial da venda totalmente recebidos no caixa

    Dado que realizo uma venda e uma devolução parcial da venda

    ${VALOR_FINAL_OPERAÇÃO}    Evaluate    round(${VALOR_FINAL_VENDA} + ${VALOR_FINAL_DEVOLUCAO}, 2)

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}
    
    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
        
        keyCaixa1.Quando acesso o caixa aberto
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.Quando insiro o código do cliente(aReceber)
        keyCaixa1.E pesquiso pela venda e pela devolução recém geradas
        keyCaixa1.Então faço o recebimento da venda e da devolução
        utils.E saio da tela(CaixaPrincipal)

    ELSE
        
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Dado que eu realizo uma venda e uma devolução completa da venda totalmente recebidos no caixa
    
    Dado que realizo uma venda e uma devolução completa, com um produto normal

    ${VALOR_FINAL_OPERAÇÃO}    Evaluate    round(${VALOR_FINAL_VENDA} + ${VALOR_FINAL_DEVOLUCAO}, 2)

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'
        
        keyCaixa1.Quando acesso o caixa aberto
        keyCaixa1.E vou para a aba de contas a receber
        keyCaixa1.Quando insiro o código do cliente(aReceber)
        keyCaixa1.E pesquiso pela venda e pela devolução recém geradas
        keyCaixa1.Então faço o recebimento da conta
        utils.E saio da tela(CaixaPrincipal)

    ELSE
        
        Log To Console    Venda foi finalizada com a forma - A vista, portanto está totalmente paga

    END

Dado que realizo uma venda com um produto normal totalmente recebida no caixa - A prazo
    
    Dado que realizo uma venda completa, com produto normal - A prazo

    keyCaixa1.Quando acesso o caixa aberto
    keyCaixa1.E vou para a aba de contas a receber
    keyCaixa1.E pesquiso pela conta recém gerada
    keyCaixa1.Então faço o recebimento da conta
    utils.E saio da tela(CaixaPrincipal)

Dado que realizo uma ordem de serviço somente com serviço - A prazo

    KeyOrdemDeSevico1.Dado que acesso a tela de ordens de serviços
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar
    KeyOrdemDeSevico1.E adiciono vendedor e cliente
    KeyOrdemDeSevico1.Quando insiro um serviço
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    KeyOrdemDeSevico1.Então finalizo a ordem de serviço - A Prazo
    utils.E saio da tela(OrdemDeServico)

Dado que realizo uma ordem de serviço somente com serviço totalmente recebida no caixa - A prazo

    Dado que realizo uma ordem de serviço somente com serviço - A prazo

    keyCaixa1.Quando acesso o caixa aberto
    keyCaixa1.E vou para a aba de contas a receber
    keyCaixa1.E pesquiso pela conta recém gerada
    keyCaixa1.Então faço o recebimento da conta
    utils.E saio da tela(CaixaPrincipal)

Dado que realizo uma ordem de serviço somente com serviço, com vendedor e técnico executor distintos - A prazo

    Set Test Variable    ${OS_Vendedor_E_Tecnico_Diferentes}    ${True}

    Dado que realizo uma ordem de serviço somente com serviço - A prazo

Dado que realizo uma venda com múltiplos produtos com desconto - A prazo
    [Arguments]    ${Quantidades}    ${Descontos}

    ${Codigos_Produtos_Interno}    Create List
    ${List_Quantidades_Produto}    Create List

    keyVendas1.Dado que acesso a tela de vendas de balcão
    keyVendas1.Quando pressiono o atalho de adicionar
    keyVendas1.E adiciono vendedor e cliente

    ${QuantidadeDeProduto}    Get Length    ${Quantidades}

    FOR    ${i}    IN RANGE    ${QuantidadeDeProduto}

        ${Quantidade_Produto}    Get From List    ${Quantidades}    ${i}
        ${Desconto_Produto}      Get From List    ${Descontos}      ${i}

        Quando insiro um produto normal informando a quantidade e desconto    ${Quantidade_Produto}    ${Desconto_Produto}

        # Essa validação é necessária porque, ao chamar a keyword "Quando insiro um produto normal informando a quantidade e desconto", a variável "${Codigos_Produtos}" inicia com valor ${None}.
        IF    ${Codigos_Produtos} is None

            ${Codigos_Produtos}    Create List
            Set Test Variable    ${Codigos_Produtos}

        END
        
        Append To List    ${Codigos_Produtos}    ${COD_PRODUTO}

    END

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QuantidadeDeProduto}

    Set Test Variable    ${Codigos_Produtos}

    keyVendas1.E acesso a aba pagamentos
    keyVendas1.Então finalizo a venda - A Prazo
    utils.E saio da tela(Venda)

Dado que realizo uma venda com múltiplos produtos com desconto totalmente recebida no caixa
    [Arguments]    ${Quantidades}    ${Descontos}

    Dado que realizo uma venda com múltiplos produtos com desconto - A prazo    ${Quantidades}    ${Descontos}

    keyCaixa1.Quando acesso o caixa aberto
    keyCaixa1.E vou para a aba de contas a receber
    keyCaixa1.E pesquiso pela conta recém gerada
    keyCaixa1.Então faço o recebimento da conta
    utils.E saio da tela(CaixaPrincipal)