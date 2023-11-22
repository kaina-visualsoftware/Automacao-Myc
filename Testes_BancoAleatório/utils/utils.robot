*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process

Resource    ./validacaoAviso.robot
*** Variables ***
${TELA_RECB_DUPLICATAS}                  tela_RecebimentoDuplicatas.png
${MODAL_LOCAL_NEGOCIACAO}                tela_LocalNegociacao.png
${BT_CONFIRMA_CANAL_NEGOCIACAO}          bt_ConfirmarCanal.png
${TELA_IMPRESSAO}                        tela_Impressao.png
${TELA_SOLICITACAO_SENHA_USUARIO}        tela_SolicitaSenha.png
${INPUT_COD_CLIENTE}                     lb_CodCliente.png
${INPUT_COD_CLIENTE_VENDA}               lb_CodClienteVenda.png
#Sleep's    
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
#Imagens Produtos
${TELA_OBSERVACAO_PRODUTO}               tela_ObservacaoProduto.png 
${TELA_SELECIONA_TIPO_ENTREGA}           tela_SelecionaEntrega.png
${ROW_PROD_INCLUSO}                      row_ProdIncluso.png    
${AVISO_SEM_ESTOQUE}                     aviso_QuantidadeSemEstoque.png

*** Keywords ***
Finalização com recebimento de duplicatas(${VALOR_FINAL_VENDA})
    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    ${VALOR_FINAL_VENDA}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C

Adicionar Vendedor e Cliente(${TELA})
    
    Sleep    ${SLEEP_BAIXO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codVendedor[0][0]}
    Sleep    ${SLEEP_BAIXO}
    
    #Não me pergunte por que, mas só na tela de orçamento que o input é igual mas o robot ve diferente
    IF    '${TELA}' == 'Orcamento'
        SikuliLibrary.Click    ${INPUT_COD_CLIENTE}
        Input Text    ${EMPTY}    ${codCliente[0][0]}
    ELSE
        SikuliLibrary.Click    ${INPUT_COD_CLIENTE_VENDA}
        Input Text    ${EMPTY}    ${codCliente[0][0]}    
    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${Codigo_Cliente}    ${codCliente[0][0]}
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor[0][0]}

Inserir Produto normal 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}

    ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB

    IF     ${Parametro_Permite_Varias_Tabelas}

        Valida tabela de preco

    END

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    IF     ${Parametro_ExigeSenhaMultiplo}
    
        Valida solicitacao de senha do usuário
    
    END

    IF    ${Parametro_IncluiDireto} != ${True}
        
        Press Combination    KEY.ALT     Key.I
        Sleep    ${SLEEP_BAIXO}

    END

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]}   

    Verifica observacao do produto 

    IF    ${Aviso_ProdutoSemEstoque}
        
        Aviso produto sem estoque 

    END

    IF    ${Parametro_Controla_Entrega}

        Valida controle de entrega

    END

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

Valida local da negociação

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${MODAL_LOCAL_NEGOCIACAO} 

    IF    ${MSG}  
        
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    DOWN
        SikuliLibrary.Click    ${BT_CONFIRMA_CANAL_NEGOCIACAO}

    END

Valida impressao direta de venda(${Parametro_ImprimeVendaDireto}) 
    
    IF    ${Parametro_ImprimeVendaDireto}
        
        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.S

    END

Valida solicitacao de senha do usuário

    ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_SOLICITACAO_SENHA_USUARIO}     ${SLEEP_ALTO}

    IF    ${MSG}

        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Verifica observacao do produto 
    
    ${ObservaçãoProduto} =     Run Keyword And Return Status     Check If Exists In Database    SELECT ObservaVenda FROM produtos WHERE Codigo = ${COD_PRODUTO} AND ObservaVenda <> 0 AND ObservaVenda IS NOT NULL

    IF    ${ObservaçãoProduto}
        
        Sleep    ${SLEEP_ALTO}
        ${MSG}    Exists    ${TELA_OBSERVACAO_PRODUTO}

        IF    ${MSG}  
            
            Input Text    ${EMPTY}    Obs Produto Teste
            Press Combination    KEY.ALT     Key.O
            Sleep    ${SLEEP_MEDIO}

        END

    END

Valida controle de entrega 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_SELECIONA_TIPO_ENTREGA}

    IF    ${MSG}  
        
        Input Text    ${EMPTY}    S
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.G
        Sleep    ${SLEEP_MEDIO}

    END

Aviso produto sem estoque 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END