*** Settings ***
Documentation    Testes Ordem de Serviço

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
${TELA_EXCLUIR_PRODUTO}      tela_OSExcluirProduto.png
${TELA_EXCLUSAO_ORC}         tela_ExclusaoOrc.png
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
${PROD_LOTE_5}               prod_LoteCod5.png
#Botões
${BT_EXCLUIR_PAG}            bt_ExcluirPag.png

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

E preencho a guia serviços
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Input Text    ${EMPTY}     ${COD_SERVIÇO_GERAL} 
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_DETAL_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}   Detalhes do servico
    Press Combination    KEY.ALT    key.C
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

Então finalizo a OS
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.F
    Sleep    ${SLEEP_MEDIO}

    ${validaestoque}    Movimentacao Estoque    ${COD_OS}    ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${validaestoque}    ${True}

Então finalizo a OS - Somente serviço
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.F
    Sleep    ${SLEEP_MEDIO}

Quando insiro um produto do tipo grade
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
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    ${verificacao}    Verifica Produto Incluiu Correto    OS     ${COD_PRODUTO_GRADE}    ${COD_OS}

    Should Be Equal    ${verificacao}    ${True}

    Set Suite Variable    ${COD_PRODUTO}    ${COD_PRODUTO_GRADE}

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

E digito o valor do pagamento e confirmo
    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    100
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.C
    Wait Until Screen Contain    ${TELA_OS}    ${TEMPO_TELA}

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

Quando insiro um produto(${COD_PRODUTO})
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO}

    FOR    ${I}    IN RANGE    4
        Press Special Key    TAB
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    ${verificacao}    Verifica Produto Incluiu Correto    OS     ${COD_PRODUTO}     ${COD_OS}

    Should Be Equal    ${verificacao}    ${True}

    Set Suite Variable    ${COD_PRODUTO}

E digito o valor do pagamento de ambos
    Input Text    ${EMPTY}    200
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.C
    Wait Until Screen Contain    ${TELA_OS}    ${TEMPO_TELA}

Quando insiro mais de um produto normal
    
    FOR    ${I}    IN RANGE    2
        
        IF    ${I} == 0
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL}
        ELSE
            Set Test Variable    ${COD_PRODUTO}    ${COD_PRODUTO_NORMAL2}
        END

        Press Combination    KEY.ALT     Key.P
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_PRODUTO}

        FOR    ${J}    IN RANGE    4
            Press Special Key    TAB
        END
    
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.I 
        Sleep    ${SLEEP_BAIXO}

        ${verificacao}    Verifica Produto Incluiu Correto    OS     ${COD_PRODUTO}    ${COD_OS}

        Should Be Equal    ${verificacao}    ${True}
        
    END

Quando insiro um produto do tipo lote
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO_LOTE}
    Press Special Key    TAB 

    Wait Until Screen Contain    ${TELA_GENRENCIAMET_LOTE}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    SPACE
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.O 
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    TAB 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    ${verificacao}    Verifica Produto Incluiu Correto    OS     ${COD_PRODUTO_LOTE}     ${COD_OS}

    Should Be Equal    ${verificacao}    ${True}

    Set Suite Variable    ${COD_PRODUTO}    ${COD_PRODUTO_LOTE}

Quando insiro um produto do tipo serial 
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO_SERIAL}
    Press Special Key    TAB 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}
    Sleep    ${SLEEP_BAIXO}

    ${TELA_SELECAO} =    Exists    ${TELA_SERIAL_SELECAO}
    ${TELA_DIGITACAO} =    Exists    ${TELA_SERIAL_DIGITACAO} 

    IF    ${TELA_SELECAO} == ${True}
        Press Special Key    SPACE
    ELSE
        @{SELECAO} =    Create List    838    302    11    11
        Click Region    ${SELECAO}
        Wait Until Screen Contain    ${TELA_SERIAL_DIGITACAO}    10
        Press Special Key    SPACE
    END

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    Key.F 
    Sleep    ${SLEEP_BAIXO}

    Set Suite Variable    ${COD_PRODUTO}    ${COD_PRODUTO_SERIAL}

Quando insiro todos os tipos de produtos
    
    FOR    ${I}    IN RANGE    2
        
        IF    ${I} == 0
            Quando insiro um produto(${COD_PRODUTO_NORMAL})
        ELSE    
            Quando insiro um produto(${COD_PRODUTO_KIT})
        END

    END
    
    Quando insiro um produto do tipo serial 
    Quando insiro um produto do tipo grade
    Quando insiro um produto do tipo lote

Então finalizo a OS - Gravando
    SikuliLibrary.Click    ${BT_EXCLUIR_PAG}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT    key.G 
    Sleep    ${SLEEP_MEDIO}

Quando pressiono o atalho para editar
    Press Combination    KEY.ALT     Key.E 
    Wait Until Screen Contain    ${TELA_OS_ADICIONAR}     ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

E removo o último produto inserido
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${PROD_LOTE_5}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.O 
    Wait Until Screen Contain    ${TELA_SOLICITAÇÃOSENHA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_EXCLUIR_PRODUTO}    ${TEMPO_TELA}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

Então finalizo a OS - Venda Rápida
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.V
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_OS}     ${TEMPO_TELA}

Quando pressiono o atalho de excluir
    Press Combination    KEY.ALT     Key.X 
    Wait Until Screen Contain    ${TELA_SOLICITAÇÃOSENHA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_EXCLUSAO_ORC}    ${TEMPO_TELA}

Então informo o motivo da exlusão
    Input Text    ${EMPTY}    Exclusao Orcamento Automacao
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}