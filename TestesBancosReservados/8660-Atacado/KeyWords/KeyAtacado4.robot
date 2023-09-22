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
${TELA_DEVOLUCOES}           tela_Devolucoes.png
${TELA_DEVOLUCOES_ADD}       tela_DevolucaoAdicionar.png    
${AVISO_SEM_ESTOQUE}         aviso_QuantidadeSemEstoque.png
${TELA_INFO_CRÉDITOS}        tela_InfoCreditos.png  
${ALERTA_CLIENTE}            alertaCliente.png
${AVISO_CLIENTE_OUTRO_VE}    aviso_clienteOutroVendedorCond.png 
${AVISO_COND_ABERTO}         aviso_CondicionalAberto.png
${INPUT_COD_CLIENTE}         inp_CodClienteDevolucao.png
${INPUT_COD_VENDEDOR}        inp_CodVendedorDevolucao.png
${AVISO_NAOCOMPROU_PRODT}    aviso_ClienteNaoComprouProduto.png
${INPUTBOX_OBSERVACOES}      inpBox_Observacoes.png
${TELA_IMPRESSAO_DIRETA}     tela_impressaoDireta.png
${TELA_RECB_DUPLICATAS}      tela_RecebimentoDuplicatas.png
${AVISO_EXCLUIR_PRODUTO}     aviso_ExcluirProduto.png
${TELA_EXCLUI_DEVOLUCAO}     tela_exclusaoDevolucao.png
${BT_SIM}                    bt_Sim.png
${TELA_LIBERA_DESCONTO}      tela_Liberacao.png
#Diversos
${DESCONTO}                  ${0.0}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de devolução
    
    Press Special Key    F6
    Wait Until Screen Contain    ${TELA_DEVOLUCOES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E adiciono uma nova devolução
    
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_DEVOLUCOES_ADD}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${POSSUI_OBS}    ${False}

E adiciono vendedor e cliente

    Sleep    ${SLEEP_MEDIO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE Tipo LIKE 'D' OR Tipo LIKE 'V' AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0 AND (SELECT COUNT(Codigo) FROM vendas AS v WHERE c.Codigo = v.CodigoCliente) > 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${INPUT_COD_VENDEDOR}    ${codVendedor[0][0]}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${INPUT_COD_CLIENTE}    ${codCliente[0][0]}
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Valida alerta após inserir cliente
    Sleep    ${SLEEP_BAIXO}

    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_BAIXO}

    Valida Condicionais em Aberto
    Sleep    ${SLEEP_BAIXO}

    Valida informações de crédito
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${COD_CLIENTE}    ${codCliente[0][0]}

Quando insiro um produto normal para ser devolvido

    Sleep    ${SLEEP_BAIXO}
    ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Valida Cliente Não comprou produto 
        
    Valida quantidade de estoque inexistente

    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

    Set Test Variable    ${VALOR_FINAL}    0

Quando insiro produtos que o cliente já tenha comprado(${QUANTIDADE_PRODUTOS})
    
    FOR    ${I}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
        Sleep    ${SLEEP_BAIXO}
        ${codProduto}    Query    SELECT CodigoProduto FROM vendasprodutos AS vp INNER JOIN vendas AS v ON vp.CodigoVenda = v.Codigo WHERE v.CodigoCliente = ${COD_CLIENTE} AND v.Cancelada IS NULL ORDER BY RAND() LIMIT 1;
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${codProduto[0][0]} 
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
            
        Valida quantidade de estoque inexistente

        Sleep    ${SLEEP_BAIXO}
        
    END

    Set Test Variable    ${VALOR_FINAL}    0

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    ${QUANTIDADE_PRODUTOS}

Quando seleciono produtoS para a troca(${QUANTIDADE_TROCA})
    
    Press Combination    KEY.ALT     Key.T 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    ${QUANTIDADE_TROCA}
        
        ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${codProduto[0][0]} 
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
            
        Valida quantidade de estoque inexistente

        Sleep    ${SLEEP_BAIXO}
        
    END
    
E vou para a aba de pagamentos 
    
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_MEDIO}

