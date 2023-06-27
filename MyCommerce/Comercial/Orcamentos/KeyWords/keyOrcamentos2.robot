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
${TELA_ORCAMENTO}            tela_Orcamentos.png
${TELA_ORC_ADICIONAR}        tela_Orcamentos_Adicionar.png
${TELA_ORC_SEM_OBJETO}       tela_Orcamentos_Sem_Objeto.png
${TELA_SELECAO_GRADE}        tela_SelecaoGrade.png
${TELA_EXCLUIR_PRODUTO}      tela_Orcamentos_ExcluirProduto.png
${AVISO_DESEJA_EXCLUIR}      aviso_DesejaExcluir.png
${TELA_EXCLUSAO_ORC}         tela_ExclusaoOrc.png
${TELA_VENDA_AGRUPADA}       tela_VendaAgrupada.png
${TELA_SERIAL_SELECAO}       tela_controleSerialSelecao.png
${TELA_SERIAL_DIGITACAO}     tela_controleSerialDigitacao.png
${TELA_GENRENCIAMET_LOTE}    tela_GerenciamentoLotes.png  
${TELA_FUNC_COMISSIONADO}    tela_FuncionariosComissionados       
${TELA_OS_PREENCHIDA}        tela_OSPreenchida.png
${TELA_RECEB_DUPLICATAS}     tela_RecebimentoDuplicatas.png
${TELA_GERAR_VENDA}          tela_GerarVendaOrc.png
${TELA_VENDA_PREENCHIDA}     tela_vendaPreenchida.png
${TELA_PERSONAL_PAGAMENT}    tela_PersonalizacaoPagamentos.png
#Botões
${BT_ABRIR_OBJETO}           bt_Abrir_Objeto.png
${BT_DOWN_OBJETO}            bt_DowbObjeto_Orc.png
${BT_SAIR}                   bt_Sair.png 
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

    Set Suite Variable    ${COD_PRODUTO}

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

    Set Suite Variable    ${COD_PRODUTO}    ${COD_PRODUTO_GRADE}

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

    Set Suite Variable    ${COD_PRODUTO}    ${COD_PRODUTO_LOTE}

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

Quando finalizo o orçamento como a vista
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    Press Special Key    DOWN
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando finalizo o orçamento como 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando finalizo o orçamento como a Personalizada
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3
        Press Special Key    TAB
    END

    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
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
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Calcula valor total orcamentos
    Sleep    ${SLEEP_BAIXO}
    Valida parcelas e valor - forma personalizada

Então gravo o orçamento - 30 Dias
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G 
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}

Então informo o motivo da exlusão
    Input Text    ${EMPTY}    Exlusao Orcamento Automacao
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.S  

Quando informo um objeto
    Verificar se objeto está visivel
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

Quando pressiono o atalho de vendas agrupada
    Press Combination    KEY.ALT     Key.V 
    Wait Until Screen Contain    ${TELA_VENDA_AGRUPADA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Calcula valor total orcamentos

E clico em gerar venda agrupada
    Set Suite Variable    ${COD_PRODUTO}    3
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.V 
    Sleep    ${SLEEP_MEDIO}

E clico em gerar venda
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G  
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_GERAR_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

    Pega valor produto

    Calcula valor total orcamentos

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

Quando seleciono o serial(${F})

    FOR    ${I}    IN RANGE    ${F}

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

    END

E informo os lotes(${F})

    FOR    ${I}    IN RANGE    ${F}

        Wait Until Screen Contain    ${TELA_GENRENCIAMET_LOTE}    ${TEMPO_TELA}
        Sleep    ${SLEEP_MEDIO}
        Press Special Key    SPACE
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.O 
        Sleep    ${SLEEP_MEDIO}
        
    END

Quando incluo os funcionarios comissionados(${F})
     
    FOR    ${I}    IN RANGE    ${F}

        Wait Until Screen Contain    ${TELA_FUNC_COMISSIONADO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_VENDEDOR}
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.I 
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.S 
        Sleep    ${SLEEP_BAIXO}

    END

Então finalizo a OS
    Wait Until Screen Contain    ${TELA_OS_PREENCHIDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${validaestoque}    Movimentacao Estoque    ${COD_VENDA}    ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${validaestoque}    ${True}

    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D  
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F  
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_FINAL_ORCS}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_BAIXO}

