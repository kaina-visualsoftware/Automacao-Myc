*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary

*** Variables ***
${IMAGES}                    ./TestesBancosReservados/images
#Conexão MySQL
${DBHost}                    10.1.1.220
${DBName}                    8660
${DBPass}                    vssql
${DBPort}                    3306
${DBUser}                    root
#Sleep's    
${SLEEP_BAIXO}               0.3
${SLEEP_MEDIO}               1.5
${SLEEP_ALTO}                3
${TEMPO_TELA}                20
#Imagens de Telas
${TELA_EMISSAO_NFC}          tela_EmissaoNFC.png  
${TELA_PEDIDOS_PREVENDA}     tela_Pedidos.png
${TELA_PEDIDOS_ADICIONAR}    tela_PedidosAdicionar.png
${AVISO_CLIENTE_OUTRO_VE}    aviso_AlterarVendedor_Pedidos.png  
${ROW_PROD_INCLUSO}          row_ProdIncluso.png
${AVISO_SEM_ESTOQUE}         aviso_QuantidadeSemEstoque.png
${TELA_INFO_CRÉDITOS}        tela_InfoCreditos.png  
${ALERTA_CLIENTE}            alertaCliente.png
${INPUT_COD_CLIENTE}         lb_CodClientePedido.png
${BT_EXCLUIR_DESCONTO}       bt_ExcluirDesconto.png
${AVISO_EXCLUIR_DESCONTO}    aviso_ExcluirDesconto.png
${TELA_IMPORTAR_PEDIDOS}     tela_importarPedidos.png
${TELA_PERSONAL_PAGAMENT}    tela_PersonalizacaoPagamentos.png
${COMBOBOX_FORMA_6X}         forma_6x.png
${TELA_SOLICITACAO_SENHA}    tela_SolicitaSenha.png
${TELA_GERACAO_PEDIDO}       tela_GeracaoPedido.png
${AVISO_VENCIMENTO_FDS}      aviso_VencimentoGeracaoVenda.png
${AVISO_NCM_INVALIDO}        aviso_NCMInvalidoNFC.png
${TELA_FORMAS_PAGAMENTO}     tela_FormasPagamento.png
${TELA_RECB_DUPLICATAS}      tela_RecebimentoDuplicatas.png
${TELA_EXCLUSAO}             tela_ExclusaoDevolucao.png
${BT_SIM}                    bt_Sim.png
${BT_NAO}                    bt_NaoExclusao.png
${AVISO_EXCLUIR_PRODUTO}     aviso_ExcluirProduto.png
#Código
${DESCONTO}                  ${0.0}
#Botões
${BT_SELECAO_FORMA}          bt_selecaoForma.png


*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de pedidos

    Press Special Key    F10
    Wait Until Screen Contain    ${TELA_PEDIDOS_PREVENDA}     ${TEMPO_TELA}

E adiciono um novo pedido

    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    ${Consulta}    Query    SELECT Codigo FROM pedidosvenda ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_PEDIDO}    ${Consulta[0][0]}

E adiciono vendedor e cliente

    Sleep    ${SLEEP_BAIXO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE Tipo LIKE 'D' OR Tipo LIKE 'V' AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codVendedor[0][0]}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${INPUT_COD_CLIENTE}
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codCliente[0][0]}
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    
    Valida alerta após inserir cliente
    Sleep    ${SLEEP_BAIXO}

    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_BAIXO}

    Valida informações de crédito
    Sleep    ${SLEEP_BAIXO}

Quando insiro um produto normal

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END
    
    Valida quantidade de estoque inexistente

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

    Recupera valor dos produtos 

Quando insiro um produto com desconto(${DESCONTO})

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    ${codProduto}    Query    SELECT codigo FROM produtos WHERE (ModalidadeControle = 'Normal' AND Cancelado IS NULL) AND (Ativo = -1 AND DescontoMaximo > ${DESCONTO}) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END
    
    Valida quantidade de estoque inexistente

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.E 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END
    
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.A 

    Valida quantidade de estoque inexistente

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${DESCONTO}    ${DESCONTO}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

    Recupera valor dos produtos 

