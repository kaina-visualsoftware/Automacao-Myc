*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    ../libs/validaParametros.py
Library    Process

*** Variables ***
#Sleep's    
${SLEEP_BAIXO}                           0.3
${SLEEP_MEDIO}                           1.5
${SLEEP_ALTO}                            3
${TEMPO_TELA}                            20
#Imagens Tela
${AVISO_CLIENTE_OUTRO_VE}                aviso_clienteOutroVendedor.png  
${TELA_INFO_CRÉDITOS}                    tela_InfoCreditos.png 
${AVISO_EXIGE_SENHA_OUTRO_VENDEDOR}      aviso_ExigeSenhaVendedorDiferente.png
${AVISO_CONDICIONAL_ABERTO}              aviso_CondicionalAbertoVenda.png
${AVISO_CONDICIONAL_ABERTO_COND}         aviso_CondicionalAberto.png
${ALERTA_CLIENTE}                        alertaCliente.png
${TELA_SENHA_SUPERVISOR}                 tela_SolicitaSenha.png
${TELA_EXIBE_CLIENTE}                    tela_exibeCliente.png
${TELA_SELECIONA_TABELA_PRECO}           tela_TabelasPreco.png
${TELA_VENDAS_ANTERIORES}                tela_ExibeAnteriores.png
${TELA_INDICACAO_VENDA}                  tela_QuemIndicou.png
${TELA_LIBERAÇÃO_DESCONTO_SENHA}         tela_liberacaoDesconto.png
${TELA_VENCIMENTO_FIM_DE_SEMANA}         tela_VencimentoFimDeSemana.png
${BT_NÃO}                                bt_Nao.png
${TELA_IMPRIMIR_ORDEM_ENTREGA}           tela_ImprimirOrdemEntrega.png
${TELA_RECIBO_ENTRADA}                   tela_ReciboEntrada.png 
${TELA_CONTRATO_VENDA}                   tela_ContratoVenda.png
${TELA_EMISSAO_PROMISSÓRIA}              tela_EmisssaoPromissoria.png 
${TELA_IMPRESSAO_BOLETO}                 tela_impressaoBoleto.png
${TELA_IMPRESSAO_DUPLICATAS}             tela_ImpressaoDuplicatas.png
${TELA_EMISSAO_NFC}                      tela_EmissaoNFC.png 

