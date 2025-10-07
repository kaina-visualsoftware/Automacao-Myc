*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../utils/utils.robot
Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot

*** Variables ***
# Repositório de Imagens
${IMAGES}                              ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                              ${config.IpServidor}
${DBName}                              ${config.Database}
${DBPass}                              vssql
${DBPort}                              ${config.Porta}
${DBUser}                              root

# Sleep's
${SLEEP_BAIXO}                         0.7
${SLEEP_MEDIO}                         1.5
${SLEEP_ALTO}                          3
${TEMPO_TELA}                          20

# Telas
${TELA_DEVOLUÇÕES}                     tela_Devolucoes.png
${TELA_DEVOLUÇÕES_AVULSA_ADICIONAR}    tela_DevolucaoAvulsaAdicionar.png
${FORMA_RECEBIMENTO_OUTROS}            Outros...

# Outros
${INPUT_VENDA/OS}                      lb_CodVendaOs.png
${INPUTBOX_OBS}                        inputBox_Observacoes.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que abro a tela de Devolução de vendas/os

    ${FORMA_PADRAO_DEV}    Valida Forma Parcelamento    Devolução

    Verifica parametros que interferem na venda

    Press Special Key    F6

    Valida lançamento de devolução em aberto

    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${FORMA_PADRAO_DEV}

Quando adiciono uma nova devolução

    Press Combination    KEY.ALT     Key.A

    IF     ${Parametro_DevolucaoAvulsa}

        Aguarda tela Devolução avulsa 

    END   

    Sleep    ${SLEEP_MEDIO}
    ${Consulta}    Query    SELECT Codigo FROM vendas WHERE Tipo LIKE 'DV' ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_DEVOLUCAO}                  ${Consulta[0][0]}
    Set Test Variable    ${CODIGO_OPERACAO_MOV}            ${COD_DEVOLUCAO}
    Set Test Variable    ${DADOS_VENDA_DEVOLUÇÃO[1][0]}    ${COD_DEVOLUCAO}

    ${VALOR_TOTAL_DEV}    Evaluate    (${VALOR_FINAL_VENDA} * (-1))

    ${DADOS_DEVOLUÇÃO}    Create List    ${COD_DEVOLUCAO}    ${VALOR_TOTAL_DEV}

    Append To List    ${DADOS_VENDA_DEVOLUÇÃO}    ${DADOS_DEVOLUÇÃO}

Aguarda tela Devolução avulsa
    
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES_AVULSA_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E insiro os dados do cabeçalho - vendedor, venda|cliente(${TELA})
    
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Press Special Key    TAB

    Verifica seleção de tabela de preço(${TELA})

    IF     ${Parametro_DevolucaoAvulsa}

        SikuliLibrary.Double Click    ${INPUT_CODIGO_CLIENTE_DEVOLUCAO}
        Sleep    ${SLEEP_BAIXO}

        Input Text    ${EMPTY}    ${Codigo_Cliente}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

        Verifica se condicional existe(${Codigo_Cliente})
    
    ELSE 

        SikuliLibrary.Double Click    ${INPUT_VENDA/OS}
        Sleep    ${SLEEP_BAIXO}

        Input Text    ${EMPTY}    ${COD_VENDA}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END

Quando seleciono um produto para a devolução

    IF     ${Parametro_DevolucaoAvulsa}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_PRODUTO}

        FOR    ${I}    IN RANGE    3

            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        Sleep    ${SLEEP_BAIXO}

        IF    ${Parametro_IncluiDireto} != ${True}
        
            Press Combination    KEY.ALT     Key.I
            Sleep    ${SLEEP_BAIXO}

        END
        
        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${QUANTIDADE_PRODUTOS}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

    END 

Quando seleciono os produtos para a devolução(${Quantidade_Devolver})
    
    FOR    ${I}    IN RANGE    ${Quantidade_Devolver}
        
        Set Test Variable    ${COD_PRODUTO}    ${Codigos_Produtos[${I}]}
        
        Quando seleciono um produto para a devolução
        
    END

