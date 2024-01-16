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

*** Variables ***
${IMAGES}                                ./Testes_BancoAleatório/images
#Conexão MySQL
${DBHost}                                10.1.1.220   
${DBName}                                ${config.Database}
${DBPass}                                vssql
${DBPort}                                ${config.Porta}
${DBUser}                                root
#Sleep's
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
#Imagens Telas
${TELA_ORDEM_DE_SERVICO}                 tela_OrdemDeServico.png
${TELA_ADICIONAR_ORDEM_DE_SERVICO}       tela_OrdemDeServicoAdicionar.png 
${ROW_PAGAMENTO_INCLUSO}                 row_PagIncluso.png
${FORMA_RECEBIMENTO_OUTROS}              Outros...
${TELA_FATURAMENTO_OS}                   modal_OpcoesDeFaturamento.png 
${TELA_IMPRIME_CARNE_OS}                 tela_ImprimeCarneOS.png
${TELA_VISUALIZA_VENDA}                  tela_VisualizaVenda.png 
${ROW_PAGAMENTO_INCLUSO}                 row_PagIncluso.png
${BT_EXCLUIR_PAGAMENTOS}                 bt_ExcluirPag.png
${TELA_EXCLUIR_PAGAMENTOS}               aviso_ExcluirPagOS.png
${TELA_CONFIRMAÇÃO_EXCLUSÃO}             tela_exclusaoVenda.png
${BT_SIMULADOR_FORMAS_PARCELAMENTO}      tela_SimulacaoRecebimentos.png
${LABEL_DESCRIÇÃO}                       lb_Descricao.png 
${TELA_SIMULADOR_FORMA_PACELAMENTO}      tela_SimuladorFormaParcelamento.png  
${TELA_CHECKLIST}                        tela_CheckList.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de Ordem de Servico 
    
    ${FORMA_PADRAO}    Valida Configuracoes OS
    ${FORMA_PRAZO}    Seleciona Forma Prazo

    Set Test Variable    ${FORMA_PADRAO}
    Set Test Variable    ${FORMA_PRAZO} 

    Verifica parametros que interferem na venda
    Press Special Key    F3
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando pressiono o atalho de adicionar
    Press Combination    KEY.ALT     Key.A 
    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    IF    ${Parametro_Local_Negociacao} 

        Valida local da negociação

    END

    IF    ${Parametro_IndicacaoVenda}
        
        Valida indicacao Venda

    END

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_ORDEM_SERVICO}    ${Consulta[0][0]}
    Log To Console    ${COD_ORDEM_SERVICO}

E adiciono vendedor e cliente 
    
    utils.Adicionar Vendedor e Cliente(OrdemDeServico)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

Quando Insiro um servico 
    
    utils.Inserir serviço

E insiro um produto normal
    
    IF     ${Parametro_VendaSemEstoqueOrdemDeServico}
        
        utils.Inserir Produto normal - Permite sem estoque

    ELSE

        utils.Inserir Produto normal - Necessita de estoque

    END

    utils.Valida parametros após incluir produto
    
E acesso a aba pagamentos

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_ALTO}

    Set Test Variable    ${DESCONTO_FORMA}    ${FORMA_PADRAO[1]}

    ${EntradaIgualA_Outros} =     Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}

    IF    '${FORMA_PADRAO[0]}' == 'PERSONALIZADA'
        
        utils.Personalização de Pagamentos

    END 

    IF     ${DESCONTO_FORMA} > 0

        Valida tela de liberação de desconto 

    END

Então finalizo a Ordem de Servico

    Verifica vendedor com senha

    Calcula valor final da OS

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento fim de semana(${FORMA_PADRAO})

    IF    ${FORMA_PADRAO[2]} > 0
        
        Valida tela de liberação de desconto 

    END

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F

    Valida check list

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'

        IF    ${Parametro_ControlaCredito}

            Press Special Key    TAB 
            Sleep    ${SLEEP_BAIXO}
            
            Valida Controle de Credito - Liberação(${VALOR_FINAL_OS})

            IF    ${VendedorPossuiSenha}
        
                Valida solicitacao de senha do usuário

            END

        END

    END

    #Deixado aqui por que pode ser QUE quando a forma for a vista, apareça antes das duplicatas, mas ainda é necessário validar
    IF    ${VendedorPossuiSenha}
        
        Valida solicitacao de senha do usuário

    END

    IF    '${FORMA_PADRAO[0]}' == 'À VISTA'
        
        IF    ${EntradaIgualA_Outros}

            IF     ${Parametro_BaixaAutomatico}
                
                Finalização com recebimento de duplicatas(${VALOR_FINAL_OS})

            END

        END

    END

    Valida avisos ao finalizar Ordem de serviço

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Então visualizado a OS recém criada
    
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.V 
    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${SLEEP_ALTO}

Quando clico em editar
    
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.E
    Sleep    ${SLEEP_BAIXO}

    validacaoAviso.Valida tela de liberação de desconto


