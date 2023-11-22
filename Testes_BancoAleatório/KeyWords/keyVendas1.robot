*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process
Variables    ../libs/leituraConfig.py

Resource    ../utils/utils.robot
Resource    ../utils/validacaoAviso.robot

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
${AVISO_CLIENTE_OUTRO_VE}                aviso_clienteOutroVendedor.png  
${TELA_INFO_CRÉDITOS}                    tela_InfoCreditos.png  
${TELA_ALTERAR_NUMERO}                   aviso_DesejaAlterarNumero.png
${TELA_VENDAS}                           atacado_TelaVendaBalcao.png
${TELA_VENDAS_ADICIONAR}                 atacado_TelaVendaBalcao_Adicionar.png
${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}      aviso_ExigeSenhaVendedorDiferente.png
${AVISO_CONDICIONAL_ABERTO}              aviso_CondicionalAbertoVenda.png
${ALERTA_CLIENTE}                        alertaCliente.png
${ROW_PROD_INCLUSO}                      row_ProdIncluso.png
${ROW_PAGAMENTO_INCLUSO}                 row_PagIncluso.png
${TELA_RECB_DUPLICATAS}                  tela_RecebimentoDuplicatas.png
${TELA_SENHA_SUPERVISOR}                 tela_SolicitaSenha.png
${TELA_EMISSAO_NFC}                      tela_EmissaoNFC.png  
${AVISO_NCM_INVALIDO}                    aviso_NCMInvalidoNFC.png
${TELA_IMPRESSAO}                        tela_Impressao.png
${TELA_SOLICITACAO_CREDITO}              tela_SolicitaLiberacaoCredito.png
${BT_SOLICITAR_CRÉDITO}                  bt_SolicitarCredito.png
${TELA_CONTROLE_CRÉDITO}                 tela_ControleDeCredito.png
${TELA_CONFIRMA_LIBERACAO_CREDITO}       tela_ConfirmaLiberacao.png
${LABEL_AVISO_CREDITO_LIBERADO}          lb_CreditoLiberado.png
${CORRIGE_FOCO}                          corrigeFoco.png
${TELA_IMPRESSAO_DUPLICATAS}             tela_ImpressaoDuplicatas.png
${AVISO_LIMITE_CRÉDITO_DESATUALIZADO}    aviso_ClienteLimiteCreditoDesatualizado.png
${TELA_VENDAS_ANTERIORES}                tela_ExibeAnteriores.png
${TELA_LIBERAÇÃO_DESCONTO_SENHA}         tela_liberacaoDesconto.png
${INPUT_VALOR_FINAL_VENDA}               inp_ValorDuplicatas.png
${TELA_EXIBE_CLIENTE}                    tela_exibeCliente.png
${FORMA_RECEBIMENTO_OUTROS}              Outros...
${TELA_SELECIONA_TIPO_ENTREGA}           tela_SelecionaEntrega.png
${TELA_IMPRIMIR_ORDEM_ENTREGA}           tela_ImprimirOrdemEntrega.png
${ERRO_FATURAR_NFC}                      erro_faturarNFC.png
${BT_OK}                                 bt_Ok.png
${TELA_RECIBO_ENTRADA}                   tela_ReciboEntrada.png 
${TELA_CONTRATO_VENDA}                   tela_ContratoVenda.png
${TELA_EMISSAO_PROMISSÓRIA}              tela_EmisssaoPromissoria.png  
${TELA_VISUALIZA_VENDA}                  tela_VisualizaVenda.png  
${COMBOBOX_FORMA_RECEBIMENTO}            cb_FormaRecebimento.png
${BT_EXCLUIR_PAGAMENTOS}                 bt_ExcluirPag.png
${TELA_EXCLUIR_PAGAMENTOS}               aviso_ExcluirPag.png
${TELA_IMPRESSAO_BOLETO}                 tela_impressaoBoleto.png
${BT_SIMULADOR_FORMAS_PARCELAMENTO}      tela_SimulacaoRecebimentos.png
${LABEL_DESCRIÇÃO}                       lb_Descricao.png 
${TELA_SIMULADOR_FORMA_PACELAMENTO}      tela_SimuladorFormaParcelamento.png  
${BT_NÃO}                                bt_Nao.png
${TELA_OBSERVACAO_PRODUTO}               tela_ObservacaoProduto.png 
${TELA_CONFIRMAÇÃO_EXCLUSÃO}             tela_exclusaoVenda.png
${TELA_VENCIMENTO_FIM_DE_SEMANA}         tela_VencimentoFimDeSemana.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de vendas de balcao

    ${FORMA_PADRAO}    Valida Configuracoes Venda    ${DBName}
    ${FORMA_PRAZO}    Seleciona Forma Prazo    ${DBName} 

    Set Test Variable    ${FORMA_PADRAO}
    Set Test Variable    ${FORMA_PRAZO}   

    Press Special Key    F2
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

