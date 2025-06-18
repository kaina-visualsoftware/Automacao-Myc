*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    ../libs/verificacoesExtras.py
Library    ../libs/estoque.py
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot

*** Variables ***
# Repositório de Imagens
${IMAGES}                                ./Testes_BancoAleatório/images

# Conexão com o Banco de Dados
${DBHost}                       ${config.IpServidor}
${DBName}                       ${config.Database}
${DBPass}                       vssql
${DBPort}                       ${config.Porta}
${DBUser}                       root

# Sleep's
${SLEEP_BAIXO}                  0.7
${SLEEP_MEDIO}                  1.5
${SLEEP_ALTO}                   3
${TEMPO_TELA}                   20
${TELA_GERACAO_VENDA}           tela_GeracaoPedido.png
${TELA_WORKFLOW}                tela_WorkFlowPedido.png
${MODAL_FORMAS_DE_PAGAMENTO}    modal_FormasDePagamentoPedidos.png
${TELA_IMPRESSAO}               tela_Impressao.png

# Telas
${TELA_PEDIDOS}                 tela_Pedidos.png
${TELA_PEDIDOS_ADICIONAR}       tela_PedidosAdicionar.png
${TELA_PEDIDO_AUDITADO}         tela_PedidoAuditado.png  
${TELA_CONFIRMAÇÃO_EXCLUSÃO}    tela_exclusaoVenda.png

# Botões
${BT_WORKFLOW}                  bt_Workflow.png

# Outros
${FORMA_RECEBIMENTO_OUTROS}     Outros...

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de pedidos

    ${FORMA_PADRAO_PEDIDO}    Valida Forma Parcelamento    Pedido
    
    Verifica parametros que interferem na venda

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${FORMA_PADRAO_PEDIDO}

    ${EntradaIgualA_Outros}    Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO_PEDIDO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}

E clico em adicionar
    
    Press Combination    KEY.ALT     Key.A
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${QUERY}    Query    SELECT Codigo FROM pedidosvenda ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${Codigo_Pedido}     ${QUERY[0][0]}

Quando adiciono vendedor e cliente
    
    utils.Adicionar Vendedor e Cliente(Pedido)

    Valida avisos após incluir cliente e vendedor - Pré-Venda 

E adiciono um produto
    
    IF    ${SelecionaProdutoComLinha}

        utils.Seleciona produto com linha cadastrada(${Parametro_RealizaPreVendaSemEstoque})

    ELSE

        IF     ${Parametro_RealizaPreVendaSemEstoque}

            utils.Inserir Produto normal - Permite sem estoque

        ELSE
            
            utils.Inserir Produto normal - Necessita de estoque

        END

    END

    utils.Valida parametros após incluir produto

    ${QUERY}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${Codigo_Pedido};

    Set Test Variable    ${TOTAL_PEDIDO}    ${QUERY[0][0]}

Quando vou para a aba de pagamentos
    
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_MEDIO}

E audito o pedido
    
    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_PEDIDO_AUDITADO}    ${TEMPO_TELA}

Então finalizo o pedido
    
    Press Combination    KEY.ALT     Key.F

    # Verifica se o valor mínimo da forma de pagamento é maior que o total do pedido.
    IF    ${FORMA_PADRAO_PEDIDO[2]} > ${TOTAL_PEDIDO}

        Valida tela de liberação de desconto
    END

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_MEDIO}

Então visualizo o pedido feito

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.V
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.C

Quando finalizo o pedido sem auditar
    
    Press Combination    KEY.ALT     Key.F
    
    # Verifica se o valor mínimo da forma de pagamento é maior que o total do pedido.
    IF    ${FORMA_PADRAO_PEDIDO[2]} > ${TOTAL_PEDIDO}

        Valida tela de liberação de desconto

    END

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_MEDIO}

E pressiono o atalho de editar
    
    Press Combination    KEY.ALT     Key.E
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então excluo o pedido
    
    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.X
    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    Exclusao de Pedido - Teste Automacao

    Press Special Key    TAB
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    
    Check If Exists In Database    SELECT * FROM pedidosvenda WHERE Codigo = ${Codigo_Pedido} AND `Status` LIKE 'x'

# Essa key foi criada diretamente no cenário de Pedidos, pois a ordem dos elementos é totalmente diferente das demais telas.
Valida avisos após incluir cliente e vendedor - Pré-Venda
    
    ${Lista_de_avisos}    Valida Pametros Config

    ${Aviso_vendedor_existe}    Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    AvisoVendedor
    ${Aviso_infoCredito_existe}    Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    Aviso_Info_Financeiro
    ${Aviso_ExigeSenhaOutroVendedor_existe}    Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    ExigeSenhaMudarVendedorVenda

    ${Observacao_existe}    Run Keyword And Return Status     Check If Exists In Database    SELECT OBSERVACAO FROM clientes WHERE Codigo = ${Codigo_Cliente}  AND OBSERVACAO IS NOT NULL;

    Set Test Variable    ${Aviso_vendedor_existe}

    Set Test Variable    ${Observacao_existe}

    IF    ${Observacao_existe}  
            
        Valida observaco cliente

    END

    Verifica se condicional existe(${Codigo_Cliente})

    IF    ${Aviso_ExigeSenhaOutroVendedor_existe}  
        
        Valida aviso exige senha para outro vendedor

    END   

    IF    ${Aviso_Vendedor_Existe_Comissao}  

        Valida aviso cliente outro vendedor

    END

    IF    ${Aviso_infoCredito_existe}  
        
        Valida informações de crédito

    END

