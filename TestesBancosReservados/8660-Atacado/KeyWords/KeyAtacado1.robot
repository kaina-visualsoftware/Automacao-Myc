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
${TELA_VENDAS}               atacado_TelaVendaBalcao.png
${TELA_VENDAS_ADICIONAR}     atacado_TelaVendaBalcao_Adicionar.png
${ALERTA_CLIENTE}            alertaCliente.png
${AVISO_CLIENTE_OUTRO_VE}    aviso_clienteOutroVendedor.png  
${TELA_INFO_CRÉDITOS}        tela_InfoCreditos.png  
${TELA_ALTERAR_NUMERO}       aviso_DesejaAlterarNumero.png
${AVISO_SEM_ESTOQUE}         aviso_QuantidadeSemEstoque.png
${ROW_PROD_INCLUSO}          row_ProdIncluso.png
${ROW_PAGAMENTO_INCLUSO}     row_PagIncluso.png
${TELA_RECB_DUPLICATAS}      tela_RecebimentoDuplicatas.png
${TELA_EMISSAO_NFC}          tela_EmissaoNFC.png  
${AVISO_CQP_HOMOLOGACAO}     aviso_CqpHomologacao.png
${AVISO_NCM_INVALIDO}        aviso_NCMInvalidoNFC.png
${AVISO_DESCONTO_EXCEDE}     aviso_DescontoExcede.png
${AVISO_VENCIMENTO_SABAD}    aviso_VencimentoSabado.png        
${AVISO_EXCLUIR_PAG}         aviso_ExcluirPag.png
${TELA_IMPRESSAO_BOLETO}     tela_impressaoBoleto.png
${TELA_EMISSAO_PROMISSO}     tela_EmissaoPromissoria.png
${TELA_PERSONAL_PAGAMENT}    tela_PersonalizacaoPagamentos.png
#CÓDIGOS
${DESCONTO}                  ${0.0}
#BOTÕES
${BT_EXCLUIR_PAG}            bt_ExcluirPag.png
${BT_NAO_IMP_BOLETO}         bt_nao.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de vendas de balcao

    Press Special Key    F2
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

Quando pressiono o atalho de adicionar

    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

E adiciono vendedor e cliente 

    Sleep    ${SLEEP_BAIXO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE Tipo LIKE 'D' OR Tipo LIKE 'V' AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codVendedor[0][0]}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${codCliente[0][0]}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Valida alerta após inserir cliente
    Sleep    ${SLEEP_BAIXO}

    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_BAIXO}

    Valida informações de crédito
    Sleep    ${SLEEP_BAIXO}
    
    Valida aviso de alteração de número 
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
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG} == ${True}
    
        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

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
        
        Sleep    ${SLEEP_MEDIO}
        ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

        IF    ${MSG} == ${True}

            Press Combination    KEY.ALT     Key.S
            Sleep    ${SLEEP_MEDIO}

        END

        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    END

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QUANTIDADE_PRODUTOS}

    Sleep    ${SLEEP_BAIXO}
    Recupera valor dos produtos 

E acesso a aba pagamentos

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_ALTO}

Então finalizo a venda

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${ValorProduto}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}

    Faturando a NFC-e

    IF    ${DESCONTO} > 0
        
        IF    ${QUANTIDADE_PRODUTOS} >= 2

            Verifica valor de desconto de todos os produtos

        ELSE

            Verifica desconto correto

        END

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

    ${Consulta}    Query    SELECT NumeroNF FROM vendas WHERE Codigo = ${COD_VENDA}
    Sleep    ${SLEEP_BAIXO}
    Should Not Be Equal    ${Consulta[0][0]}    ${null}

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

    Press Combination    KEY.ALT     Key.d
    Wait Until Screen Not Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I

    Valida quantidade de estoque inexistente

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${DESCONTO}    ${DESCONTO}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

    Recupera valor dos produtos 

Quando insiro um produto com desconto - Ultrapassando(${DESCONTO})

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    ${codProduto}    Query    SELECT codigo FROM produtos WHERE (ModalidadeControle = 'Normal' AND Cancelado IS NULL) AND (Ativo = -1 AND DescontoMaximo < ${DESCONTO}) ORDER BY RAND() LIMIT 1;
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

    Press Combination    KEY.ALT     Key.d
    Wait Until Screen Not Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I

    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${AVISO_DESCONTO_EXCEDE}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Valida quantidade de estoque inexistente

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${DESCONTO}    ${DESCONTO}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

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

Quando seleciono a forma 30 dias e desdobro
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D  
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento no sabado 

    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}

E excluo o pagamento 
    Sleep    ${SLEEP_ALTO}
    SikuliLibrary.Click    ${BT_EXCLUIR_PAG}
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${AVISO_EXCLUIR_PAG}    ${SLEEP_BAIXO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

Quando incluo um pagamento 
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}  
    Press Combination    KEY.ALT     Key.N 
    Sleep    ${SLEEP_BAIXO}
    
    Valida vencimento no sabado 

    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}

