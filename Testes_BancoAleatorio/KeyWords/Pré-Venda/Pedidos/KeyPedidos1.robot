*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    ../../../libs/verificacoesExtras.py
Library    ../../../libs/estoque.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot

*** Variables ***
# Repositório de Imagens
${IMAGENS}                          ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                           ${config.IpServidor}
${DBName}                           ${config.Database}
${DBPass}                           vssql
${DBPort}                           ${config.Porta}
${DBUser}                           root

# Sleep's
${SLEEP_BAIXO}                      0.7
${SLEEP_MEDIO}                      1.5
${SLEEP_ALTO}                       3
${TEMPO_TELA}                       20

# Telas
${TELA_GERACAO_VENDA}               tela_GeracaoPedido.png
${TELA_WORKFLOW}                    tela_WorkFlowPedido.png
${MODAL_FORMAS_DE_PAGAMENTO}        modal_FormasDePagamentoPedidos.png
${TELA_IMPRESSAO}                   tela_Impressao.png
${TELA_PEDIDOS}                     tela_Pedidos.png
${TELA_PEDIDOS_ADICIONAR}           tela_PedidosAdicionar.png
${TELA_PEDIDO_AUDITADO}             tela_PedidoAuditado.png
${TELA_CONFIRMAÇÃO_EXCLUSÃO}        tela_exclusaoVenda.png
${TELA_VENDAS}                      tela_VendasDeBalcao.png

# Botões
${BT_WORKFLOW}                      bt_Workflow.png
${AJUSTE_FOCO}                      bt_SetaUltimaVenda.png
${BT_ADICIONAR}                     bt_Adicionar.png

# Labels
${LABEL_SITUACAO_TODOS}             lb_SituacaoTodosPreVenda.png
${LABEL_AGUARDE_GERANDO_A_VENDA}    lb_AguardeGerandoAVenda.png

# Outros
${FORMA_RECEBIMENTO_OUTROS}         Outros...
${QTDE_BAIXA_PRODUTO}               ${1}
${Quantidade_Produto}               ${1}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de pedidos

    ${FORMA_PADRAO_PEDIDO}    Valida Forma Parcelamento    Pedido

    Press Special Key    F10

    Valida lançamento de pré-venda em aberto

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${FORMA_PADRAO_PEDIDO}

    ${EntradaIgualA_Outros}    Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO_PEDIDO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}
    
E clico em adicionar
    
    SikuliLibrary.Click    ${BT_ADICIONAR}

    Valida indicação de venda(${Parametro_IndicacaoPreVenda})

    Valida local de negociação da venda

    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${QUERY}    Query    SELECT Codigo FROM pedidosvenda ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${Codigo_Pedido}     ${QUERY[0][0]}

Quando adiciono vendedor e cliente

    utils.Adicionar Vendedor e Cliente(Pedido)

    Valida avisos após incluir cliente e vendedor - Pré-Venda

E adiciono um produto

    IF    ${Teste_Comissao_Linha}
        
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

    Press Combination    KEY.ALT    KEY.M
    Sleep    ${SLEEP_MEDIO}

    Valida cliente com vales compra disponíveis

E audito o pedido

    Press Combination    KEY.ALT    KEY.r
    Wait Until Screen Contain    ${TELA_PEDIDO_AUDITADO}    ${TEMPO_TELA}

Então finalizo o pedido

    Press Combination    KEY.ALT    KEY.F

    # Verifica se o valor mínimo da forma de pagamento é maior que o total do pedido.
    IF    ${FORMA_PADRAO_PEDIDO[2]} > ${TOTAL_PEDIDO}

        Valida tela de liberação de desconto

    END

    Valida parâmetros/impressões pós pré-venda

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Então visualizo o pedido

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.V
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.C

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Quando finalizo o pedido sem auditar

    Press Combination    KEY.ALT    KEY.F

    # Verifica se o valor mínimo da forma de pagamento é maior que o total do pedido.
    IF    ${FORMA_PADRAO_PEDIDO[2]} > ${TOTAL_PEDIDO}

        Valida tela de liberação de desconto

    END

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

    Valida parâmetros/impressões pós pré-venda

E pressiono o atalho de editar

    Press Combination    KEY.ALT    KEY.E

    Valida indicação de venda(${Parametro_IndicacaoPreVenda})

    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então excluo o pedido

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.X
    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Type    ${EMPTY}    Exclusao de Pedido - Teste Automacao

    Press Special Key    TAB
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_PEDIDOS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    ${pedido_excluido}    Run Keyword And Return Status    Check If Exists In Database    SELECT * FROM pedidosvenda WHERE Codigo = ${Codigo_Pedido} AND `Status` = 'x' AND Cancelada = 1

    Should Be True    ${pedido_excluido}    Pedido não foi excluído corretamente.