Quando clico em gerar venda

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    
    Press Combination    KEY.ALT     Key.G 

    Valida solicitacao de senha do usuário

    Wait Until Screen Contain    ${TELA_GERACAO_VENDA}    ${TEMPO_TELA}

Então gero a venda totalmente
    
    Press Combination    KEY.ALT     Key.T 

    IF    ${EntradaIgualA_Outros}

        IF     ${Parametro_BaixaAutomatico}

            Finalização com recebimento de duplicatas(${TOTAL_PEDIDO}) 

            Sleep    ${SLEEP_MEDIO}

        END

    END

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Validação de geração de venda

    validacaoAviso.Valida data de vencimento em feriados, sábados e domingos para pagamentos a prazo
    
    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    # Sair da tela de Vendas
    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    KeyPedidos1.Valida baixa de estoque

Valida baixa de estoque

    IF    ${Parametro_BaixaEstoquePreVenda}

        ${COD_OPERACAO}    Set Variable    ${Codigo_Pedido}

    ELSE

        ${COD_OPERACAO}    	Set Variable    ${COD_VENDA}

    END

    Sleep    ${SLEEP_MEDIO}
    ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${COD_OPERACAO}

    Should Be Equal    ${Baixa_De_Estoque}    ${True}

    IF    ${Baixa_De_Estoque}
        
        Log To Console    Baixou estoque corretamente!

    ELSE

        Log To Console    Falha na baixa do estoque! Verifique!

    END

Validação de geração de venda

    Sleep    ${SLEEP_ALTO}
    
    ${Codigo_Venda_Gerada}    Query    SELECT VendaGerada FROM pedidosvenda WHERE codigo = ${Codigo_Pedido};

    ${Produtos_Pedidos}    Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM pedidosvendaprodutos WHERE codigoPedido = ${Codigo_Pedido};

    ${Produtos_Vendas}     Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM vendasprodutos WHERE CodigoVenda = ${Codigo_Venda_Gerada[0][0]}

    ${Comparacao_Produtos}    Should Be Equal    ${Produtos_Pedidos}    ${Produtos_Vendas}

    Set Test Variable    ${COD_VENDA}    ${Codigo_Venda_Gerada[0][0]}
    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

Quando seleciono um produto para a geração da venda

    IF    ${Parametro_BloqueiaGeracaoVendaParcial}

        Log To Console    Parâmetro que bloqueia venda parcial está ativado!\nA geração da venda será cancelada!

        Press Combination    KEY.ALT     Key.F
        Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}

    ELSE
        
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER

    END

Então gero a venda parcialmente do produto selecionado
    
    IF    ${Parametro_BloqueiaGeracaoVendaParcial}

        Log To Console    Parâmetro que bloqueia venda parcial está ativado!\nA geração da venda será cancelada!

    ELSE
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.P
        Wait Until Screen Contain    ${MODAL_FORMAS_DE_PAGAMENTO}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_BAIXO}

        IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}
                
                Calcula total da venda com pedido parcial

                Finalização com recebimento de duplicatas(${Total_Pedido_Parcial}) 

                Sleep    ${SLEEP_MEDIO}

            END
            
        ELSE

            validacaoAviso.Valida data de vencimento em feriados, sábados e domingos para pagamentos a prazo

        END

    END

    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Calcula total da venda com pedido parcial
    
    ${Consulta_Total_Pedido}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${Codigo_Pedido} AND QtdeGerada >= 1;

    Set Test Variable    ${Total_Pedido_Parcial}    ${Consulta_Total_Pedido[0][0]}

Então verifico se o pedido retornou corretamente
    
    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${BT_WORKFLOW}
    Wait Until Screen Contain    ${TELA_WORKFLOW}    ${SLEEP_ALTO}

    Press Special Key    ESC

    ${VendaGerada}    Query    SELECT Gerado FROM pedidosvenda WHERE Codigo = ${Codigo_Pedido}

    Should Be Equal    ${VendaGerada[0][0]}    ${0}

E clico em salvar

    IF    ${Parametro_BloqueiaGeracaoVendaParcial}

        Log To Console    Parâmetro que bloqueia venda parcial está ativado!\nA geração da venda será cancelada!

    ELSE
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.P
        Wait Until Screen Contain    ${MODAL_FORMAS_DE_PAGAMENTO}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}

    END

Então cancelo a geração da venda
    
    FOR    ${I}    IN RANGE    2
        
        Press Combination    KEY.ALT     Key.F
        Sleep    ${SLEEP_BAIXO}
        
    END

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}