*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process
Library    ../libs/verificacoesExtras.py
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot
Resource     ../utils/montadorDeCenarios.robot

*** Variables ***
#Imagens
${IMAGENS}    ./Testes_BancoAleatório/images

#Conexão com banco de dados
${DBHost}                                      ${config.IpServidor}
${DBName}                                      ${config.Database}
${DBPass}                                      vssql
${DBPort}                                      ${config.Porta}
${DBUser}                                      root

#Sleep's
${SLEEP_BAIXO}                                 0.7
${SLEEP_MEDIO}                                 1.7
${SLEEP_ALTO}                                  3
${TEMPO_TELA}                                  20

#Imagens Telas
${MENU_EMISSÃO}                                menu_Emissão.png
${SUBMENU_ORDEM_DE_ENTREGA_NOVO}               subMenu_OrdemDeEntregaNovo.png
${SUBMENU_ORDEM_DE_ENTREGA_NOVO_LANCAMENTO}    subMenu_OrdemDeEntregaNovoLancamento.png
${TELA_ORDEM_DE_ENTREGA}                       tela_OrdemDeEntrega.png
${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}             grid_PedidosOrdemDeEntregaNovo.png
${LB_CODIGO_PEDIDO}                            lb_CodigoPedido.png
${TELA_ENTREGAS}                               tela_Entregas.png
${TELA_DETALHES_GERACAO_ENTREGA}               tela_DetalhesGeracaoEntrega.png
${INPUT_COD_ENTREGADOR}                        input_CodEntregador.png
${AVISO_ENTREGADOR_JA_VINCULADO_ENTREGA}       aviso_EntregadorJaVinculadoComEntrega.png
${LABEL_ID_ENTERGA}                            label_IdEntrega.png
${TELA_EDICAO_ENTREGA}                         tela_EdicaoEntrega.png
${ABA_IMAGEM_ENTREGA}                          aba_ImagemEntrega.png
${ABA_VENDAS_ENTREGAS}                         aba_VendasEntregas.png
${ROW_VENDA_INCLUSA_ENTREGA}                   row_VendaInclusaEntrega.png
${TELA_VISUALIZACAO_ENTREGA}                   tela_VisualizacaoEntrega.png
${TELA_EXCLUSAO_ENTREGA}                       tela_ExclusaoEntrega.png
${TELA_WORKFLOW_ENTREGA}                       tela_WorkflowEntrega.png
${BT_SETA_INCLUIR_PRODUTO_ENTREGA}             bt_SetaIncluirProdutoEntrega.png

