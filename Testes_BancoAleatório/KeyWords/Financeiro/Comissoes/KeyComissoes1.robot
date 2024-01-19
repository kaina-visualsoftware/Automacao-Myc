*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    ../libs/verificacoesExtras.py
Library    ../libs/estoque.py
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot
Resource     ../utils/montadorDeCenarios.robot

*** Variables ***
${IMAGES}                                ./Testes_BancoAleatório/images
#Conexão MySQL
${DBHost}                                10.1.1.220
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root
#Informações Extras
${NomeTerminalExecucao}                  ${config.terminal_name}  
#Sleep's
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
${TEMPO_LIMITE_CARREGAMENTO_GRID}        6
#Imagens Telas
${MENU_FINANCEIRO}                       menu_Financeiro.png
${MENU_COMERCIAL}                        menu_Comercial.png
${SUB_MENU_COMISSOES}                    subMenu_Comissoes.png
${TELA_COMISSOES}                        tela_Comissoes.png   
${LISTAGEM_GRID}                         grid_Comissoes.png 
${CHECK_BOX_SELE_TODOS}                  checkBox_Comissao.png
${Quantidade_Zeros_Incluidos}            
${BT_BAIXAR}                             bt_Baixar.png
${TELA_AGENDAMENTO}                      tela_Agendamento_Comissao.png  
${BT_OK}                                 bt_OkComisssao.png
${AVISO_BAIXA_SUCESSO}                   aviso_BaixaSucesso.png
${CAIXA_PRINCIPAL}                       tela_CaixaPrinicipal.png
${ABA_A_PAGAR}                           aba_contasAPagar.png 
${TELA_CONTAS_A_PAGAR}                   tela_ContasPagar.png 
${GRID_COMISSOES_PAGAR}                  grid_ComissoesPagar.png
${CHECKBOX_CONTASPAGAR}                  checkBox_ContasPagar.png
${TELA_RECEBIMENTO_PAGAMENTO}            caixa_FinalizacaoRecebimentoPagamento.png
${AVISO_CONFIRMAÇÃO_BAIXA}               aviso_confirmacaoBaixaContaPagar.png
${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}     tela_RecebimentoDuplicatasCaixa.png
${TELA_CAIXA_CARREGANDO}                 tela_CaixaPrinicipalCarregando.png
${INPUT_NUMERO_DOCUMENTO}                caixa_PesquisaPorNDoc.png
${Total_Comissao}                        ${0}
${Total_Comissao_Final}                  ${0}
${TELA_VALE_COMPRA}                      tela_ValeCompra.png
${AVISO_BAIXA_VALE_COMPRA}               aviso_BaixaValeCompra.png
${TELA_BAIXA_VALE_COMPRA}                tela_BaixaValeCompra.png
${AVISO_COMISSAO_ZERADA}                 aviso_ComissaoZerada.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de comissoes
    SikuliLibrary.Click    ${MENU_FINANCEIRO}
    
    FOR    ${I}    IN RANGE    4
        
        Press Special Key    DOWN
        
    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_COMISSOES}    ${TEMPO_TELA}

Quando insiro o vendedor comissionado
    
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Wait Until Screen Contain    ${LISTAGEM_GRID}     ${SLEEP_ALTO}

E seleciono a comissao da venda
    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${LISTAGEM_GRID}
    Sleep    ${SLEEP_BAIXO}

    #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda\/\/\/\/\/\/\/\/\/\/\/
    ${Cod_Venda_String}    Convert To String     ${CODIGO_OPERACAO_MOV}
    
    ${Quantidade_de_zeros_esquerda} =    Get Length    ${Cod_Venda_String}

    ${Quantidade_de_zeros_esquerda} =    Evaluate    6 - ${Quantidade_de_zeros_esquerda}
    

    FOR    ${I}    IN RANGE    ${Quantidade_de_zeros_esquerda}
        
        ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}
        
    END
    #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda^^^^^^^^^^^^^^

    Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${CODIGO_OPERACAO_MOV}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    9
        
        Press Special Key    RIGHT
        
    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE

    Calcula total da comissao