Quando insiro mais de um um produto normal(${QUANTIDADE_PRODUTOS})

    FOR    ${counter}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}
        ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
        Sleep    ${SLEEP_MEDIO}
        Input Text    ${EMPTY}    ${codProduto[0][0]} 
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
        Valida quantidade de estoque inexistente

        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    END

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QUANTIDADE_PRODUTOS}

    Sleep    ${SLEEP_BAIXO}
    Recupera valor dos produtos 

E acesso a aba pagamentos - Aplicando desconto(${DESCONTO})

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_ALTO}
    Press Special Key    TAB
    Sleep    ${SLEEP_ALTO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB

    Set Test Variable    ${DESCONTO}    ${DESCONTO}

    IF    ${QUANTIDADE_PRODUTOS} >= 2

        Calcula valor final com desconto - Mais de um produto

    ELSE

        Calcula valor final com desconto

    END  

E edito o último pedido
    Press Combination    KEY.ALT     Key.E 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_PEDIDOS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Valida alerta após inserir cliente
    Sleep    ${SLEEP_BAIXO}

Quando removo o desconto pelo botão X
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_EXCLUIR_DESCONTO}
    Wait Until Screen Contain    ${AVISO_EXCLUIR_DESCONTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Verifica valor final ao remover desconto

Quando audito o pedido 
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r 
    Sleep    ${SLEEP_BAIXO}

Então finalizo o pedido depois de auditado
    Press Combination    KEY.ALT     Key.F 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_PEDIDOS_PREVENDA}     ${TEMPO_TELA}

Então finalizo o pedido
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_PEDIDOS_PREVENDA}     ${TEMPO_TELA}

Quando pressiono CRTL + I para importar um pedido
    
    Press Combination    KEY.CTRL     Key.I 
    Wait Until Screen Contain    ${TELA_IMPORTAR_PEDIDOS}    ${TEMPO_TELA}

E importo o pedido "${Cod_Pedido_Importar}"
    
    Input Text    ${EMPTY}    ${Cod_Pedido_Importar}
    Press Special Key    TAB
    Press Combination    KEY.ALT     KEY.I 
    Sleep    ${SLEEP_MEDIO}
    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_ALTO}
    Valida quantidade de estoque inexistente

Então cancelo o pedido
    
    Press Special Key    ESC
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

Quando seleciono a forma Personalizada
    
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    Input Text    ${EMPTY}    P
    Press Special Key    TAB
    Wait Until Screen Contain    ${TELA_PERSONAL_PAGAMENT}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    UP 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}

Quando seleciono a forma 30-60-90-120-180 Dias 

    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_SELECAO_FORMA}

    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${COMBOBOX_FORMA_6X}

Quando clico em Gerar Venda 
    
    Press Combination    KEY.ALT     Key.G
    Wait Until Screen Contain    ${TELA_SOLICITACAO_SENHA}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    1
    Press Special Key    ENTER

Então gero a venda total 

    Wait Until Screen Contain    ${TELA_GERACAO_PEDIDO}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.T 
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento no fim de semana

    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}

    Faturando a NFC-e

Então gero a venda parcial(${QTD_GERAR})
    
    Set Test Variable    ${QUANTIDADE_PRODUTOS}     ${QTD_GERAR}
    
    Wait Until Screen Contain    ${TELA_GERACAO_PEDIDO}    ${TEMPO_TELA}

    FOR    ${I}    IN RANGE    ${QTD_GERAR}
        
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        
    END

    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_FORMAS_PAGAMENTO}    ${TEMPO_TELA}

    #SOLUÇÃO TEMPORÁRIA ATÉ A TAREFA 138889 SER CORRIGIDA
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB

    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}
    
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${ValorProduto}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.S

    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}

    SikuliLibrary.Click    ${TELA_EMISSAO_NFC}

    Faturando a NFC-e

    IF    ${DESCONTO} > 0
        
        IF    ${QUANTIDADE_PRODUTOS} >= 2

            Verifica valor de desconto de todos os produtos

        ELSE

            Verifica desconto correto

        END

    END

