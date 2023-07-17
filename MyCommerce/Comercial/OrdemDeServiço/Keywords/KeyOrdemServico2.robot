*** Settings ***
Documentation    Testes Geração de venda oriunda de orçamentos

Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    C:\\Automacao\\MyCommerce-Automacao\\MyCommerce\\libs\\verificaProduto.py

*** Variables ***
${IMAGES}                    ./MyCommerce/images
#Conexão MySQL
${DBHost}                    10.1.1.220
${DBName}                    bdvinicius
${DBPass}                    vssql
${DBPort}                    3306
${DBUser}                    root
#Sleep's    
${SLEEP_BAIXO}               0.3
${SLEEP_MEDIO}               1.5
${SLEEP_ALTO}                3
${TEMPO_TELA}                20
#Imagens de Telas
${TELA_OS}                   tela_OrdemDeServico.png
${TELA_OS_ADICIONAR}         tela_OSPreenchida.png
${TELA_FUNC_COMISSAO}        tela_FuncionariosComissionados.png
${TELA_DETAL_SERVICO}        tela_DetalhamentoServico.png
${TELA_RECEB_DUPLICATAS}     tela_RecebimentoDuplicatas.png
${TELA_SELECAO_GRADE}        tela_SelecaoGrade.png
${TELA_GENRENCIAMET_LOTE}    tela_GerenciamentoLotes.png 
${TELA_SERIAL_SELECAO}       tela_controleSerialSelecao.png
${TELA_SERIAL_DIGITACAO}     tela_controleSerialDigitacao.png
${TELA_SOLICITAÇÃOSENHA}     tela_SolicitacaoSenhaUsuario.png
${TELA_LIBERA_DESCONTO}      tela_LiberacaoSeparacao.png
#Códigos vendedores, clientes, produtos e serviços
${COD_VENDEDOR}              13
${COD_CLIENTE}               18
${COD_PRODUTO_NORMAL}        3
${COD_PRODUTO_NORMAL2}       7
${COD_NUMSERIAL/PLACA}       1234
${COD_SERVIÇO_GERAL}         1
${COD_SERVIÇO_COMPUT}        3
${COD_PRODUTO_GRADE}         6
${COD_PRODUTO_LOTE}          5
${COD_PRODUTO_KIT}           9
${COD_PRODUTO_SERIAL}        43
${COD_SERVIÇO_GERAL}         1
${COD_SERVIÇO_COMPUT}        3

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a guia ordens de serviços
    Press Special Key    F3
    Wait Until Screen Contain    ${TELA_OS}     ${TEMPO_TELA}

Quando preencho código de vendedor e do cliente
    Press Combination    KEY.ALT    key.A
    Wait Until Screen Contain    ${TELA_OS_ADICIONAR}     ${TEMPO_TELA}
    Input Text    ${EMPTY}   ${COD_VENDEDOR}
    Press Special Key    ENTER 
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_CLIENTE}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_OS}    ${Consulta[0][0]}

E preencho a guia serviços(${DESCONTO})
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Input Text    ${EMPTY}     ${COD_SERVIÇO_GERAL} 
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_DETAL_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}   Detalhes do servico
    Press Combination    KEY.ALT    key.C
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB 
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}     ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.n
    Wait Until Screen Contain    ${TELA_FUNC_COMISSAO}    ${TEMPO_TELA}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.I
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     key.S
    Sleep    ${SLEEP_BAIXO}

E preencho a guia serviços - Acrescimo(${ACRESCIMO})
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Input Text    ${EMPTY}     ${COD_SERVIÇO_GERAL} 
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_DETAL_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}   Detalhes do servico
    Press Combination    KEY.ALT    key.C
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
    END

    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}     ${ACRESCIMO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.n
    Wait Until Screen Contain    ${TELA_FUNC_COMISSAO}    ${TEMPO_TELA}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.I
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     key.S
    Sleep    ${SLEEP_BAIXO}

E preencho a guia serviços - Ultrapassa o limite(${DESCONTO})
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Input Text    ${EMPTY}     ${COD_SERVIÇO_GERAL} 
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_DETAL_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}   Detalhes do servico
    Press Combination    KEY.ALT    key.C
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB 
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}     ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Wait Until Screen Contain    ${TELA_LIBERA_DESCONTO}    ${TEMPO_TELA}
    Input Text    ${EMPTY}     1
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.n
    Wait Until Screen Contain    ${TELA_FUNC_COMISSAO}    ${TEMPO_TELA}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.I
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     key.S
    Sleep    ${SLEEP_BAIXO}

Quando escolho a forma 30 dias na aba pagamentos
    Press Combination    KEY.ALT    key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEy.ALT    key.D
    Sleep    ${SLEEP_BAIXO}

Então finalizo a OS - Somente serviço
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.F
    Sleep    ${SLEEP_MEDIO}