E seleciono a comissão da venda e devolução 
    
    SikuliLibrary.Click    ${CHECK_BOX_SELE_TODOS}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    2

        SikuliLibrary.Click    ${LISTAGEM_GRID}
        Sleep    ${SLEEP_BAIXO}
        
        #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda\/\/\/\/\/\/\/\/\/\/\/
        ${Cod_Venda_String}    Convert To String     ${CODIGO_OPERACAO_MOV}
        
        ${Quantidade_de_zeros_esquerda} =    Get Length    ${Cod_Venda_String}

        ${Quantidade_de_zeros_esquerda} =    Evaluate    6 - ${Quantidade_de_zeros_esquerda}
        

        FOR    ${J}    IN RANGE    ${Quantidade_de_zeros_esquerda}
            
            ${Quantidade_Zeros_Incluidos}    Set Variable    0${Quantidade_Zeros_Incluidos}
            
        END
        #Verifica a quantidade de zeros a esquerda para a pesquisa de codigo de venda^^^^^^^^^^^^^^

        Input Text    ${EMPTY}    ${Quantidade_Zeros_Incluidos} ${CODIGO_OPERACAO_MOV}
        Sleep    ${SLEEP_BAIXO}

        FOR    ${K}    IN RANGE    9
            
            Press Special Key    RIGHT
            
        END

        Sleep    ${SLEEP_BAIXO}
        Press Special Key    SPACE

        IF    ${SelecionaProdutoComLinha}
            
            Set Test Variable    ${POSIÇÃO_VALOR}    ${I}
            Calcula comissao por produto

        ELSE

            Calcula total da comissao

            ${VALOR_DEVOLUCAO} =     Evaluate    (${VALOR_FINAL_VENDA} * (-1)) 
            Set Test Variable    ${VALOR_FINAL_VENDA}    ${VALOR_DEVOLUCAO}

        END
         

        Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${COD_VENDA}

    END


E baixo a comissao recém recebida
    
    SikuliLibrary.Click    ${BT_BAIXAR}
    Wait Until Screen Contain    ${TELA_AGENDAMENTO}     ${SLEEP_ALTO}
    SikuliLibrary.Click    ${BT_OK}

    IF    ${Total_Comissao_Final} == 0 or ${Total_Comissao} == 0

        Wait Until Screen Contain    ${AVISO_COMISSAO_ZERADA}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ESC

    ELSE

        Wait Until Screen Contain    ${AVISO_BAIXA_SUCESSO}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ESC

        ${id_comissao}    Query    SELECT ID FROM comissoespagas WHERE CodigoVendedor = ${Codigo_Vendedor} ORDER BY ID DESC;

        Set Test Variable    ${NDoc_Comissao}    ${id_comissao[0][0]} 

    END
    

Quando acesso o caixa aberto 
    
    Press Special Key    F12
    Wait Until Screen Contain    ${CAIXA_PRINCIPAL}     ${TEMPO_TELA}
    
    Highlight    ${TELA_CAIXA_CARREGANDO}    1
    
    #Ignora o erro pq tem bancos em que carrega muito rápido, então ele não percebe a mudança e da erro
    Run Keyword And Ignore Error    Wait Until Screen Not Contain    ${TELA_CAIXA_CARREGANDO}    ${TEMPO_LIMITE_CARREGAMENTO_GRID}

E vou para a aba de contas a pagar

    SikuliLibrary.Click    ${ABA_A_PAGAR}
    Wait Until Screen Contain    ${TELA_CONTAS_A_PAGAR}    ${SLEEP_ALTO}

Então faço o pagamento da comissao
    
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Wait Until Screen Contain    ${GRID_COMISSOES_PAGAR}    ${SLEEP_ALTO}
    SikuliLibrary.Click    ${INPUT_NUMERO_DOCUMENTO}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${NDoc_Comissao}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    SPACE

    Press Combination    KEY.ALT     Key.g 
    Wait Until Screen Contain    ${TELA_RECEBIMENTO_PAGAMENTO}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.C 
    Wait Until Screen Contain    ${AVISO_CONFIRMAÇÃO_BAIXA}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S

    IF    ${Parametro_CaixaControladoPorUsuario}
        
        #No MyCommerce valida se o caixa que está aberto ou por usuario ou por terminal, tem marcado o recebimento ou pagamento diario, se não tiver exibe a tela de confirmação de data
        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Usuario = ( SELECT ua_usuario_mycommerce FROM usuario_acesso WHERE ua_terminal LIKE '${NomeTerminalExecucao}' ORDER BY ua_id DESC LIMIT 1 ) AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )
        
        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa 

        END

    ELSE
        
        ${Controle_Pag_Rec_Diario}    Query    SELECT Diario, DiarioRec FROM caixas WHERE Terminal LIKE '${NomeTerminalExecucao}' AND `Status` LIKE 'Aberto' AND Empresa = ( SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1 )

        IF    ${Controle_Pag_Rec_Diario[0][0]} == 0

            Valida tela de confirmação data - caixa 

        END

    END

    Wait Until Screen Contain    ${TELA_RECEBIMENTO_DUPLICATAS_CAIXA}    ${SLEEP_ALTO}

    Input Text    ${EMPTY}    ${Total_Comissao}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC

    Valida baixa comissao