Quando pressiono o atalho de adicionar

    Verifica parametros que interferem na venda(${DBName})

    Press Combination    KEY.ALT     Key.A 

    Sleep    ${SLEEP_BAIXO}

    IF    ${Parametro_Local_Negociacao} 

        Valida local da negociação

    END

    IF    ${Parametro_IndicacaoVenda}
        
        Valida indicacao Venda

    END

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${COD_VENDA}    ${Consulta[0][0]}

E adiciono vendedor e cliente 

    utils.Adicionar Vendedor e Cliente(Venda)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${DBName} ${Codigo_Cliente})

Quando insiro um produto normal

    utils.Inserir Produto normal

E acesso a aba pagamentos

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_ALTO}

    Set Test Variable    ${DESCONTO_FORMA}    ${FORMA_PADRAO[1]}

    ${EntradaIgualA_Outros} =     Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros}

    IF     ${DESCONTO_FORMA} > 0

        Valida tela de liberação de desconto 

    END

Então finalizo a venda

    Verifica vendedor com senha

    Calcula valor final da venda

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}

    Valida vencimento fim de semana

    IF    ${FORMA_PADRAO[2]} > 0
        
        Valida tela de liberação de desconto 

    END

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F

    IF    '${FORMA_PADRAO[0]}' == '30 DIAS'

        IF    ${Parametro_ControlaCredito}
            
            Valida Controle de Credito - Liberação

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
                
                Finalização com recebimento de duplicatas(${VALOR_FINAL_VENDA}) 

            END

        END

    END

    Valida Parametros/Impressões pós venda

    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Então visualizo a mesma
    Press Combination    KEY.ALT     Key.V 
    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

E acesso a aba pagamentos - A Prazo

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_ALTO}

Então finalizo a venda - A Prazo

    Verifica vendedor com senha

    Calcula valor final da venda

    SikuliLibrary.Click    ${BT_SIMULADOR_FORMAS_PARCELAMENTO}
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

    Valida vencimento fim de semana

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F

    IF    ${Parametro_ControlaCredito}
            
        Valida Controle de Credito - Liberação

        IF    ${VendedorPossuiSenha}
        
            Valida solicitacao de senha do usuário

        END

    END


    #Deixado aqui por que pode ser QUE quando a forma for a vista, apareça antes das duplicatas, mas ainda é necessário validar
    IF    ${VendedorPossuiSenha}
        
        Valida solicitacao de senha do usuário

    END

    Valida Parametros/Impressões pós venda

Quando clico em editar
    
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.E
    Sleep    ${SLEEP_BAIXO}
    
    IF    ${VendedorPossuiSenha}
        
        Valida solicitacao de senha do usuário

    END

    Valida solicitacao de senha do usuário

    IF    ${Parametro_IndicacaoVenda}
        
        Valida indicacao Venda

    END

    Wait Until Screen Contain    ${TELA_VENDAS_ADICIONAR}     ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E excluo os pagamentos lançados 
    
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 

    Wait Until Screen Contain    ${ROW_PAGAMENTO_INCLUSO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}
    SikuliLibrary.Click    ${BT_EXCLUIR_PAGAMENTOS}
    Wait Until Screen Contain    ${TELA_EXCLUIR_PAGAMENTOS}    ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

Então clico em excluir

    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}
    Press Combination    KEY.ALT     Key.X
    Sleep    ${SLEEP_BAIXO}
    
    Valida solicitacao de senha do usuário

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}
    Input Text    ${EMPTY}    Exclusao de Venda - Teste Automacao
    Press Special Key    TAB
    Press Special Key    ENTER
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    
    Check If Exists In Database    SELECT * FROM vendas WHERE Codigo = ${COD_VENDA} AND `Status` LIKE 'x'

Cancelando Faturando a NFC-e

    Sleep    ${SLEEP_MEDIO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C

Valida ncm invalido ao faturar nota 
    
    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_NCM_INVALIDO}

    IF    ${MSG}  

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.C
        Sleep    ${SLEEP_MEDIO}
        Log To Console    \n Script cancelou o faturamento por conter produtos com NCM inválido!\n

    END

Valida erro ao faturar NFC 
    
    Sleep    ${SLEEP_BAIXO}
    ${ERRO}    Exists    ${ERRO_FATURAR_NFC}    

    IF     ${ERRO}

        SikuliLibrary.Click    ${BT_OK}
        Sleep    ${SLEEP_MEDIO}
        Press Combination    KEY.ALT     Key.C
        Sleep    ${SLEEP_MEDIO}
        Log To Console    \n Script cancelou o faturamento por conter erro!\n

    END