# Essa key foi criada diretamente no cenário de Pedidos, pois a ordem dos elementos é totalmente diferente das demais telas.
Valida avisos após incluir cliente e vendedor - Pré-Venda

    ${Observacao_existe}    Run Keyword And Return Status     Check If Exists In Database    SELECT OBSERVACAO FROM clientes WHERE Codigo = ${Codigo_Cliente}  AND OBSERVACAO IS NOT NULL;

    Set Test Variable    ${Observacao_existe}

    IF    ${Observacao_existe}

        Valida observaco cliente

    END

    Verifica se cliente possui condicional em aberto(${Codigo_Cliente})

    Valida aviso de alteração de vendedor na pré-venda

    # IF    ${Parametro_ConsultaSCPCVenda}

    #     Valida consulta SCPC
        
    # END

    IF    ${Parametro_ExigeSenhaOutroVendedor}

        Valida aviso exige senha para outro vendedor

    END

    IF    ${Parametro_InfoCreditoClientePreVenda}

        Valida informações de crédito

    END

Quando clico em gerar venda

    Press Combination    KEY.ALT    KEY.G

    Valida solicitação de senha do usuário supervisor

    Wait Until Screen Contain    ${TELA_GERACAO_VENDA}    ${TEMPO_TELA}

Então gero a venda totalmente
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    KEY.T

    IF    ${EntradaIgualA_Outros}

        IF     ${Parametro_BaixaAutomatico}

            Finalização com recebimento de duplicatas(${TOTAL_PEDIDO})

        END

    END

    Wait Until Screen Not Contain    ${LABEL_AGUARDE_GERANDO_A_VENDA}    ${TEMPO_TELA}
    
    Valida vencimento em fins de semana e feriados(1)

    Validação de geração de venda

    Valida parâmetros/impressões pós venda

    IF    ${Parametro_ImprimeVendaDireto}
    
        Wait Until Screen Contain    ${TELA_VENDAS}    ${TEMPO_TELA}

        # Para forçar o foco do sistema manter na tela de vendas, em cenários em que há mais de uma tela aberta.
        SikuliLibrary.Click    ${AJUSTE_FOCO}
        Sleep    ${SLEEP_BAIXO}

        # Sair da tela de Vendas
        Press Combination    KEY.ALT    KEY.S
        
    END

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    KeyPedidos1.Valida baixa de estoque

Valida baixa de estoque

    IF    ${Parametro_BaixaEstoquePreVenda}

        ${COD_OPERACAO}    Set Variable    ${Codigo_Pedido}

    ELSE

        ${COD_OPERACAO}    Set Variable    ${COD_VENDA}

    END

    Sleep    ${SLEEP_MEDIO}

    ${Baixa_De_Estoque}    Valida Movimentacao Estoque Venda    ${COD_PRODUTO}    ${COD_OPERACAO}    ${QTDE_BAIXA_PRODUTO}

    Should Be Equal    ${Baixa_De_Estoque}    ${True}

    IF    ${Baixa_De_Estoque}

        Log To Console    Baixou estoque corretamente na venda gerada a partir do pedido!

    ELSE

        Log To Console    Falha na baixa do estoque! Verifique!

    END

Validação de geração de venda

    Sleep    ${SLEEP_ALTO}

    ${Codigo_Venda_Gerada}    Query    SELECT VendaGerada FROM pedidosvenda WHERE codigo = ${Codigo_Pedido};

    IF    '${Codigo_Venda_Gerada}' == '[]' or '${Codigo_Venda_Gerada[0][0]}' == 'None'

        Sleep    ${SLEEP_MEDIO}
        ${Codigo_Venda_Gerada}    Query    SELECT VendaGerada FROM pedidosvenda WHERE codigo = ${Codigo_Pedido};

    END

    Should Not Be Equal    ${Codigo_Venda_Gerada[0][0]}    None    Venda não foi gerada para o pedido ${Codigo_Pedido}.

    ${Produtos_Pedidos}    Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM pedidosvendaprodutos WHERE codigoPedido = ${Codigo_Pedido};

    ${Produtos_Vendas}     Query    SELECT CodigoProduto, Descricao, Quantidade, ValorUnitario, ValorTotal FROM vendasprodutos WHERE CodigoVenda = ${Codigo_Venda_Gerada[0][0]}

    ${Comparacao_Produtos}    Should Be Equal    ${Produtos_Pedidos}    ${Produtos_Vendas}

    Set Test Variable    ${COD_VENDA}    ${Codigo_Venda_Gerada[0][0]}
    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

    Calcula valor final da venda