***Keywords***
Verifica se condicional existe(${Codigo_Cliente})

    ${Condicional_existe} =    Run Keyword And Return Status     Check If Exists In Database    SELECT * FROM condicionais WHERE CodigoCliente = ${Codigo_Cliente} AND `Status` IN ('f','e','a');
    
    IF    ${Condicional_existe}  
        
        Valida condicional aberto

    END

Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})
    
    ${Lista_de_avisos}    Valida Pametros Config

    ${Aviso_vendedor_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    AvisoVendedor
    ${Aviso_infoCredito_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    Aviso_Info_Financeiro
    ${Aviso_ExigeSenhaOutroVendedor_existe} =     Run Keyword And Return Status    Should Contain    ${Lista_de_avisos}    ExigeSenhaMudarVendedorVenda

    ${Observacao_existe} =    Run Keyword And Return Status     Check If Exists In Database    SELECT OBSERVACAO FROM clientes WHERE Codigo = ${Codigo_Cliente}  AND OBSERVACAO IS NOT NULL;

    Set Test Variable    ${Aviso_vendedor_existe}

    Set Test Variable    ${Observacao_existe}

    IF    ${Observacao_existe}  
            
        Valida observaco cliente

    END

    IF    ${Aviso_ExigeSenhaOutroVendedor_existe}  
        
        Valida aviso exige senha para outro vendedor

    END

    IF    ${Aviso_vendedor_existe}  

        Valida aviso cliente outro vendedor

    END

    Verifica se condicional existe(${Codigo_Cliente})

    IF    ${Aviso_infoCredito_existe}  
        
        Valida informações de crédito

    END

    IF     ${Parametro_ExibeVendasAnteriores}

        Valida vendas anteriores 

    END

    IF     ${Parametro_Exibe_Foto_Cliente}

        Valida exibe cliente

    END

Verifica parametros que interferem na venda
    
    ${Lista_de_pametros}    Valida Pametros Config
    ${Config_Empresas}    Valida Config Empresa

    #Adiciona no campo Vendedor o usuário logado e o no campo cliente o CONSUMIDOR (CÓDIGO 1)
    ${Parametro_VendaRapida} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Venda_Rapida 
    ${Parametro_IncluiDireto} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    IncluiDireto
    ${Aviso_ProdutoSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Aviso_Sem_Est
    ${Parametro_IndicacaoVenda} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    IndicacaoVenda
    ${Parametro_VendeSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Vende_Sem_Estoque
    ${Parametro_ControlaCredito} =      Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ControlaCreditoClientes
    ${Parametro_Controla_Entrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ControlaEntregaPrevista
    ${Parametro_Local_Negociacao} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    LocalNegociacao
    ${Parametro_ExigeSenhaMultiplo} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Senha_supervisor_multiplo
    ${Parametro_Exibe_Foto_Cliente} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ExibeFotoCli
    ${Parametro_Imprime_OrdemEntrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirOrdemEntrega
    ${Parametro_ExibeVendasAnteriores} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    PVexibeAnteriores
    ${Parametro_Permite_Varias_Tabelas} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    PermiteVariasTabelas
    ${Parametro_Impre_Ordem_de_Entrega} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirOrdemEntrega
    ${Parametro_Suprime_Objetos_OS_Orcamento} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    SuprimirOS
    ${Parametro_Desabilita_Servico_Orcamento} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Orc_DesabilitaServico
    ${Parametro_Seleciona_Funcionario_Comissao_Servico} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    SelecionaFunc_OS
    ${Parametro_Fatura_OS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    FaturarOS
    ${Parametro_Imprime_Carne_OS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirCarneOS
    ${Parametro_Imprime_OS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimirOS
    ${Parametro_VendeSemEstoqueCondicional} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Vende_Sem_Estoque_Condicional
    ${Parametro_ImprimeCondicional} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ImprimiCondicional
    ${Parametro_VendaSemEstoqueOrdemDeServico} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    RealizaVendaSemEstoque_OS
    ${Parametro_DevolucaoAvulsa} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    DevolucaoAvulsa
    ${Parametro_DevolucaoExigeOBS} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    ExigeObsTroca
    ${Parametro_DevolucaoPermiteAberta} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    Dev_PermiteAberta
    ${Parametro_RealizaPreVendaSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    RealizaVendaSemEstoque_PreVenda
    ${Parametro_RealizaVendaSemEstoque} =     Run Keyword And Return Status    Should Contain    ${Lista_de_pametros}    RealizaVendaSemEstoque_Venda
    
    ${Parametro_ImprimeNFCeDireto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Venda_ImprimeCupom
    ${Parametro_ImprimeVendaDireto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirVenda_FinalizarVenda
    ${Parametro_ImprimeDuplicataVenda} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirDup_FinalizarVenda
    ${Parametro_BaixaCentralizada} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaCentralizada
    ${Parametro_BaixaAutomatico} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    BaixaAutomatico
    ${Caixa_Baixas_Automatica} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    CodigoCX
    ${Parametro_Imprime_Entrada} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImpRecEnt_FinalizarVenda
    ${Parametro_Imprime_Contrato_Venda} =    Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirContrato_FinalizarVenda
    ${Parametro_Imprime_Promissoria} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImpPromissoria_FinalizarVenda
    ${Parametro_Imprime_Boleto} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    ImprimirBol_FinalizarVenda
    ${Parametro_ValeCompra_Dev_Menor0} =     Run Keyword And Return Status    Should Contain    ${Config_Empresas}    Dev_Ativa_Vale

    IF    ${Parametro_VendaRapida}
            
        Log To Console    \nParametro Venda_Rapida interfere diretamente na venda\nTeste sendo finalizado
        Terminate Process

    END

    #Sim, essa redundância inútil existe no MyCommerce, em cada tela é validado se primeiro o Parametro de venda sem estoque está marcado
    #Para depois ver se o parametro especifico da tela está marcado para ai sim ver se vai ser incluido ou não.

    IF    ${Parametro_VendeSemEstoque} == ${False}
        
        Log To Console     Parametro de vende sem estoque é falso, logo todos os outros serão falsos

        Set Test Variable    ${Parametro_RealizaPreVendaSemEstoque}    ${False}

        Set Test Variable    ${Parametro_RealizaVendaSemEstoque}    ${False}

        Set Test Variable    ${Parametro_VendaSemEstoqueOrdemDeServico}    ${False}
    
    ELSE

        Set Test Variable    ${Parametro_RealizaPreVendaSemEstoque}

        Set Test Variable    ${Parametro_RealizaVendaSemEstoque}

        Set Test Variable    ${Parametro_VendaSemEstoqueOrdemDeServico}

    END

    Set Test Variable    ${Parametro_DevolucaoPermiteAberta}

    Set Test Variable    ${Parametro_DevolucaoExigeOBS}

    Set Test Variable    ${Parametro_ValeCompra_Dev_Menor0}

    Set Test Variable    ${Parametro_DevolucaoAvulsa}

    Set Test Variable    ${Parametro_Fatura_OS}
    
    Set Test Variable    ${Parametro_Imprime_Carne_OS}

    Set Test Variable    ${Parametro_Imprime_OS}

    Set Test Variable    ${Parametro_Seleciona_Funcionario_Comissao_Servico}

    Set Test Variable    ${Parametro_Suprime_Objetos_OS_Orcamento}

    Set Test Variable    ${Parametro_Desabilita_Servico_Orcamento}

    Set Test Variable    ${Parametro_Imprime_Boleto}

    Set Test Variable    ${Parametro_Imprime_Promissoria}

    Set Test Variable    ${Parametro_Imprime_Contrato_Venda}

    Set Test Variable    ${Parametro_Imprime_Entrada}

    Set Test Variable    ${Parametro_Impre_Ordem_de_Entrega}

    Set Test Variable    ${Parametro_ControlaCredito}

    Set Test Variable    ${Parametro_IndicacaoVenda}

    Set Test Variable    ${Parametro_IncluiDireto}

    Set Test Variable    ${Aviso_ProdutoSemEstoque}

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

    Set Test Variable    ${Parametro_Permite_Varias_Tabelas}

    Set Test Variable    ${Parametro_VendeSemEstoqueCondicional}

    Set Test Variable    ${Parametro_ImprimeCondicional}

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

    ${MSG2}    Exists    ${AVISO_CONDICIONAL_ABERTO_COND}

    IF    ${MSG} or ${MSG2}

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

Valida vendas anteriores 
    
    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_VENDAS_ANTERIORES}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.F
        Sleep    ${SLEEP_MEDIO}

    END

Valida exibe cliente

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_EXIBE_CLIENTE}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.F
        Sleep    ${SLEEP_MEDIO}

    END

Valida tabela de preco

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_SELECIONA_TABELA_PRECO} 

    IF    ${MSG}  
        
        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

Valida indicacao Venda 

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_INDICACAO_VENDA}

    IF    ${MSG}  
        
        Press Special Key    ESC 
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

Valida vencimento fim de semana(${FORMA_PADRAO})

    FOR    ${I}    IN RANGE    ${FORMA_PADRAO[4]}
        
        ${MSG}    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_VENCIMENTO_FIM_DE_SEMANA}    ${SLEEP_MEDIO}

        IF    ${MSG}  

            Press Combination    KEY.ALT     Key.S
            Sleep    ${SLEEP_BAIXO}

        END
        
    END

Valida Impressao de duplicatas 

    Sleep    ${SLEEP_ALTO}
    ${MSG}    Exists    ${TELA_IMPRESSAO_DUPLICATAS}

    IF    ${MSG}  
        
        Press Combination    KEY.ALT     Key.N
        Sleep    ${SLEEP_MEDIO}

    END

Cancelando Faturando a NFC-e

    Sleep    ${SLEEP_MEDIO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_EMISSAO_NFC}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.C