Calcula total da comissao
    
    ${Calculo_Comissao} =     Evaluate    round((${VALOR_FINAL_VENDA} * (${PercentualComissao} / 100)), 3)
    
    ${Total_Comissao} =     Evaluate    ${Total_Comissao} + ${Calculo_Comissao}

    Set Test Variable    ${Total_Comissao}
    
    Log To Console    Valor Calculado|Parcial| da comissão: ${Calculo_Comissao}
    Log To Console    Valor final da comissão: ${Total_Comissao}

#Se você entender essa keyword meus parabéns. Tempo gasto nessa keyword até o momento: 3:30 horas - Ultima Atualização - 19/01/2024
#Tava dando muito B.O na questão de abater os valores e calcular correto (positivo e negativo), teve que ser criado uma lista com todos os valores de venda e devolução
Calcula comissao por produto
    
    ${Quantidade_Produtos_Calculo} =    Get Length    ${Codigos_Produtos}

    FOR    ${I}    IN RANGE    ${Quantidade_Produtos_Calculo}

        ${Comisssao_Produto}    Query    SELECT SUM(p.VendaT1 * (cl.Aliquota / 100)) FROM comissaoporlinha AS cl INNER JOIN produtos AS p ON p.CodigoComissao = cl.Codigo AND p.Codigo = ${Codigos_Produtos[${I}]}

        ${Total_Comissao} =    Evaluate    round((${Comisssao_Produto[0][0]} + ${Total_Comissao}), 4)
        
    END
    
    #Vai definir a % de comissão apenas positiva
    IF    ${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]} > 0

        ${PERCENT_COMISSAO} =     Evaluate    round(((${Total_Comissao} / ${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]}) * 100), 2)
        Set Suite Variable    ${PERCENT_COMISSAO}
        
    END

    ${Total_Comissao} =     Evaluate    round((${DADOS_VENDA_DEVOLUÇÃO[${POSIÇÃO_VALOR}][1]} * (${PERCENT_COMISSAO} / 100)), 4)

    ${Total_Comissao_Final} =    Evaluate    ${Total_Comissao_Final} + ${Total_Comissao}

    Set Test Variable    ${Total_Comissao_Final}

    Log To Console    Valor final da comissão: ${Total_Comissao}
    Log To Console    Valor final da comissão_Final: ${Total_Comissao_Final}
    Log To Console    %Comissao final: ${PERCENT_COMISSAO}

Valida baixa comissao
    
    ${ComissaoPaga}    Query    SELECT Codigo, valor FROM contasapagar WHERE NDocumento = ${NDoc_Comissao} AND Quitado = 1 AND DataQuitacao = CURDATE() AND Descricao LIKE '%Comissão%' AND nComissao = ${NDoc_Comissao}
    
    Should Be Equal    ${ComissaoPaga[0][0]}    ${Codigo_Vendedor}
    Should Be Equal    ${ComissaoPaga[0][1]}    ${Total_Comissao}

Dado que acesso o menu de vale compras
    
    SikuliLibrary.Click    ${MENU_COMERCIAL}

    FOR    ${I}    IN RANGE    9
        
        Press Special Key    DOWN
        
    END

    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_VALE_COMPRA}     ${TEMPO_TELA}

E seleciono o vale gerado pela devolução
    
    Input Text    ${EMPTY}    ${ID_VALE_COMPRA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

Quando faço a baixa do mesmo
    
    Press Combination    KEY.ALT     Key.B 
    Wait Until Screen Contain    ${AVISO_BAIXA_VALE_COMPRA}    ${SLEEP_ALTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S
    Wait Until Screen Contain    ${TELA_BAIXA_VALE_COMPRA}    ${SLEEP_ALTO}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C
    Sleep    ${SLEEP_BAIXO}

    ${VALOR_VALE} =     Evaluate    (${VALOR_FINAL_VENDA} * -1)
    Finalização com recebimento de duplicatas(${VALOR_VALE}) 

    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_VALE_COMPRA}     ${TEMPO_TELA}
    Press Special Key    ESC