Quando insiro um produto(${COD_PRODUTO} ${DESCONTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}

    FOR    ${I}    IN RANGE    2
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
    END

    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    Set Suite Variable    ${COD_PRODUTO}

    ${comparacao} =     Verifica Valor Desconto    OS    ${COD_PRODUTO}    ${COD_OS}
    Should Be Equal    ${comparacao}    ${True}

Quando escolho a forma à vista na aba pagamentos
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.m
    Sleep    ${SLEEP_BAIXO}
    
    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEy.ALT    key.D
    Sleep    ${SLEEP_BAIXO}

Então finalizo a OS - A vista 
    Pega valor produto e serviço

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.F
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_PRODUTO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.C
    Wait Until Screen Contain    ${TELA_OS}    ${TEMPO_TELA}

    ${validaestoque}    Movimentacao Estoque    ${COD_OS}    ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${validaestoque}    ${True}

Quando insiro um produto - Ultrapassando Desconto Máximo(${COD_PRODUTO} ${DESCONTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${TELA_LIBDES} =    Exists    ${TELA_LIBERA_DESCONTO}

    IF    ${TELA_LIBDES} == ${True}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.I 
        Sleep    ${SLEEP_BAIXO}

        Set Suite Variable    ${COD_PRODUTO}

        ${verificacao}    Verifica Valor Desconto    OS    ${COD_PRODUTO}    ${COD_OS}

    END
    
    Should Be Equal    ${verificacao}    ${True}

Quando insiro mais de um produto normal(${DESCONTO})
    
    FOR    ${I}    IN RANGE    2
        
        IF    ${I} == 0
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL}
        ELSE
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL2}
        END

        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_PRODUTO}
    
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${DESCONTO}
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.I 
        Sleep    ${SLEEP_BAIXO}

        Set Suite Variable    ${COD_PRODUTO}

        ${verificacao}    Verifica Valor Desconto    OS    ${COD_PRODUTO}    ${COD_OS}

        Should Be Equal    ${verificacao}    ${True}
        
    END

Quando insiro um produto do tipo grade(${DESCONTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO_GRADE}
    Press Special Key    TAB 
    Wait Until Screen Contain    ${TELA_SELECAO_GRADE}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Press Combination    KEY.ALT     Key.O 
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${DESCONTO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB

    ${TELA_LIBDES} =    Exists    ${TELA_LIBERA_DESCONTO}

    IF    ${TELA_LIBDES} == ${True}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

    END

    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    Set Suite Variable    ${COD_PRODUTO}    ${COD_PRODUTO_GRADE}

    ${verificacao}    Verifica Valor Desconto    OS    ${COD_PRODUTO}    ${COD_OS}

    Should Be Equal    ${verificacao}    ${True}

Quando escolho a forma personalizada na aba pagamentos
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.m
   
    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2
        Press Special Key    DOWN
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
   
    FOR    ${I}    IN RANGE    2
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DELETE
    Input Text    ${EMPTY}    2
    Press Combination    KEY.ALT    key.G
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.D 
    Sleep    ${SLEEP_BAIXO}

Então finalizo a OS - Personalizada / 30 Dias
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.F
    Sleep    ${SLEEP_BAIXO}

    Recupera valor final da OS

    Wait Until Screen Contain    ${TELA_OS}     ${TEMPO_TELA}

    ${Comparacao}    Verifica Valor Parcelas    OS    ${COD_OS}    ${VALOR_FINAL_OS}

    Should Be Equal    ${Comparacao}    ${True}

Quando insiro um produto - acrescimo(${COD_PRODUTO} ${ACRESCIMO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
    END

    Input Text    ${EMPTY}    ${ACRESCIMO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    ${TELA_LIBDES} =    Exists    ${TELA_LIBERA_DESCONTO}

    IF    ${TELA_LIBDES} == ${True}
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
    END

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    Set Suite Variable    ${COD_PRODUTO}

    ${verificacao}    Verifica Valor Acrescimo    OS    ${COD_PRODUTO}    ${COD_OS}

    Should Be Equal    ${verificacao}    ${True}

#***---Função para recuperar o valor final da OS---***#
Recupera valor final da OS 
    ${VALOR_TOTAL_OS}    Query    SELECT ROUND(SUM(TotalPedido),2) FROM vendas WHERE Codigo = ${COD_OS} AND `Status` = 'f'
    
    Set Suite Variable    ${VALOR_FINAL_OS}    ${VALOR_TOTAL_OS[0][0]}

#***---Função para recuperar valor do produto e serviço---***#
Pega valor produto e serviço
    ${VALOR_PROD}    Query    SELECT ROUND(IFNULL(soma_produto, 0) + IFNULL(soma_servico, 0), 2) AS Soma_Servico_e_Produto FROM (SELECT IFNULL(SUM(v.ValorUnitario * v.Quantidade), 0) AS soma_produto FROM vendasprodutos AS v WHERE v.CodigoVenda = ${COD_OS} AND v.Cancelada IS NULL) AS Produto INNER JOIN (SELECT IFNULL(SUM(vs.Quantidade * vs.ValorUnitario), 0) AS soma_servico FROM vendasservicos AS vs WHERE vs.CodigoVenda = ${COD_OS}) AS Servico;

    Set Suite Variable    ${VALOR_PRODUTO}    ${VALOR_PROD[0][0]}   