Quando desdobro os pagamentos

    Recupera codigo Condicional

    Sleep    ${SLEEP_BAIXO}

    ${VALOR_FINAL}    Query    SELECT SUM(ValorTotal) FROM vendasprodutos as vp INNER JOIN vendas AS v ON v.Codigo = vp.CodigoVenda WHERE v.Codigo = ${COD_DEVOLUCAO}

    IF     ${VALOR_FINAL[0][0]} > 0
        
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.e

    END

    Set Test Variable    ${VALOR_FINAL}    ${VALOR_FINAL[0][0]}

Então finalizo a devolução
    
    IF    ${POSSUI_OBS} == ${False}
        Input Text    ${INPUTBOX_OBSERVACOES}    Devolucao de Produtos - Atacado Total | User: ADM
    END

    Press Combination    KEY.ALT     Key.F 

    IF     ${VALOR_FINAL} > 0
        
        Sleep    ${SLEEP_BAIXO}
        Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
        Input Text    ${EMPTY}    ${VALOR_FINAL}
        Press Combination    KEY.ALT     Key.C

    ELSE

        Sleep    ${SLEEP_BAIXO}
        Wait Until Screen Contain    ${TELA_IMPRESSAO_DIRETA}    ${TEMPO_TELA}
        Press Combination    KEY.ALT     Key.S  

    END

    Sleep    ${SLEEP_MEDIO}
    #Essa parte deve ser temporária, só para passar o bug da tarefa: 139986
    Wait Until Screen Contain    ${TELA_IMPRESSAO_DIRETA}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.S

Quando gravo a devolução 
    
    Input Text    ${INPUTBOX_OBSERVACOES}    Devolucao de Produtos - Atacado Total | User: ADM
    Press Combination    KEY.ALT     Key.G
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${TELA_IMPRESSAO_DIRETA}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.S
    Wait Until Screen Contain    ${TELA_DEVOLUCOES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${POSSUI_OBS}    ${True}

E edito a mesma 
    
    Press Combination    KEY.ALT     Key.E
    Wait Until Screen Contain    ${TELA_DEVOLUCOES_ADD}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Valida alerta após inserir cliente
    Sleep    ${SLEEP_BAIXO}

    Valida aviso cliente outro vendedor
    Sleep    ${SLEEP_BAIXO}

    Valida Condicionais em Aberto
    Sleep    ${SLEEP_BAIXO}

    Valida informações de crédito
    Sleep    ${SLEEP_BAIXO}

Quando removo um produto da devolução 
    
    Press Combination    KEY.ALT     Key.R 
    Wait Until Screen Contain    ${AVISO_EXCLUIR_PRODUTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.S 
    Sleep    ${SLEEP_BAIXO}

Quando clico em excluir

    Press Combination    KEY.ALT     Key.x
    Sleep    ${SLEEP_BAIXO}

E informo o motivo

    Wait Until Screen Contain    ${TELA_EXCLUI_DEVOLUCAO}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    Exlusao de devolucao por motivo de falha no cliente
    Sleep    ${SLEEP_BAIXO}

Então excluo a devolução

    SikuliLibrary.Click    ${BT_SIM}
    Sleep    ${SLEEP_MEDIO}
    Check If Exists In Database    SELECT * FROM vendas WHERE Codigo = ${COD_DEVOLUCAO} AND `Status` LIKE 'x'

Quando edito um produto
    
    Press Combination    KEY.ALT     Key.E
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    2
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    10
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Valida alerta de liberação de desconto

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.I
    Sleep    ${SLEEP_BAIXO}

#---------------------------------------------------------------------------------------------------------------------------#
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

Valida Condicionais em Aberto
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_COND_ABERTO}

    IF    ${MSG} == ${True}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida Cliente Não comprou produto 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_NAOCOMPROU_PRODT}

    IF    ${MSG} == ${True}

       Press Combination    KEY.ALT     Key.S 
       Sleep    ${SLEEP_BAIXO} 

    END

Valida alerta de liberação de desconto 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_LIBERA_DESCONTO}

    IF    ${MSG} == ${True}

        Input Text    ${EMPTY}    1 
        Sleep    ${SLEEP_BAIXO} 
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

    END

Recupera codigo Condicional

    ${Consulta}    Query    SELECT Codigo FROM vendas WHERE Tipo LIKE 'DV' ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_DEVOLUCAO}    ${Consulta[0][0]}