E excluo os pagamentos lançados
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}
    SikuliLibrary.Click    ${BT_EXCLUIR_PAGAMENTOS}
    Wait Until Screen Contain    ${TELA_EXCLUIR_PAGAMENTOS}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    IF    '${FORMA_PADRAO[0]}' == 'PERSONALIZADA'

        utils.Personalização de Pagamentos

    END

Então finalizo a OS - A prazo 
    
    Verifica vendedor com senha

    Calcula valor final da OS

    SikuliLibrary.Click    ${BT_SIMULADOR_FORMAS_PARCELAMENTO}

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
        
    END

    Wait Until Screen Contain    ${TELA_SIMULADOR_FORMA_PACELAMENTO}    ${TEMPO_TELA}
    SikuliLibrary.Click    ${LABEL_DESCRIÇÃO}
    Input Text    ${EMPTY}    ${FORMA_PRAZO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}

    IF    ${FORMA_PADRAO[2]} > 0
        
        Valida tela de liberação de desconto

    END

    Valida vencimento fim de semana(${FORMA_PADRAO})

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F

    IF    ${Parametro_ControlaCredito}
        
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}

        Valida Controle de Credito - Liberação(${VALOR_FINAL_OS})

        IF    ${VendedorPossuiSenha}
        
            Valida solicitacao de senha do usuário

        END

    END


    #Deixado aqui por que pode ser QUE quando a forma for a vista, apareça antes das duplicatas, mas ainda é necessário validar
    IF    ${VendedorPossuiSenha}
        
        Valida solicitacao de senha do usuário

    END

    Valida avisos ao finalizar Ordem de serviço

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}

Então clico em excluir

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.X
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitacao de senha do usuário

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    Exclusao de OS - Teste Automacao
    Press Special Key    TAB
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    
    Check If Exists In Database    SELECT * FROM vendas WHERE Codigo = ${COD_ORDEM_SERVICO} AND `Status` LIKE 'x'

Calcula valor final da OS

    ${ValorTotalProdutos}     Query    SELECT SUM(vp.ValorTotal + vs.ValorTotal) FROM vendasprodutos AS vp INNER JOIN vendasservicos AS vs ON vs.CodigoVenda = vp.CodigoVenda WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO};

    Set Test Variable    ${VALOR_FINAL_OS}    ${ValorTotalProdutos[0][0]}
    
Valida avisos ao finalizar Ordem de serviço
    
    IF    ${Parametro_Imprime_OS}
        
        Valida impressao direta de venda(${Parametro_Imprime_OS})

    END

    IF    ${Parametro_Imprime_Carne_OS}

        Valida impressao carne OS 

    END 

    IF    ${Parametro_Fatura_OS}
        
        Valida faturamento os pos finalizar

    END

Valida faturamento os pos finalizar
    
    ${MSG} =      Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_FATURAMENTO_OS}    ${TEMPO_TELA}

    IF    ${MSG}

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.F 

    END

Valida impressao carne OS 

    ${MSG} =      Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_IMPRIME_CARNE_OS}    ${TEMPO_TELA}

    IF    ${MSG}

        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.N

    END
    
Valida check list
    
    IF    ${Check_List_Objeto}
        
        Wait Until Screen Contain    ${TELA_CHECKLIST}    ${TEMPO_TELA}

        ${Perguntas_CheckList}    Query    SELECT Pergunta, TipoResposta, Obrigar FROM checklist_questions WHERE CodigoCheckList = ${Codigo_CheckList}

        ${QuantidadePerguntas}    DatabaseLibrary.Row Count    SELECT Pergunta FROM checklist_questions WHERE CodigoCheckList = ${Codigo_CheckList}

        SikuliLibrary.Click Text    ${Perguntas_CheckList[0][0]}

        FOR    ${I}    IN RANGE    ${QuantidadePerguntas}
            
            IF    ${Perguntas_CheckList[${I}][2]} == 1

                Sleep    ${SLEEP_BAIXO}
                Press Special Key    RIGHT
                Press Special Key    ENTER 
                Sleep    ${SLEEP_BAIXO}
                
                IF    '${Perguntas_CheckList[${I}][1]}' == 'A'
                    
                    #Validação para ficar alternando entre sim e não
                    IF    ${I} % ${2} == 0

                        Press Special Key    DOWN
                        Press Special Key    ENTER 

                    ELSE

                        Press Special Key    DOWN
                        Press Special Key    DOWN
                        Press Special Key    ENTER 

                    END                   

                ELSE
                    
                    Input Text    ${EMPTY}    Descricao de automacao em check list
                    Sleep    ${SLEEP_BAIXO}

                END

            END

            Press Special Key    DOWN
            Sleep    ${SLEEP_BAIXO}

        END

        Press Combination    KEY.ALT     Key.G
        Sleep    ${SLEEP_BAIXO}

    END