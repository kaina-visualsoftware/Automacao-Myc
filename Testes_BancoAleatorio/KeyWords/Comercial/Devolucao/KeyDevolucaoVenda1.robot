*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../../../libs/validaParametros.py
Library    Process
Library    ../../../libs/verificacoesExtras.py
Variables    ../../../libs/leituraConfig.py

Resource    ../../../utils/utils.robot
Resource    ../../../utils/validacaoAviso.robot
Resource    ../../../KeyWords/Comercial/Vendas/keyVendas1.robot

*** Variables ***
# Telas
${TELA_DEVOLUÇÕES_AVULSA_ADICIONAR}    tela_DevolucaoAvulsaAdicionar.png
${TELA_DEVOLUÇÕES_ADICIONAR}           tela_DevolucoesAdicionar.png

# Inputs
${INPUT_VENDA/OS}                      lb_CodVendaOs.png
${INPUTBOX_OBS}                        inputBox_Observacoes.png

# Labels
${LABEL_MOTIVO_DEVOLUCAO}              lb_motivoDevolucao.png
${LABEL_SERA_GERADO_VALE_COMPRA}       lb_SeraGeradoValeCompraValorDev.png

# Variáveis de Operação (inicializadas em runtime via Set Test Variable)
${COD_DEVOLUCAO}                       None
${EntradaIgualA_Outros_dev}            None
${FORMA_PADRAO_DEV}                    None
${ID_VALE_COMPRA}                      None
${Quantidade_Produto_Devolucao}        None

*** Keywords ***
Dado que acesso a tela de devoluções de vendas/OS

    ${FORMA_PADRAO_DEV}    Valida Forma Parcelamento    Devolução

    Valida cadastro de motivos de devoluções

    Press Special Key    F6

    Valida lançamento de devolução em aberto

    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${FORMA_PADRAO_DEV}

Quando adiciono uma nova devolução

    Press Combination    KEY.ALT    KEY.A
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES_ADICIONAR}    ${TEMPO_TELA}

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

E insiro os dados da venda no cabeçalho da devolução(${TELA})
    
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

        Verifica se cliente possui condicional em aberto(${Codigo_Cliente})
    
    ELSE 

        SikuliLibrary.Double Click    ${INPUT_VENDA/OS}
        Sleep    ${SLEEP_BAIXO}

        Input Text    ${EMPTY}    ${COD_VENDA}

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END

Quando seleciono um produto para a devolução

    Set Test Variable    ${Quantidade_Produto_Devolucao}    ${Quantidade_Produto}

    IF     ${Parametro_DevolucaoAvulsa}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_PRODUTO}

        FOR    ${I}    IN RANGE    3

            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        Sleep    ${SLEEP_BAIXO}

        IF    ${Parametro_IncluiDireto} != ${True}
        
            Press Combination    KEY.ALT    KEY.I
            Sleep    ${SLEEP_BAIXO}

        END
        
        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto_Devolucao}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

    END 

Quando seleciono os produtos para a devolução(${Qtde_Produto_A_Devolver})

    Set Test Variable    ${Quantidade_Produto_Devolucao}    ${Quantidade_Produto}
    
    FOR    ${I}    IN RANGE    ${Qtde_Produto_A_Devolver}
        
        Set Test Variable    ${COD_PRODUTO}    ${Codigos_Produtos[${I}]}
        
        Quando seleciono um produto para a devolução
        
    END
    
Quando seleciono um produto para devolver parcialmente a quantidade vendida(${QtdeADevolver})

    IF     ${Parametro_DevolucaoAvulsa}

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${COD_PRODUTO}

        FOR    ${I}    IN RANGE    3

            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        Sleep    ${SLEEP_BAIXO}

        IF    ${Parametro_IncluiDireto} != ${True}
        
            Press Combination    KEY.ALT    KEY.I
            Sleep    ${SLEEP_BAIXO}

        END
        
        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${QtdeADevolver}
        
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

    END

    Set Test Variable    ${Quantidade_Produto_Devolucao}    ${QtdeADevolver}

E vou para a aba de pagamentos
    
    Press Combination    KEY.ALT    KEY.m
    Sleep    ${SLEEP_MEDIO}

    Valida cliente com vales compra disponíveis

    ${EntradaIgualA_Outros_dev}    Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO_DEV}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros_dev}