Valida Impressao de duplicatas 

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRESSAO_DUPLICATAS}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida Controle de Credito - Liberação

    ${VALOR_CREDITO}    Query    SELECT ValorCredito FROM clientes WHERE Codigo = ${Codigo_Cliente}

    IF    ${VALOR_FINAL_VENDA} > ${VALOR_CREDITO[0][0]}
        
        SikuliLibrary.Click    ${CORRIGE_FOCO}

        Sleep    ${SLEEP_BAIXO}
        ${MSG}    Exists    ${TELA_SOLICITACAO_CREDITO}

        IF    ${MSG}  
            
            SikuliLibrary.Click    ${BT_SOLICITAR_CRÉDITO}
            Wait Until Screen Contain    ${TELA_CONTROLE_CRÉDITO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}
            Press Combination    KEY.ALT    Key.L
            Wait Until Screen Contain    ${TELA_CONFIRMA_LIBERACAO_CREDITO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_BAIXO}
            Press Combination    KEY.ALT    Key.o
            Wait Until Screen Contain    ${LABEL_AVISO_CREDITO_LIBERADO}    ${TEMPO_TELA}
            Sleep    ${SLEEP_MEDIO}
            Press Combination    KEY.ALT    Key.o
            Sleep    ${SLEEP_MEDIO}
            Press Combination    KEY.ALT    Key.F
            Sleep    ${SLEEP_BAIXO}

        END

    END

Valida tela de liberação de desconto 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_LIBERAÇÃO_DESCONTO_SENHA}

    IF    ${MSG}  
        
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER 
        Sleep    ${SLEEP_MEDIO}

    END

Calcula valor final da venda 
    
    ${ValorTotalProdutos}     Query    SELECT SUM(ValorTotal) FROM vendasprodutos WHERE CodigoVenda = (SELECT Codigo FROM vendas WHERE `Data` = CURDATE() ORDER BY Codigo DESC LIMIT 1);

    Set Test Variable    ${VALOR_FINAL_VENDA}    ${ValorTotalProdutos[0][0]}

Verifica vendedor com senha

    ${VendedorComSenha} =     Run Keyword And Return Status     Check If Exists In Database    SELECT SenhaVendedor FROM clientes WHERE Codigo = ${Codigo_Vendedor} AND SenhaVendedor IS NOT NULL AND SenhaVendedor NOT LIKE ''

    IF    ${VendedorComSenha}
        
        Log To Console    \nConsiderou que tem senha
        Execute Sql String    UPDATE clientes SET SenhaVendedor = 'W' WHERE Codigo = ${Codigo_Vendedor}
        Set Test Variable    ${VendedorPossuiSenha}    ${True}

    ELSE

        Log To Console    \nConsiderou como sem senha
        Set Test Variable    ${VendedorPossuiSenha}    ${False}

    END



Valida impressão de ordem de entrega 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRIMIR_ORDEM_ENTREGA}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de entrada 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_RECIBO_ENTRADA}

    IF    ${MSG}  

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão do contrato de venda 
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_CONTRATO_VENDA}

    IF    ${MSG}  

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de Promissórioa
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_EMISSAO_PROMISSÓRIA}

    IF    ${MSG}  

        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

Valida impressão de boleto 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_IMPRESSAO_BOLETO}

    IF    ${MSG}  

        SikuliLibrary.Click    ${BT_NÃO}
        Sleep    ${SLEEP_MEDIO}

    END

Valida vencimento fim de semana

    FOR    ${I}    IN RANGE    ${FORMA_PADRAO[4]}
        
        ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_VENCIMENTO_FIM_DE_SEMANA}    ${SLEEP_MEDIO}

        IF    ${MSG}  

            Press Combination    KEY.ALT     Key.S
            Sleep    ${SLEEP_BAIXO}

        END
        
    END

Valida Parametros/Impressões pós venda

    Valida impressao direta de venda(${Parametro_ImprimeVendaDireto})
    
    IF     ${Parametro_Imprime_Boleto}

        Valida impressão de boleto
    
    END

    IF     ${Parametro_Imprime_Entrada}

        Valida impressão de entrada
        #BUG QUE EXIBE 2X A MESMA TELA
        Valida impressão de entrada

    END

    IF    ${Parametro_ImprimeNFCeDireto}  
        
        Cancelando Faturando a NFC-e

    END

    IF     ${Parametro_Imprime_Contrato_Venda}

        Valida impressão do contrato de venda

    END

    IF     ${Parametro_Imprime_OrdemEntrega}

        Valida impressão de ordem de entrega

    END

    IF    ${Parametro_ImprimeDuplicataVenda}
        
        Valida Impressao de duplicatas

    END

    IF     ${Parametro_Imprime_Promissoria}

        Valida impressão de Promissórioa

    END