*** Settings ***
Documentation    Testes Banco: Atacado Total - 8660 - Empresa 1

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaAtacado.py

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
${TELA_CONDICIONAIS}         tela_condicionais.png
${TELA_ADD_CONDICIONAL}      tela_condicionaisAdicionar.png
${AVISO_SEM_ESTOQUE}         aviso_QuantidadeSemEstoque.png
${TELA_INFO_CRÉDITOS}        tela_InfoCreditos.png  
${ALERTA_CLIENTE}            alertaCliente.png
${INPUT_COD_CLIENTE}         lb_CodClienteCondicional.png
${AVISO_CLIENTE_OUTRO_VE}    aviso_clienteOutroVendedorCond.png  
${ROW_PROD_INCLUSO}          row_ProdIncluso.png
${AVISO_GERAR_VENDA}         aviso_GerarVendaCond.png
${ROW_PAGAMENTO_INCLUSO}     row_PagIncluso.png
${TELA_RECB_DUPLICATAS}      tela_RecebimentoDuplicatas.png
${TELA_EMISSAO_NFC}          tela_EmissaoNFC.png  
${AVISO_NCM_INVALIDO}        aviso_NCMInvalidoNFC.png
${TELA_VENDAS_ADICIONAR}     atacado_TelaVendaBalcao_Adicionar.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de condicionais
    
    Press Special Key    F11
    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}

E adiciono uma nova condicional 

    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ADD_CONDICIONAL}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    ${Consulta}    Query    SELECT Codigo FROM condicionais ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_CONDICIONAL}    ${Consulta[0][0]}

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

Então finalizo a condicional
    
    Press Combination    KEY.ALT     Key.D 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

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

Quando insiro mais de um um produto normal(${QUANTIDADE_PRODUTOS})

    FOR    ${counter}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
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

Quando clico em Gerar Venda

    Wait Until Screen Contain    ${TELA_CONDICIONAIS}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.G 
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${AVISO_GERAR_VENDA}    ${TEMPO_TELA}
    Press Special Key    ENTER

Então finalizo a venda
 
    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.m
    Sleep    ${SLEEP_BAIXO}

    Recupera codigo venda

    Recupera valor dos produtos

    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.F
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${ValorProduto}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}

    Faturando a NFC-e

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S

    ${RESPONSE}    Valida Desconto Venda    ${COD_VENDA}

    IF    ${RESPONSE} == ${False}
        Fail    Validação de desconto não passou!
    END

#----------------------------------------------------------------------------------------------------------------------#
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

Valida alerta após inserir cliente 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${ALERTA_CLIENTE}

    IF    ${MSG} == ${True}
    
        Press Combination    KEY.ALT     Key.O
        Sleep    ${SLEEP_MEDIO}

    END

Valida quantidade de estoque inexistente

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

Valida informações de crédito 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_INFO_CRÉDITOS}

    IF    ${MSG} == ${True}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida aviso cliente outro vendedor

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_CLIENTE_OUTRO_VE}

    IF    ${MSG} == ${True}

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Recupera valor dos produtos 

    Sleep    ${SLEEP_BAIXO}
    ${Valor_Produtos}    Query    SELECT SUM(ValorTotal) FROM vendasprodutos AS vp INNER JOIN vendas AS v ON v.Codigo = vp.CodigoVenda WHERE v.CodCondicional = ${COD_CONDICIONAL} AND v.Cancelada IS NULL
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${ValorProduto}    ${Valor_Produtos[0][0]}

Recupera codigo venda

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}