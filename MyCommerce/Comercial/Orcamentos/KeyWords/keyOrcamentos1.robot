*** Settings ***
Documentation    Testes básicos em orçamentos, inlcuindo produtos, excluindo, editando. Finalizando venda incluindo e desdobrando os pagamentos.

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
${TELA_ORCAMENTO}            tela_Orcamentos.png
${TELA_ORC_ADICIONAR}        tela_Orcamentos_Adicionar.png
${TELA_ORC_SEM_OBJETO}       tela_Orcamentos_Sem_Objeto.png
${TELA_SELECAO_GRADE}        tela_SelecaoGrade.png
${TELA_EXCLUIR_PRODUTO}      tela_Orcamentos_ExcluirProduto.png
${AVISO_DESEJA_EXCLUIR}      aviso_DesejaExcluir.png
${TELA_EXCLUSAO_ORC}         tela_ExclusaoOrc.png
#Botões
${BT_ABRIR_OBJETO}           bt_Abrir_Objeto.png
${BT_DOWN_OBJETO}            bt_DowbObjeto_Orc.png
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
#Diversos
${TX_DETAL_SERVIÇO}          ALTERNADOR   

#teste

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de orçamentos
    Type With Modifiers    O    CTRL
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando pressiono o atalho de adicionar
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    ${Consulta}    Query    SELECT Codigo FROM orcamentos ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_ORCAMENTO}    ${Consulta[0][0]}
    Log To Console    ${COD_ORCAMENTO}

Quando pressiono o atalho para editar
    Press Combination    KEY.ALT     Key.E 
    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    ${Consulta}    Query    SELECT Codigo FROM orcamentos ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_ORCAMENTO}    ${Consulta[0][0]}

    Verificar se objeto está visivel

Quando pressiono o atalho de excluir
    Press Combination    KEY.ALT     Key.X 
    Wait Until Screen Contain    ${AVISO_DESEJA_EXCLUIR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_EXCLUSAO_ORC}    ${TEMPO_TELA}

E insiro Vendedor e Cliente
    Input Text    ${EMPTY}    ${COD_VENDEDOR}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_CLIENTE}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Verificar se objeto está visivel

    ${Consulta}    Query    SELECT Codigo FROM orcamentos ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_ORCAMENTO}    ${Consulta[0][0]}

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

    ${verificacao}    Verifica Produto Incluiu Correto    Orcamentos     ${COD_PRODUTO}     ${COD_ORCAMENTO}

    Should Be Equal    ${verificacao}    ${True}

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

        ${verificacao}    Verifica Produto Incluiu Correto    Orcamentos     ${COD_PRODUTO}    ${COD_ORCAMENTO}

        Should Be Equal    ${verificacao}    ${True}
        
    END

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

    ${verificacao}    Verifica Produto Incluiu Correto    Orcamentos     ${COD_PRODUTO_GRADE}    ${COD_ORCAMENTO}

    Should Be Equal    ${verificacao}    ${True}

Quando insiro um produto do tipo lote
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_PRODUTO_LOTE}
    Press Special Key    TAB 
    Input Text    ${EMPTY}    1

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I 
    Sleep    ${SLEEP_BAIXO}

    ${verificacao}    Verifica Produto Incluiu Correto    Orcamentos     ${COD_PRODUTO_LOTE}     ${COD_ORCAMENTO}

    Should Be Equal    ${verificacao}    ${True}

Quando insiro todos os tipos de produtos
    
    FOR    ${I}    IN RANGE    3
        
        IF    ${I} == 0
            Quando insiro um produto(${COD_PRODUTO_NORMAL})
        END
        IF    ${I} == 1
            Quando insiro um produto(${COD_PRODUTO_KIT})
        END
        IF    ${I} == 2
            Quando insiro um produto(${COD_PRODUTO_SERIAL})
        END

    END

    Quando insiro um produto do tipo grade
    Quando insiro um produto do tipo lote


E removo o último produto inserido
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.R
    Wait Until Screen Contain    ${TELA_EXCLUIR_PRODUTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S

Então finalizo o orçamento como a vista
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    Press Special Key    DOWN
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Valida valores finais do orçamento

Então gravo o orçamento - 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Valida valores finais do orçamento

Então informo o motivo da exlusão
    Input Text    ${EMPTY}    Exclusao Orcamento Automacao
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Verifica Status Exclusão

    Press Combination    KEY.ALT     Key.S  

Quando informo um objeto
    SikuliLibrary.Click    ${BT_DOWN_OBJETO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_NUMSERIAL/PLACA}
    Press Special Key    TAB

E informo um serviço
    Press Combination    KEY.ALT     KEY.S 
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${COD_SERVIÇO_GERAL}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${TX_DETAL_SERVIÇO}
    Press Combination    KEY.ALT     KEY.C 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     KEY.I
    Sleep    ${SLEEP_BAIXO}

E informo mais de um serviço
    E informo um serviço

    Input Text    ${EMPTY}    ${COD_SERVIÇO_COMPUT}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     KEY.I
    Sleep    ${SLEEP_BAIXO}

#***---Função de Ajuste de Resolução da tela de orçamentos---***#
Verificar se objeto está visivel
    ${TELA_ORC} =     Exists    ${TELA_ORC_SEM_OBJETO}
    Sleep    ${SLEEP_BAIXO}

    IF    ${TELA_ORC} == ${True}
        SikuliLibrary.Click    ${BT_ABRIR_OBJETO}
    END

#***---Função de Validação dos valores de pagamentos, na tela de orçamentos---***#
Valida valores finais do orçamento
    ${VALOR_ENTRADA}    Query    SELECT o.ValorEntrada FROM orcamentos AS o WHERE Codigo = ${COD_ORCAMENTO}
    Sleep    ${SLEEP_BAIXO}
    ${VALOR_FINALPAG}    Query    SELECT o.ValorFinalPagamentos FROM orcamentos AS o WHERE Codigo = ${COD_ORCAMENTO}
    Sleep    ${SLEEP_BAIXO}
    ${TOTAL_PEDIDO}    Query    SELECT o.TotalPedido FROM orcamentos AS o WHERE Codigo = ${COD_ORCAMENTO}
    Sleep    ${SLEEP_BAIXO}

    ${FORMA_PARCELAMENTO}    Query    SELECT o.FormaParcelamento FROM orcamentos AS o WHERE Codigo = ${COD_ORCAMENTO}

    ${forma_avista}    Convert To String    001 - À VISTA
    
    ${verifica_forma}    Should Be Equal As Strings    ${FORMA_PARCELAMENTO[0][0]}    ${forma_avista}

    IF    ${verifica_forma} == ${True}
        Should Be Equal    ${TOTAL_PEDIDO[0][0]}    ${VALOR_ENTRADA[0][0]}
        Sleep    ${SLEEP_BAIXO}
    END
    
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${TOTAL_PEDIDO[0][0]}    ${VALOR_FINALPAG[0][0]}

#***---Função de validação do status do orçamento---***#
Verifica Status Exclusão
    ${STATUS_ORC}    Query    SELECT Status FROM orcamentos ORDER BY Codigo DESC LIMIT 1;
    
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${STATUS_ORC[0][0]}    x