Quando clico em excluir
    
    Wait Until Screen Contain    ${TELA_PEDIDOS_PREVENDA}     ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.x 
    Sleep    ${SLEEP_BAIXO}

E informo o motivo da exclusão

    Wait Until Screen Contain    ${TELA_EXCLUSAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    Exclusao de pedido pois o cliente desistiu do pedido

Então confirmo a exclusão
    
    SikuliLibrary.Click    ${BT_SIM}
    Sleep    ${SLEEP_MEDIO}

    Check If Exists In Database    SELECT * FROM pedidosvenda WHERE Codigo = ${COD_PEDIDO} AND `Status` LIKE 'x';

Então cancelo a exclusão
    
    SikuliLibrary.Click    ${BT_NAO}
    Sleep    ${SLEEP_MEDIO}

    Check If Not Exists In Database    SELECT * FROM pedidosvenda WHERE Codigo = ${COD_PEDIDO} AND `Status` LIKE 'x';

Quando excluo um produto
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.x 
    Wait Until Screen Contain    ${AVISO_EXCLUIR_PRODUTO}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_MEDIO}

    ${QUANTIDADE_PEDIDOS_VENDA}    Row Count    SELECT * FROM pedidosvendaprodutos WHERE CodigoPedido = ${COD_PEDIDO} AND Cancelada IS NULL
    
    Should Be Equal    ${QUANTIDADE_PEDIDOS_VENDA}    ${4}

#-----------------------------------------------------------------------------------------------------------------#
Valida aviso cliente outro vendedor

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_CLIENTE_OUTRO_VE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida quantidade de estoque inexistente

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END
Faturando a NFC-e

    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F 
    Sleep    ${SLEEP_MEDIO}

    Valida ncm invalido ao faturar nota 

    Press Special Key    LEFT
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_ALTO}

    Wait Until Screen Not Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}

    ${Consulta}    Query    SELECT NumeroNF FROM vendas WHERE NPedido = ${COD_PEDIDO}
    Sleep    ${SLEEP_BAIXO}
    Should Not Be Equal    ${Consulta[0][0]}    ${null}

Valida alerta após inserir cliente 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${ALERTA_CLIENTE}

    IF    ${MSG} == ${True}
    
        Press Combination    KEY.ALT     Key.O
        Sleep    ${SLEEP_MEDIO}

    END

Valida informações de crédito 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_INFO_CRÉDITOS}

    IF    ${MSG} == ${True}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida vencimento no fim de semana
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_VENCIMENTO_FDS}

    IF    ${MSG} == ${True}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Recupera valor dos produtos 

    Sleep    ${SLEEP_BAIXO}
    ${Valor_Produtos}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${COD_PEDIDO} AND Cancelada IS NULL
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${ValorProduto}    ${Valor_Produtos[0][0]}

Verifica valor final ao remover desconto 
    
    Sleep    ${SLEEP_BAIXO}
    ${ValorValidacao}    Query    SELECT VendaT1 FROM produtos WHERE Codigo = ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    Recupera valor dos produtos 

    Should Be Equal    ${ValorValidacao[0][0]}    ${ValorProduto}


