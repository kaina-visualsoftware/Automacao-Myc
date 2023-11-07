*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process

*** Variables ***
${IMAGES}                                ./Testes_BancoAleatório/images
#Conexão MySQL
${DBHost}                                10.1.1.220
${DBName}                                bdvinicius
${DBPass}                                vssql
${DBPort}                                3306
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
${INPUT_COD_CLIENTE}                     lb_CodCliente.png
${AVISO_SEM_ESTOQUE}                     aviso_QuantidadeSemEstoque.png
${ROW_PROD_INCLUSO}                      row_ProdIncluso.png
${ROW_PAGAMENTO_INCLUSO}                 row_PagIncluso.png
${TELA_RECB_DUPLICATAS}                  tela_RecebimentoDuplicatas.png
${TELA_SENHA_SUPERVISOR}                 tela_SolicitaSenha.png
${TELA_EMISSAO_NFC}                      tela_EmissaoNFC.png  
${AVISO_NCM_INVALIDO}                    aviso_NCMInvalidoNFC.png
${TELA_INDICACAO_VENDA}                  tela_QuemIndicou.png
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
${TELA_SOLICITACAO_SENHA_USUARIO}        tela_SolicitaSenha.png
${INPUT_VALOR_FINAL_VENDA}               inp_ValorDuplicatas.png
${TELA_EXIBE_CLIENTE}                    tela_exibeCliente.png
${FORMA_RECEBIMENTO_OUTROS}              Outros...                      999  
${TELA_SELECIONA_TIPO_ENTREGA}           tela_SelecionaEntrega.png
${MODAL_LOCAL_NEGOCIACAO}                tela_LocalNegociacao.png
${BT_CONFIRMA_CANAL_NEGOCIACAO}          bt_ConfirmarCanal.png
${TELA_IMPRIMIR_ORDEM_ENTREGA}           tela_ImprimirOrdemEntrega.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de vendas de balcao

    Press Special Key    F2
    Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}

Quando pressiono o atalho de adicionar

    Verifica parametros que interferem na venda

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

    Sleep    ${SLEEP_BAIXO}
    ${codVendedor}    Query    SELECT codigo FROM clientes WHERE (Tipo LIKE 'D' OR Tipo LIKE 'V') AND Ativo = -1 AND `Status` LIKE 'ATIVA' ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}
    ${codCliente}    Query    SELECT codigo FROM clientes AS c WHERE (c.Tipo LIKE 'C' OR c.Tipo LIKE 'A') AND (Ativo = -1 AND c.`Status` = 'ATIVA') AND (CreditoCortado = 0) ORDER BY RAND() LIMIT 1;
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${codVendedor[0][0]}
    Sleep    ${SLEEP_BAIXO}
    SikuliLibrary.Click    ${INPUT_COD_CLIENTE}
    Sleep    ${SLEEP_BAIXO}
    Input Text    ${EMPTY}    ${codCliente[0][0]}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${Codigo_Cliente}    ${codCliente[0][0]}
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor[0][0]}

    Verifica avisos presentes ao incluir cliente

Quando insiro um produto normal

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.P
    Sleep    ${SLEEP_BAIXO}

    IF    ${Parametro_VendeSemEstoque}

        ${codProduto}    Query    SELECT codigo FROM produtos WHERE ModalidadeControle LIKE 'Normal' AND Cancelado IS NULL AND Ativo = -1 ORDER BY RAND() LIMIT 1;
        Sleep    ${SLEEP_MEDIO}

    ELSE
        
        ${codProduto}    Query    SELECT p.Codigo FROM produtos AS p INNER JOIN produtosestoque AS pe ON p.Codigo = pe.CodigoProduto WHERE p.ModalidadeControle LIKE 'Normal' AND (p.Cancelado IS NULL AND p.Ativo = -1) AND (pe.Estoque > 0 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1)) ORDER BY RAND() LIMIT 1;
        Sleep    ${SLEEP_MEDIO}

    END        

    Input Text    ${EMPTY}    ${codProduto[0][0]} 
    Sleep    ${SLEEP_BAIXO}

    FOR    ${I}    IN RANGE    3

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END
    
    IF    ${Parametro_IncluiDireto} != ${True}
        
        Press Combination    KEY.ALT     Key.I
        Sleep    ${SLEEP_BAIXO}

    END

    IF     ${Parametro_ExigeSenhaMultiplo}
    
        Valida solicitacao de senha do usuário
    
    END

    IF    ${Aviso_ProdutoSemEstoque}
        
        Aviso produto sem estoque 

    END

    IF    ${Parametro_Controla_Entrega}

        Valida controle de entrega

    END

    Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}

    Set Test Variable    ${COD_PRODUTO}    ${codProduto[0][0]} 

    Set Test Variable    ${QUANTIDADE_PRODUTOS}    1