*** Keywords ***

Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que eu inicio um lançamento de Ordem de Entrega Novo
        
    SikuliLibrary.Click    ${MENU_EMISSÃO}
    Wait Until Screen Contain    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO}
    Wait Until Screen Contain    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO_LANCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${SUBMENU_ORDEM_DE_ENTREGA_NOVO_LANCAMENTO}
    Wait Until Screen Contain    ${TELA_ORDEM_DE_ENTREGA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando seleciono a última venda gerada

    Press Combination    KEY.ALT    KEY.F
    Sleep    ${SLEEP_BAIXO}    
    Wait Until Screen Contain    ${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LB_CODIGO_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LB_CODIGO_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${COD_VENDA}
    Sleep    ${SLEEP_BAIXO}

E seleciono o produto

    Valida descricao automatica de ordem de entrega

    Wait Until Screen Contain    ${BT_SETA_INCLUIR_PRODUTO_ENTREGA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

Última entrega gerada
    
    Sleep    ${SLEEP_BAIXO}
    ${consulta}    Query    SELECT ep.GrupoEntrega FROM entregas_pendentes ep ORDER BY ep.ID DESC LIMIT 1;

    Set Test Variable    ${ID_GRUPO_ENTREGA}    ${consulta[0][0]}

Então gero a entrega

    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_BAIXO}

    Valida detalhes da geração de entrega

    Valida impressão após gerar entrega

    Wait Until Screen Contain    ${TELA_ENTREGAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Última entrega gerada

Quando seleciono as últimas vendas feitas 
    
    ${Quantidade_Vendas_Feitas} =     Get Length    ${Codigos_Vendas}
    Set Test Variable    ${Quantidade_Vendas_Feitas}

    Press Combination    KEY.ALT     Key.F
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    ${Quantidade_Vendas_Feitas}

        SikuliLibrary.Click    ${LB_CODIGO_PEDIDO}
        Sleep    ${SLEEP_BAIXO}

        SikuliLibrary.Click    ${LB_CODIGO_PEDIDO}
        Sleep    ${SLEEP_BAIXO}

        Input Text    ${EMPTY}    ${Codigos_Vendas[${I}]}

        E seleciono o produto

        IF    ${I} == ${Quantidade_Vendas_Feitas} - 1

            Valida a geração de entregas com apenas uma venda por entrega

        END
        
    END

Quando seleciono a última doação gerada
    
    Valida considerar lançamento de ordem de entrega de doações

    Press Combination    KEY.ALT    KEY.F
    Sleep    ${SLEEP_BAIXO}    
    Wait Until Screen Contain    ${GRID_PEDIDOS_ORDEM_ENTREGA_NOVO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LB_CODIGO_PEDIDO}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${COD_DOACAO}
    Sleep    ${SLEEP_BAIXO}

Valida detalhes da geração de entrega

    ${telaDetalhes} =    Exists    ${TELA_DETALHES_GERACAO_ENTREGA}

    IF    ${telaDetalhes}

        ${codigoEntregador}    Seleciona o entregador da entrega

        ${tela} =    Exists    ${INPUT_COD_ENTREGADOR}

        IF    ${tela}
        
            SikuliLibrary.Click    ${INPUT_COD_ENTREGADOR}

        END
        
        Input Text    ${EMPTY}    ${codigoEntregador}
        Sleep    ${SLEEP_BAIXO}

        FOR    ${I}    IN RANGE    2
            
            Press Special Key    TAB
            
        END

        Valida entregador já vinculado com entrega não finalizada

        Type    H
        Press Special Key    TAB

        Seleciona a região da entrega

        Seleciona o veículo da entrega
        
        Press Combination    KEY.ALT    KEY.O
        Sleep    ${SLEEP_MEDIO}
        
    END

Seleciona o entregador da entrega

    ${codEntregador}    Query    SELECT codigo FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    RETURN    ${codEntregador[0][0]}

Seleciona a região da entrega
    
    ${possuiRegiao}    Run Keyword And Return Status    Check If Exists In Database    SELECT Codigo FROM regioes;
    Sleep    ${SLEEP_BAIXO}
    ${codRegiao}    Query    SELECT Codigo FROM regioes ORDER BY RAND() LIMIT 1;

    IF    ${possuiRegiao}

        Input Text    ${EMPTY}    ${codRegiao}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    ELSE

        Log To Console    \nSem regiões cadastradas.

        FOR    ${I}    IN RANGE    2
            
            Press Special Key    TAB
            
        END
        
    END

Seleciona o veículo da entrega

    ${possuiVeiculo}    Run Keyword And Return Status    Check If Exists In Database    SELECT v.ID FROM veiculos v WHERE v.Cancelado IS NULL;
    Sleep    ${SLEEP_BAIXO}
    ${codVeiculo}    Query    SELECT v.ID FROM veiculos v WHERE v.Cancelado IS NULL ORDER BY RAND() LIMIT 1;

    IF    ${possuiVeiculo}
        
        Input Text    ${EMPTY}    ${codVeiculo}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    ELSE
        
        Log To Console    \nSem veículos cadastrados ou com veículos deletados.

        FOR    ${I}    IN RANGE    2
            
            Press Special Key    TAB
            
        END

    END

Valida entregador já vinculado com entrega não finalizada

    ${aviso}    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_ENTREGADOR_JA_VINCULADO_ENTREGA}    ${SLEEP_ALTO}

    IF    ${aviso}
        
        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

    END

Dado que eu seleciono a entrega gerada

    SikuliLibrary.Click    ${LABEL_ID_ENTERGA}
    Sleep    ${SLEEP_BAIXO}

    SikuliLibrary.Click    ${LABEL_ID_ENTERGA}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${ID_GRUPO_ENTREGA}
    Sleep    ${SLEEP_BAIXO}

E edito a entrega

    Press Combination    KEY.ALT    KEY.E
    Wait Until Screen Contain    ${TELA_EDICAO_ENTREGA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.M
    Wait Until Screen Contain    ${ABA_IMAGEM_ENTREGA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.V
    Wait Until Screen Contain    ${ABA_VENDAS_ENTREGAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Valida se venda consta inclusa na entrega

    Press Combination    KEY.ALT    KEY.G
    Wait Until Screen Contain    ${TELA_ENTREGAS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Valida se venda consta inclusa na entrega

    ${vendaExiste} =    Exists    ${ROW_VENDA_INCLUSA_ENTREGA}

    IF    '${vendaExiste}' == 'False'

        Fail    \nNão consta registro de venda na entrega ${ID_GRUPO_ENTREGA}
        
    END

E visualizo a entrega

    Press Combination    KEY.ALT    KEY.V
    Wait Until Screen Contain    ${TELA_VISUALIZACAO_ENTREGA}    ${TEMPO_TELA}

    Press Combination    KEY.ALT    KEY.S

E excluo a entrega

    Press Combination    KEY.ALT    KEY.X
    Wait Until Screen Contain    ${TELA_EXCLUSAO_ENTREGA}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    Exclusao de Entrega - Teste Automacao
    FOR    ${I}    IN RANGE    2
            
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
            
    END

    Check If Exists In Database    SELECT * FROM entregas_pendentes ep INNER JOIN grupo_entregas gp ON ep.GrupoEntrega = gp.ID WHERE ep.GrupoEntrega = ${ID_GRUPO_ENTREGA} AND ep.Cancelada = 1 AND gp.Empresa = ep.Empresa AND gp.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

E visualizo o Workflow da entrega

    Press Combination    KEY.ALT    KEY.W
    Wait Until Screen Contain    ${TELA_WORKFLOW_ENTREGA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ESC

Então saio das telas de Entrega e Ordem de Entrega

    Wait Until Screen Contain    ${TELA_ENTREGAS}    ${TEMPO_TELA}
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    Wait Until Screen Contain    ${TELA_ORDEM_DE_ENTREGA}    ${TEMPO_TELA}
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}