Quando seleciono um produto para a geração da venda

    IF    ${Parametro_BloqueiaGeracaoVendaParcial}

        Log To Console    Parâmetro que bloqueia venda parcial está ativado!\nA geração da venda será cancelada!

        Press Combination    KEY.ALT    KEY.F
        Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}

    ELSE

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER

    END

Então gero a venda parcialmente do produto selecionado

    IF    ${Parametro_BloqueiaGeracaoVendaParcial}

        Log To Console    Parâmetro que bloqueia venda parcial está ativado!\nA geração da venda será cancelada!

    ELSE

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.P
        Wait Until Screen Contain    ${MODAL_FORMAS_DE_PAGAMENTO}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_BAIXO}

        IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}

                Calcula total da venda com pedido parcial

                Finalização com recebimento de duplicatas(${Total_Pedido_Parcial})

            END

        END

        Sleep    ${SLEEP_BAIXO}
        
        Valida vencimento em fins de semana e feriados(1)

    END

    Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Not Contain    ${TELA_IMPRESSAO}    ${SLEEP_ALTO}

    Wait Until Screen Contain    ${TELA_VENDAS}    ${SLEEP_ALTO}

    # Para forçar o foco do sistema manter na tela de vendas, em cenários em que há mais de uma tela aberta.
    SikuliLibrary.Click    ${AJUSTE_FOCO}
    Sleep    ${SLEEP_BAIXO}

    # Sair da tela de Vendas
    Press Combination    KEY.ALT    KEY.S
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}

Calcula total da venda com pedido parcial

    ${Consulta_Total_Pedido}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${Codigo_Pedido} AND QtdeGerada >= 1;

    Set Test Variable    ${Total_Pedido_Parcial}    ${Consulta_Total_Pedido[0][0]}

Então verifico se o pedido retornou corretamente

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${situacao_todos}    Exists    ${LABEL_SITUACAO_TODOS}

    IF    '${situacao_todos}' == 'False'

        Press Combination    KEY.ALT    KEY.P

        Press Special Key    ENTER
        
        Sleep    ${SLEEP_BAIXO}

    END

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
        Press Combination    KEY.ALT    KEY.P
        Wait Until Screen Contain    ${MODAL_FORMAS_DE_PAGAMENTO}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}

    END

Então cancelo a geração da venda

    FOR    ${I}    IN RANGE    2

        Press Combination    KEY.ALT    KEY.F
        Sleep    ${SLEEP_BAIXO}

    END

    Wait Until Screen Contain    ${TELA_PEDIDOS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Calcula valor final da venda
    
    ${somaValorTotalProdutos}    Evaluate    0

    Sleep    ${SLEEP_BAIXO}

    ${consultaVendasProdutos}    Query    SELECT vp.CodigoProduto, vp.ValorUnitario, vp.ValorTotal FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_VENDA} ORDER BY vp.Sequencia;

    ${consultaQtdeProdutos}    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_VENDA};

    ${QUANTIDADE_PRODUTOS}    Set Variable    ${consultaQtdeProdutos[0][0]}

    FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}

        ${ProdutoValorUnitario}    Set Variable    ${consultaVendasProdutos[${i}][1]}

        ${ProdutoValorTotal}       Set Variable    ${consultaVendasProdutos[${i}][2]}
        
        ${calcValorTotalProduto}    Evaluate    round((${Quantidade_Produto} * ${ProdutoValorUnitario}), 2)

        Should Be Equal    ${ProdutoValorTotal}    ${calcValorTotalProduto}
        
        ${somaValorTotalProdutos}    Evaluate    round((${somaValorTotalProdutos} + ${calcValorTotalProduto}), 2)
        
    END
    
    Sleep    ${SLEEP_BAIXO}
    ${ValorTotalProdutosVenda}    Query    SELECT ROUND(SUM(ValorTotal), 2) FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA}
    
    Should Be Equal    ${ValorTotalProdutosVenda[0][0]}    ${somaValorTotalProdutos}
    
    Set Test Variable    ${VALOR_FINAL_VENDA}    ${ValorTotalProdutosVenda[0][0]}

    Set Test Variable    ${DADOS_VENDA_DEVOLUÇÃO[0][1]}    ${VALOR_FINAL_VENDA}

    ${DADOS_VENDA}    Create List    ${COD_VENDA}    ${VALOR_FINAL_VENDA}

    ${DADOS_VENDA_DEVOLUÇÃO}    Create List    ${DADOS_VENDA}

    Set Test Variable    ${Valor_Total_Produtos}    ${ValorTotalProdutosVenda[0][0]}

    Set Test Variable    ${DADOS_VENDA_DEVOLUÇÃO}

    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${VALOR_FINAL_VENDA}