Calcula valor final com desconto - Mais de um produto 

    ${valorTotalProdutos} =     Set Variable    ${0.01}
    
    ${PrimeiraSequencia}    Query    SELECT Sequencia FROM pedidosvendaprodutos WHERE CodigoPedido = ${COD_PEDIDO} ORDER BY Sequencia ASC LIMIT 1;

    ${Sequencia}     Set Variable    ${PrimeiraSequencia[0][0]}

    FOR    ${I}    IN RANGE    ${QUANTIDADE_PRODUTOS}

        ${Valor_Produtos}    Query    SELECT SUM(ValorTotal) FROM pedidosvendaprodutos WHERE CodigoPedido = ${COD_PEDIDO} AND Sequencia = ${Sequencia}
        Set Test Variable    ${ValorProduto}    ${Valor_Produtos[0][0]}

        ${CodigoProduto}    Query    SELECT CodigoProduto FROM vendasprodutos WHERE Sequencia = ${Sequencia}
        
        ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo FROM produtos WHERE codigo = ${CodigoProduto[0][0]}
        Sleep    ${SLEEP_BAIXO}

        ${ValidaPromo}    Query    SELECT IF(DataPromocao > CURDATE(), 1, 0) AS produtoEmPromocao FROM produtos WHERE codigo = ${CodigoProduto[0][0]}

        IF    ${ValidaPromo[0][0]} == ${1}
            
            ${ValorTotalFinal}    Evaluate    ${ValorProduto}

        ELSE

            IF    ${DESCONTO} > ${DescontoMáximoProduto[0][0]}
            
                ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DescontoMáximoProduto[0][0]} / 100))), 2)

            ELSE

                ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DESCONTO} / 100))), 2)

            END

        END

        ${Sequencia} =     Set Variable    ${Sequencia + 1}

        ${valorTotalProdutos}     Evaluate    round((${valorTotalProdutos} + ${ValorTotalFinal}),2)
        
    END

    Set Test Variable    ${ValorProduto}    ${valorTotalProdutos}

Calcula valor final com desconto 

    ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo FROM produtos WHERE codigo = ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    IF    ${DESCONTO} > ${DescontoMáximoProduto[0][0]}
        
        ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DescontoMáximoProduto[0][0]} / 100))), 2)

    ELSE

        ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DESCONTO} / 100))), 2)

    END

    Set Test Variable    ${ValorProduto}    ${ValorTotalFinal}

Valida ncm invalido ao faturar nota 
    
    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_NCM_INVALIDO}

    IF    ${MSG} == ${True}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.C
        Sleep    ${SLEEP_MEDIO}
        Log To Console    \n Script cancelou o faturamento por conter produtos com NCM inválido!\n

    END

Verifica valor de desconto de todos os produtos 
    
    ${PrimeiraSequencia}    Query    SELECT Sequencia FROM pedidosvendaprodutos WHERE CodigoPedido = ${COD_PEDIDO} ORDER BY Sequencia ASC LIMIT 1;
    ${Sequencia}     Set Variable    ${PrimeiraSequencia[0][0]}

    FOR    ${I}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
        ${Consulta_Tabela_vendaProdutos}    Query    SELECT v.CodigoProduto, v.Desconto FROM vendasprodutos v INNER JOIN pedidosvendaprodutos vp ON v.SeqItemPedProd = vp.Sequencia WHERE vp.Sequencia IN (SELECT Sequencia FROM pedidosvendaprodutos WHERE CodigoPedido = ${COD_PEDIDO} ORDER BY Sequencia DESC);

        ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo, IF(DataPromocao > CURDATE(), 1, 0) AS produtoEmPromocao FROM produtos WHERE codigo = ${Consulta_Tabela_vendaProdutos[0][0]}

        IF    ${DescontoMáximoProduto[0][1]} == ${1}
            
            IF    ${Consulta_Tabela_vendaProdutos[${I}][1]} > ${0.1}
                
                Fail    \n Produto: ${Consulta_Tabela_vendaProdutos[0][0]} é promocional e possui desconto!    level=WARN

            END

        END

        IF    ${Consulta_Tabela_vendaProdutos[${I}][1]} > ${DescontoMáximoProduto[0][0]}

            Fail    \n Produto: ${Consulta_Tabela_vendaProdutos[0][0]} ultrapassou o máximo do produto!    level=WARN

        END

        ${Sequencia} =     Set Variable    ${Sequencia + 1}
        
    END

Verifica desconto correto

    Sleep    ${SLEEP_BAIXO}
    ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo FROM produtos WHERE codigo = ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    Sleep    ${SLEEP_BAIXO}
    ${DescontoAplicadoVenda}    Query    SELECT round(Desconto,2) FROM vendasprodutos WHERE NPedido = ${COD_PEDIDO} AND (CodigoProduto = ${COD_PRODUTO} AND Cancelada IS NULL)
    Sleep    ${SLEEP_BAIXO}

    IF    ${DescontoAplicadoVenda[0][0]} > ${DescontoMáximoProduto[0][0]}

        Fail    Desconto ultrapassou o máximo do produto!    level=WARN

    END