Então finalizo a devolução
    
    IF    not ${Parametro_ValeCompra_Dev_Menor0}

        IF    ${Parametro_DevolucaoAvulsa}

            Press Combination    KEY.ALT    KEY.e

        ELSE 

            Press Combination    KEY.ALT    KEY.b

        END

        IF    ${Parametro_DevolucaoExigeOBS}
            
            Type    ${EMPTY}    Devolucao de Mercadoria - Automacao

        END

        IF    ${Parametro_ObrigaMotivoDevolucao}

            IF    ${Parametro_DevolucaoAvulsa}

                Press Special Key    TAB
                Press Special Key    DOWN
            
            ELSE

                SikuliLibrary.Click    ${LABEL_MOTIVO_DEVOLUCAO}
                
                Sleep    ${SLEEP_BAIXO}

                Press Special Key    DOWN
                Press Special Key    ENTER

            END           
            
        END

        Sleep    ${SLEEP_BAIXO}
        Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT    KEY.F 
        Sleep    ${SLEEP_BAIXO}

        IF    '${FORMA_PADRAO_DEV[0]}' == 'À VISTA'
            
            IF    ${EntradaIgualA_Outros_dev}

                Input Text    ${EMPTY}    -

                Finalização com recebimento de duplicatas(${VALOR_FINAL_VENDA}) 

            END

        END
    
    ELSE

        Wait Until Screen Contain    ${LABEL_SERA_GERADO_VALE_COMPRA}    ${TEMPO_TELA}
        
        IF    ${Parametro_DevolucaoExigeOBS}

            IF    ${Parametro_DevolucaoAvulsa}

                Type    ${INPUTBOX_OBS}    Devolucao Avulsa de Mercadoria - Automacao

            ELSE

                Type    ${EMPTY}    Devolucao de Mercadoria - Automacao

            END

        END

        IF    ${Parametro_ObrigaMotivoDevolucao}

            IF    ${Parametro_DevolucaoAvulsa}

                Press Special Key    TAB
                Press Special Key    DOWN
            
            ELSE

                SikuliLibrary.Click    ${LABEL_MOTIVO_DEVOLUCAO}
                
                Sleep    ${SLEEP_BAIXO}

                Press Special Key    DOWN
                Press Special Key    ENTER

            END           
            
        END

        Press Combination    KEY.ALT    KEY.F
        Sleep    ${SLEEP_BAIXO}
        
        Valida vendedor sem percentual de comissão para operações com vale compra

        Valida impressao direta de venda(${True})

        ${CodigoVale}    Query    SELECT ID FROM valecompra WHERE VendaOrigem = ${COD_DEVOLUCAO}

        Set Test Variable    ${ID_VALE_COMPRA}    ${CodigoVale[0][0]}

    END

    Calcula valor final da devolução
    
    # É True porque só não imprime ao finalizar se o botão "Imprimir" estiver bloqueado.
    Valida impressao direta de venda(${True})

    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Então visualizo a devolução

    Press Special Key    F6
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.V 
    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.r
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}     ${TEMPO_TELA}

Quando finalizo a devolução como aberta
    
    IF    ${Parametro_DevolucaoPermiteAberta}

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT    KEY.G

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

        Press Combination    KEY.ALT    KEY.E

        Valida solicitação de senha do usuário supervisor

        Aguarda tela Devolução avulsa

    END

Quando insiro um produto para a troca
    
    IF    ${Parametro_DevolucaoPermiteAberta}

        Press Combination    KEY.ALT    KEY.T
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
    
    Press Combination    KEY.ALT    KEY.x 
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitação de senha do usuário supervisor

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Type    ${EMPTY}    Exclusao de Devolucao - Teste Automacao

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER

    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Calcula valor final da devolução

    ${somaValorTotalProdutosDevolucao}    Evaluate    0
    
    Sleep    ${SLEEP_BAIXO}
    ${consultaVendasProdutos}    Query    SELECT vp.CodigoProduto, vp.ValorUnitario, vp.ValorTotal FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_VENDA} ORDER BY vp.Sequencia;

    ${consultaVendasProdutosDevolucao}    Query    SELECT vp.CodigoProduto, vp.ValorUnitario, vp.ValorTotal FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_DEVOLUCAO} ORDER BY vp.Sequencia;

    ${consultaQtdeProdutosDevolucao}    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_DEVOLUCAO};

    ${QUANTIDADE_PRODUTOS}    Set Variable    ${consultaQtdeProdutosDevolucao[0][0]}

    FOR    ${i}    IN RANGE    ${QUANTIDADE_PRODUTOS}
        
        ${ProdutoValorUnitario}    Set Variable    ${consultaVendasProdutos[${i}][1]}

        ${Produto_ValorTotalDev}    Set Variable    ${consultaVendasProdutosDevolucao[${i}][2]}

        ${calcValorTotalProdutoDevolucao}    Evaluate    round((${Quantidade_Produto_Devolucao} * ${ProdutoValorUnitario}), 2)
        ${calcValorTotalProdutoDevolucao}    Evaluate    ${calcValorTotalProdutoDevolucao} * (-1)

        Should Be Equal    ${Produto_ValorTotalDev}    ${calcValorTotalProdutoDevolucao}

        ${somaValorTotalProdutosDevolucao}    Evaluate    round((${somaValorTotalProdutosDevolucao} + ${calcValorTotalProdutoDevolucao}), 2)
        
    END

    Sleep    ${SLEEP_BAIXO}
    ${ValorTotalProdutosDevolucao}    Query    SELECT ROUND(SUM(vp.ValorTotal), 2) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_DEVOLUCAO};

    Should Be Equal    ${ValorTotalProdutosDevolucao[0][0]}    ${somaValorTotalProdutosDevolucao}

    Set Test Variable    ${Valor_Total_Produtos}    ${ValorTotalProdutosDevolucao[0][0]}

    Set Test Variable    ${VALOR_FINAL_DEVOLUCAO}    ${ValorTotalProdutosDevolucao[0][0]}

Valida cadastro de motivos de devoluções

    IF    ${Parametro_ObrigaMotivoDevolucao}
        
        Sleep    ${SLEEP_BAIXO}
        ${NaoPossuiMotivosDev}    Run Keyword And Return Status    Check If Not Exists In Database    SELECT * FROM motivosdevolucao LIMIT 1

        IF    ${NaoPossuiMotivosDev}

            Execute Sql String    INSERT INTO `motivosdevolucao` (`Descricao`) VALUES ('MOTIVO - AUTOMACAO');
             
        END
        
    END