Então finalizo a venda - 30 dias
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_IMPRESSAO_BOLETO}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${BT_NAO_IMP_BOLETO}
    Sleep    ${SLEEP_BAIXO}

    Faturando a NFC-e

    Wait Until Screen Contain    ${TELA_EMISSAO_PROMISSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

Quando seleciono a forma Personalizada

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

Então finalizo a venda - Personalizada

    Press Combination    KEY.ALT     Key.D  
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento no sabado 

    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F

    Wait Until Screen Contain    ${TELA_IMPRESSAO_BOLETO}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${BT_NAO_IMP_BOLETO}
    Sleep    ${SLEEP_BAIXO}

    Faturando a NFC-e

    Wait Until Screen Contain    ${TELA_EMISSAO_PROMISSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 

    Valida parcelas e valor - forma personalizada

#-------------------------------------------VALIDAÇÕES-------------------------------------------------#
Valida quantidade de estoque inexistente

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

Valida alerta após inserir cliente 

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${ALERTA_CLIENTE}

    IF    ${MSG} == ${True}
    
        Press Combination    KEY.ALT     Key.O
        Sleep    ${SLEEP_MEDIO}

    END

Valida aviso cliente outro vendedor

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_CLIENTE_OUTRO_VE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida informações de crédito 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_INFO_CRÉDITOS}

    IF    ${MSG} == ${True}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida aviso de alteração de número 
    
    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${TELA_ALTERAR_NUMERO}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

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

Valida vencimento no sabado 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_VENCIMENTO_SABAD}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_BAIXO}

    END

Recupera valor dos produtos 

    Sleep    ${SLEEP_BAIXO}
    ${Valor_Produtos}    Query    SELECT SUM(ValorTotal) FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA} AND Cancelada IS NULL
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${ValorProduto}    ${Valor_Produtos[0][0]}

Verifica desconto correto

    Sleep    ${SLEEP_BAIXO}
    ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo FROM produtos WHERE codigo = ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    Sleep    ${SLEEP_BAIXO}
    ${DescontoAplicadoVenda}    Query    SELECT round(Desconto,2) FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA} AND (CodigoProduto = ${COD_PRODUTO} AND Cancelada IS NULL)
    Sleep    ${SLEEP_BAIXO}

    IF    ${DescontoAplicadoVenda[0][0]} > ${DescontoMáximoProduto[0][0]}

        Fail    Desconto ultrapassou o máximo do produto!    level=WARN

    END

Calcula valor final com desconto 

    ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo FROM produtos WHERE codigo = ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    IF    ${DESCONTO} > ${DescontoMáximoProduto[0][0]}
        
        ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DescontoMáximoProduto[0][0]} / 100))), 2)

    ELSE

        ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DESCONTO} / 100))), 2)

    END

    Set Test Variable    ${ValorProduto}    ${ValorTotalFinal}

Verifica valor de desconto de todos os produtos 
    
    ${PrimeiraSequencia}    Query    SELECT Sequencia FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA} ORDER BY Sequencia ASC LIMIT 1;

    ${Sequencia}     Set Variable    ${PrimeiraSequencia[0][0]}

    FOR    ${I}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
        ${Consulta_Tabela_vendaProdutos}    Query    SELECT CodigoProduto, Desconto FROM vendasprodutos WHERE Sequencia = ${Sequencia}

        ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo, IF(DataPromocao > CURDATE(), 1, 0) AS produtoEmPromocao FROM produtos WHERE codigo = ${Consulta_Tabela_vendaProdutos[0][0]}

        IF    ${DescontoMáximoProduto[0][1]} == ${1}
            
            IF    ${Consulta_Tabela_vendaProdutos[0][1]} > ${0.1}
                
                Fail    \n Produto: ${Consulta_Tabela_vendaProdutos[0][0]} é promocional e possui desconto!    level=WARN

            END

        END

        IF    ${Consulta_Tabela_vendaProdutos[0][1]} > ${DescontoMáximoProduto[0][0]}

            Fail    \n Produto: ${Consulta_Tabela_vendaProdutos[0][0]} ultrapassou o máximo do produto!    level=WARN

        END

        ${Sequencia} =     Set Variable    ${Sequencia + 1}
        
    END

Calcula valor final com desconto - Mais de um produto 

    ${valorTotalProdutos} =     Set Variable    ${0.1}
    
    ${PrimeiraSequencia}    Query    SELECT Sequencia FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA} ORDER BY Sequencia ASC LIMIT 1;

    ${Sequencia}     Set Variable    ${PrimeiraSequencia[0][0]}

    FOR    ${I}    IN RANGE    ${QUANTIDADE_PRODUTOS}

        ${Valor_Produtos}    Query    SELECT SUM(ValorTotal) FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA} AND Sequencia = ${Sequencia}
        Set Test Variable    ${ValorProduto}    ${Valor_Produtos[0][0]}

        ${CodigoProduto}    Query    SELECT CodigoProduto FROM vendasprodutos WHERE Sequencia = ${Sequencia}
        
        ${DescontoMáximoProduto}    Query    SELECT DescontoMaximo FROM produtos WHERE codigo = ${CodigoProduto[0][0]}
        Sleep    ${SLEEP_BAIXO}

        IF    ${DESCONTO} > ${DescontoMáximoProduto[0][0]}
            
            ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DescontoMáximoProduto[0][0]} / 100))), 2)

        ELSE

            ${ValorTotalFinal}    Evaluate    round((${ValorProduto} - ( ${ValorProduto} * (${DESCONTO} / 100))), 2)

        END

        ${Sequencia} =     Set Variable    ${Sequencia + 1}

        ${valorTotalProdutos}     Evaluate    (${valorTotalProdutos} + ${ValorTotalFinal})
        
    END

    Set Test Variable    ${ValorProduto}    ${valorTotalProdutos}

Valida parcelas e valor - forma personalizada
    ${Valores_Personalizados}    Query    SELECT QuantidadePag, ValorFinalPagamentos FROM vendas WHERE Codigo = ${COD_VENDA}

    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${Valores_Personalizados[0][1]}    ${ValorProduto}

    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${Valores_Personalizados[0][0]}    ${2}

    ${ValorParcelas}    Evaluate    round((${Valores_Personalizados[0][1]} / 2),2)


    ${ValorParcelasContasAreceber}    Query    SELECT Valor FROM contasareceber WHERE CodigoVenda = ${COD_VENDA} LIMIT 1;

    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${ValorParcelasContasAreceber[0][0]}    ${ValorParcelas}