E vou para a aba de pagamentos
    
    Press Combination    KEY.ALT     Key.m
    Sleep    ${SLEEP_MEDIO}

    Valida cliente com vales compra disponíveis

    ${EntradaIgualA_Outros_dev}    Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO_DEV}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros_dev}

Então finalizo a devolução
    
    IF     ${Parametro_ValeCompra_Dev_Menor0} != $True

        IF     ${Parametro_DevolucaoAvulsa}

            Press Combination    KEY.ALT     Key.e 

        ELSE 

            Press Combination    KEY.ALT     Key.b 

        END

        IF     ${Parametro_DevolucaoExigeOBS}
            
            Input Text    ${EMPTY}    Devolucao de Mercadoria - Automacao

        END

        Sleep    ${SLEEP_BAIXO}
        Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.F 
        Sleep    ${SLEEP_BAIXO}

        IF    '${FORMA_PADRAO_DEV[0]}' == 'À VISTA'
            
            IF    ${EntradaIgualA_Outros_dev}

                Input Text    ${EMPTY}    -

                Finalização com recebimento de duplicatas(${VALOR_FINAL_VENDA}) 

            END

        END
    
    ELSE
        
        IF     ${Parametro_DevolucaoExigeOBS}

            IF     ${Parametro_DevolucaoAvulsa}

                Input Text    ${INPUTBOX_OBS}    Devolucao de Mercadoria - Automacao

            ELSE

                Input Text    ${EMPTY}    Devolucao de Mercadoria - Automacao

            END

        END

        Press Combination    KEY.ALT     Key.F 
        Sleep    ${SLEEP_BAIXO}
        
        #Impressão do vale compra
        Valida impressao direta de venda(${True})

        ${CodigoVale}    Query    SELECT ID FROM valecompra WHERE VendaOrigem = ${COD_DEVOLUCAO}

        Set Test Variable    ${ID_VALE_COMPRA}    ${CodigoVale[0][0]}

    END
    
    # É True porque só não imprime ao finalizar se o botão "Imprimir" estiver bloqueado.
    Valida impressao direta de venda(${True})

    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então visualizo a devolução

    Press Special Key    F6
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.V 
    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}     ${TEMPO_TELA}

Quando finalizo a devolução como aberta
    
    IF    ${Parametro_DevolucaoPermiteAberta}

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.G

        # É True porque só não imprime ao finalizar se o botão "Imprimir" estiver bloqueado.
        Valida impressao direta de venda(${True})

        Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}

    ELSE
        
        # Se não for possível editar, a finalização ocorrerá como uma devolução normal.
        Então finalizo a devolução
        
        Log To Console    Devolução Não permite edição! Finalizando normalmente.
        
    END

E edito a devolução

    IF    ${Parametro_DevolucaoPermiteAberta}

        Press Combination    KEY.ALT     Key.E

        Valida solicitacao de senha do usuário

        Aguarda tela Devolução avulsa

    END

Quando insiro um produto para a troca
    
    IF    ${Parametro_DevolucaoPermiteAberta}

        Press Combination    KEY.ALT     Key.T
        Sleep    ${SLEEP_BAIXO}

        IF     ${Parametro_RealizaVendaSemEstoque}

            utils.Inserir Produto normal - Permite sem estoque

        ELSE
            
            utils.Inserir Produto normal - Necessita de estoque

        END

        utils.Valida parametros após incluir produto

    END

Então finalizo a devolução após a edição

    IF    ${Parametro_DevolucaoPermiteAberta}

        E vou para a aba de pagamentos
        Então finalizo a devolução

    END

Então excluo a devolução
    
    Press Special Key    F6
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    
    Press Combination     KEY.ALT     Key.x 
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitacao de senha do usuário

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    Exclusao de Devolucao - Teste Automacao

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