E acesso a aba pagamentos

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_ALTO}

    ${FORMA_PADRAO}    Valida Configuracoes Venda    ${DBName}

    Set Test Variable    ${FORMA_PADRAO}

    Set Test Variable    ${DESCONTO_FORMA}    ${FORMA_PADRAO[1]}

    IF     ${DESCONTO_FORMA} > 0

        Valida tela de liberação de desconto 

    END

Então finalizo a venda

    Verifica vendedor com senha

    Calcula valor final da venda

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.D
    Sleep    ${SLEEP_BAIXO}

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
        
        Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}
        Sleep    ${SLEEP_MEDIO}

    END

    #Deixado aqui por que pode ser QUE quando a forma for a vista, apareça antes das duplicatas, mas ainda é necessário validar
    IF    ${VendedorPossuiSenha}
        
        Valida solicitacao de senha do usuário

    END

    IF    '${FORMA_PADRAO[0]}' == 'À VISTA'

        IF     ${Parametro_BaixaCentralizada}
            
            IF    ${Parametro_BaixaAutomatico}

                IF     ${Caixa_Baixas_Automatica} == ${False}
                
                    Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
                    Input Text    ${EMPTY}    ${VALOR_FINAL_VENDA}
                    Sleep    ${SLEEP_MEDIO}
                    Press Combination    KEY.ALT     Key.C
                
                END    
            
            END

        ELSE
                
            Wait Until Screen Contain    ${TELA_RECB_DUPLICATAS}    ${TEMPO_TELA}
            Input Text    ${EMPTY}    ${VALOR_FINAL_VENDA}
            Sleep    ${SLEEP_MEDIO}
            Press Combination    KEY.ALT     Key.C

        END
        
        Wait Until Screen Contain    ${TELA_VENDAS}     ${TEMPO_TELA}
        Sleep    ${SLEEP_MEDIO}

        IF    ${Parametro_ImprimeNFCeDireto}  
        
            Faturando a NFC-e

        END

    END

    IF    ${Parametro_ImprimeVendaDireto}
        
        Wait Until Screen Contain    ${TELA_IMPRESSAO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.S

    END

    IF     ${Parametro_Imprime_OrdemEntrega}

        Valida impressão de ordem de entrega

    END

    IF    ${Parametro_ImprimeDuplicataVenda}
        
        Valida Impressao de duplicatas

    END

    #--------------------------------------------------#
    #--------------------------------------------------#
    #---------Validar Emissão de Promissórioa----------#
    #--------------------------------------------------#
    #--------------------------------------------------#

Verifica parametros que interferem na venda 
    
    ${Lista_de_pametros}    Valida Pametros Com Aviso    ${DBName}
    ${Config_Empresas}    Valida Config Empresa    ${DBName}

    #Adiciona no campo Vendedor o usuário logado e o no campo cliente o CONSUMIDOR (CÓDIGO 1)
    ${Parametro_VendaRapida} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Venda_Rapida 
    ${Parametro_IncluiDireto} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    IncluiDireto
    ${Aviso_ProdutoSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Aviso_Sem_Est
    ${Parametro_IndicacaoVenda} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    IndicacaoVenda
    ${Parametro_VendeSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Vende_Sem_Estoque
    ${Parametro_ControlaCredito} =      Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ControlaCreditoClientes
    ${Parametro_ExibeVendasAnteriores} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    PVexibeAnteriores
    ${Parametro_ExigeSenhaMultiplo} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Senha_supervisor_multiplo
    ${Parametro_Exibe_Foto_Cliente} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ExibeFotoCli
    ${Parametro_Controla_Entrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ControlaEntregaPrevista
    ${Parametro_Local_Negociacao} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    LocalNegociacao
    ${Parametro_Imprime_OrdemEntrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirOrdemEntrega

    ${Parametro_ImprimeNFCeDireto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Venda_ImprimeCupom
    ${Parametro_ImprimeVendaDireto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirVenda_FinalizarVenda
    ${Parametro_ImprimeDuplicataVenda} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirDup_FinalizarVenda
    ${Parametro_BaixaCentralizada} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaCentralizada
    ${Parametro_BaixaAutomatico} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaAutomatico
    ${Caixa_Baixas_Automatica} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    CodigoCX

    IF    ${Parametro_VendaRapida}
            
        Log To Console    \nParametro Venda_Rapida interfere diretamente na venda\nTeste sendo finalizado
        Terminate Process

    END

    Set Test Variable    ${Parametro_ControlaCredito}

    Set Test Variable    ${Parametro_IndicacaoVenda}

    Set Test Variable    ${Parametro_IncluiDireto}

    Set Test Variable    ${Aviso_ProdutoSemEstoque}
   
    Set Test Variable    ${Parametro_VendeSemEstoque}

    Set Test Variable    ${Parametro_ImprimeNFCeDireto}

    Set Test Variable    ${Parametro_IndicacaoVenda}

    Set Test Variable    ${Parametro_ImprimeVendaDireto}

    Set Test Variable    ${Parametro_ImprimeDuplicataVenda}

    Set Test Variable    ${Parametro_ExibeVendasAnteriores}

    Set Test Variable    ${Parametro_ExigeSenhaMultiplo}

    Set Test Variable    ${Parametro_BaixaCentralizada}

    Set Test Variable    ${Parametro_BaixaAutomatico}

    Set Test Variable    ${Caixa_Baixas_Automatica}

    Set Test Variable    ${Parametro_Exibe_Foto_Cliente}

    Set Test Variable    ${Parametro_Controla_Entrega}

    Set Test Variable    ${Parametro_Local_Negociacao}

    Set Test Variable    ${Parametro_Imprime_OrdemEntrega}

Verifica avisos presentes ao incluir cliente
    
    ${Lista_de_avisos}    Valida Pametros Com Aviso    ${DBName}

    ${Aviso_vendedor_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    AvisoVendedor
    ${Aviso_infoCredito_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    Aviso_Info_Financeiro
    ${Aviso_ExigeSenhaOutroVendedor_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    ExigeSenhaMudarVendedorVenda

    ${Observacao_existe} =    Run Keyword And Return Status     Check If Exists In Database    SELECT OBSERVACAO FROM clientes WHERE Codigo = ${Codigo_Cliente}  AND OBSERVACAO IS NOT NULL;
    ${Condicional_existe} =    Run Keyword And Return Status     Check If Exists In Database    SELECT * FROM condicionais WHERE CodigoCliente = ${Codigo_Cliente} AND `Status` IN ('f','e','a');

    IF    ${Observacao_existe}  
            
        Valida observaco cliente

    END

    IF     ${Parametro_Exibe_Foto_Cliente}

        Valida exibe cliente

    END

    IF    ${Aviso_ExigeSenhaOutroVendedor_existe}  
        
        Valida aviso exige senha para outro vendedor

    END

    IF    ${Aviso_vendedor_existe}  

        Valida aviso cliente outro vendedor

    END

    IF    ${Condicional_existe}  
        
        Valida condicional aberto

    END

    IF    ${Aviso_infoCredito_existe}  
        
        Valida informações de crédito

    END

    IF     ${Parametro_ExibeVendasAnteriores}

        Valida vendas anteriores 

    END

Valida aviso exige senha para outro vendedor

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}

    IF    ${MSG}  
        
        Press Special Key    ENTER

        Wait Until Screen Contain    ${TELA_SENHA_SUPERVISOR}    ${SLEEP_ALTO}
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    ENTER

        Sleep    ${SLEEP_MEDIO}

    END

Valida aviso cliente outro vendedor

    Sleep    ${SLEEP_BAIXO}
    ${MSG}    Exists    ${AVISO_CLIENTE_OUTRO_VE}

    IF    ${MSG}  

        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Valida informações de crédito 

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${TELA_INFO_CRÉDITOS}

    IF    ${MSG}  

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida condicional aberto 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_CONDICIONAL_ABERTO}

    IF    ${MSG}  

        Press Special Key    LEFT
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}

    END

Valida observaco cliente

    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${ALERTA_CLIENTE}

    IF    ${MSG}  
    
        Press Combination    KEY.ALT     Key.O
        Sleep    ${SLEEP_MEDIO}

    END

Aviso produto sem estoque 
    
    Sleep    ${SLEEP_MEDIO}
    ${MSG}    Exists    ${AVISO_SEM_ESTOQUE}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.S
        Sleep    ${SLEEP_MEDIO}

    END

Faturando a NFC-e

    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    DOWN
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.F 
    Sleep    ${SLEEP_MEDIO}

    Valida ncm invalido ao faturar nota 

    Press Special Key    LEFT
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_ALTO}

    Wait Until Screen Not Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}

    ${Consulta}    Query    SELECT NumeroNF FROM vendas WHERE Codigo = ${COD_VENDA}
    Sleep    ${SLEEP_BAIXO}
    Should Not Be Equal    ${Consulta[0][0]}    ${null}

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

Valida indicacao Venda 

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_INDICACAO_VENDA}

    IF    ${MSG}  
        
        Press Special Key    ESC 
        Sleep    ${SLEEP_MEDIO}

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

Valida vendas anteriores 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_VENDAS_ANTERIORES}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.F
        Sleep    ${SLEEP_MEDIO}

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

Valida solicitacao de senha do usuário

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_SOLICITACAO_SENHA_USUARIO}

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

    ${VendedorComSenha} =     Run Keyword And Return Status     Check If Exists In Database    SELECT SenhaVendedor FROM clientes WHERE Codigo = 15378 AND SenhaVendedor IS NOT NULL

    IF    ${VendedorComSenha}
        
        Log To Console    \nConsiderou que tem senha
        Execute Sql String    UPDATE clientes SET SenhaVendedor = 'W' WHERE Codigo = ${Codigo_Vendedor}
        Set Test Variable    ${VendedorPossuiSenha}    ${True}

    ELSE

        Log To Console    \nConsiderou como sem senha
        Set Test Variable    ${VendedorPossuiSenha}    ${False}

    END

Valida exibe cliente

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_EXIBE_CLIENTE}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.F
        Sleep    ${SLEEP_MEDIO}

    END

Valida controle de entrega 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_SELECIONA_TIPO_ENTREGA}

    IF    ${MSG}  
        
        Input Text    ${EMPTY}    S
        Sleep    ${SLEEP_BAIXO}
        Press Combination    KEY.ALT     Key.G
        Sleep    ${SLEEP_MEDIO}

    END

Valida local da negociação

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${MODAL_LOCAL_NEGOCIACAO} 

    IF    ${MSG}  
        
        Press Special Key    TAB 
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    DOWN
        SikuliLibrary.Click    ${BT_CONFIRMA_CANAL_NEGOCIACAO}

    END

Valida impressão de ordem de entrega 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRIMIR_ORDEM_ENTREGA}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END