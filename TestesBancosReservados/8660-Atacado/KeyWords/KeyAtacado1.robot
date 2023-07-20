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

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de vendas de balcao
    Press Special Key    F2
    Wait Until Screen Contain    ${TELA_VENDAS}     50

Quando pressiono o atalho de adicionar
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    80
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
    Sleep    ${SLEEP_MEDIO}
    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_MEDIO}
    Valida informações de crédito
    Sleep    ${SLEEP_MEDIO}
    Valida aviso de alteração de número 
    Sleep    ${SLEEP_ALTO}

Quando insiro um produto normal
    Sleep    ${SLEEP_MEDIO}
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

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    30

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Consulta valor do produto

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

    #Faturando a NFC-e

Faturando a NFC-e
    Sleep    ${SLEEP_ALTO}
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

    Wait Until Screen Not Contain    ${TELA_EMISSAO_NFC}    50

    ${Consulta}    Query    SELECT NumeroNF FROM vendas WHERE Codigo = ${COD_VENDA}
    Sleep    ${SLEEP_BAIXO}
    Should Not Be Equal    ${Consulta[0][0]}    ${null}

#-------------------------------------------VALIDAÇÕES-------------------------------------------------#
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

Consulta valor do produto 
    Sleep    ${SLEEP_BAIXO}
    ${Valor_Produto}    Query    SELECT VendaT1 FROM produtos WHERE Codigo = ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    
    Set Test Variable    ${ValorProduto}    ${Valor_Produto[0][0]}

Recupera valor dos produtos 
    Sleep    ${SLEEP_BAIXO}
    ${Valor_Produtos}    Query    SELECT SUM(valortotal) FROM vendasprodutos WHERE CodigoVenda = ${COD_VENDA}
    Sleep    ${SLEEP_BAIXO}
    
    Set Test Variable    ${ValorProduto}    ${Valor_Produtos[0][0]}