Então finalizo a OS - Todos Orçamentos
    Wait Until Screen Contain    ${TELA_OS_PREENCHIDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D  
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F  
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_FINAL_ORCS}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_BAIXO}


Então finalizo a OS - 30 Dias / Personalizada
    Wait Until Screen Contain    ${TELA_OS_PREENCHIDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${validaestoque}    Movimentacao Estoque    ${COD_VENDA}    ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${validaestoque}    ${True}

    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D  
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F  
    Sleep    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_MEDIO}

Então finalizo a venda
    Wait Until Screen Contain    ${TELA_VENDA_PREENCHIDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    ${validaestoque}    Movimentacao Estoque    ${COD_VENDA}    ${COD_PRODUTO}
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${validaestoque}    ${True}
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     KEY.D 
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     KEY.F 
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_RECEB_DUPLICATAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${VALOR_PRODUTO}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.C 
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${BT_SAIR}

Então finalizo a venda - 30 Dias / Personalizada
    Wait Until Screen Contain    ${TELA_VENDA_PREENCHIDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     KEY.D 
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     KEY.F 
    Sleep    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_MEDIO}
    Valida valores finais venda
    Calcula valor total orcamentos

#***---Função de Ajuste de Resolução da tela de orçamentos---***#
Verificar se objeto está visivel
    ${TELA_ORC} =     Exists    ${TELA_ORC_SEM_OBJETO}
    Sleep    ${SLEEP_BAIXO}

    IF    ${TELA_ORC} == ${True}
        SikuliLibrary.Click    ${BT_ABRIR_OBJETO}
    END

#***---Função para calcular total dos orçamentos na venda agrupada---***#
Calcula valor total orcamentos
    ${VALOR_TOTAL_ORCS}    Query    SELECT ROUND(SUM(TotalPedido),2) FROM orcamentos WHERE `Data` = CURDATE() AND `Status` = 'f'
    
    Set Suite Variable    ${VALOR_FINAL_ORCS}    ${VALOR_TOTAL_ORCS[0][0]}

#***---Função para recuperar valor do produto---***#
Pega valor produto
    ${VALOR_PROD}    Query    SELECT ROUND(SUM(quantidade*valorunitario),2) FROM orcamentosprodutos WHERE CodigoOrcamento = ${COD_ORCAMENTO} ORDER BY Sequencia DESC LIMIT 1;

    Set Suite Variable    ${VALOR_PRODUTO}    ${VALOR_PROD[0][0]}   

#***---Função para validar o valor total da venda---***#
Valida valores finais venda
    ${Valor_Final_Venda}    Query    SELECT ValorFinalPagamentos FROM vendas WHERE CodOrcamento = ${COD_ORCAMENTO}
    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${Valor_Final_Venda[0][0]}    ${VALOR_FINAL_ORCS}

#***---Função para validar o valor e parcelas da forma personalizada---***#
Valida parcelas e valor - forma personalizada
    ${Valores_Personalizados}    Query    SELECT QuantidadePag, valorParcelas, ValorFinalPagamentos FROM orcamentos WHERE Codigo = ${COD_ORCAMENTO}

    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${Valores_Personalizados[0][2]}    ${VALOR_FINAL_ORCS}

    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${Valores_Personalizados[0][0]}    ${2}

    ${ValorParcelas}    Evaluate    ${Valores_Personalizados[0][2]} / 2

    Sleep    ${SLEEP_BAIXO}
    Should Be Equal    ${Valores_Personalizados[0][1]}    ${ValorParcelas}