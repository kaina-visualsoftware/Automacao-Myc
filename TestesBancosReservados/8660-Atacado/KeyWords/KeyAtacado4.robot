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

E adiciono vendedor e cliente

    Sleep    ${SLEEP_MEDIO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE Tipo LIKE 'D' OR Tipo LIKE 'V' AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) ORDER BY RAND() LIMIT 1;
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

E vou para a aba de pagamentos 
    
    Press Combination    KEY.ALT     Key.m 
    Sleep    ${SLEEP_MEDIO}

Então finalizo a devolução
    
    Input Text    ${INPUTBOX_OBSERVACOES}    Devolucao de Produtos - Atacado Total | User: ADM
    Press Combination    KEY.ALT     Key.F 
    Wait Until Screen Contain    ${TELA_IMPRESSAO_DIRETA}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_MEDIO} 

    #Essa parte deve ser temporária, só para passar o bug da tarefa: 139986
    Wait Until Screen Contain    ${TELA_IMPRESSAO_DIRETA}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.S

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