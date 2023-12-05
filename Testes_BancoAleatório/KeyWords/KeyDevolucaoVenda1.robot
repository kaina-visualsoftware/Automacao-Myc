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
Resource    ./keyVendas1.robot

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
${TELA_DEVOLUÇÕES}                       tela_Devolucoes.png
${TELA_DEVOLUÇÕES_AVULSA_ADICIONAR}      tela_DevolucaoAvulsaAdicionar.png
${FORMA_RECEBIMENTO_OUTROS}              Outros...

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que abro a tela de Devolução de vendas/os 

    ${FORMA_PADRAO_DEV}    Valida Forma Parcelamento    Devolução

    Verifica parametros que interferem na venda

    Press Special Key    F6
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Set Test Variable    ${FORMA_PADRAO_DEV}

Quando adiciono uma nova devolução 

    Press Combination    KEY.ALT     Key.A

    IF     ${Parametro_DevolucaoAvulsa}

        Adicionando Devolução avulsa 

    END   

Adicionando Devolução avulsa 
    
    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES_AVULSA_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

E insiro os dados do cabeçalho - vendedor, venda|cliente 
    
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    IF     ${Parametro_DevolucaoAvulsa}

        SikuliLibrary.Double Click    ${INPUT_CODIGO_CLIENTE_DEVOLUCAO}
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Codigo_Cliente}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

        Verifica se condicional existe(${Codigo_Cliente})
    
    ELSE 
        
       
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
        Press Combination    KEY.ALT     Key.I
        Wait Until Screen Contain    ${ROW_PROD_INCLUSO}    ${TEMPO_TELA}
        Sleep    ${SLEEP_BAIXO}
    
    ELSE

        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${QUANTIDADE_PRODUTOS}
        Sleep    ${SLEEP_BAIXO}
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}

    END 

E vou para a aba de pagamentos
    
    Press Combination    KEY.ALT     Key.m
    Sleep    ${SLEEP_MEDIO}

    ${EntradaIgualA_Outros_dev} =     Run Keyword And Return Status    Should Contain    ${FORMA_PADRAO_DEV}    ${FORMA_RECEBIMENTO_OUTROS}

    Set Test Variable    ${EntradaIgualA_Outros_dev}

Então finalizo a devolução
    
    IF     ${Parametro_DevolucaoAvulsa}

        Press Combination    KEY.ALT     Key.e 

    ELSE 

        Press Combination    KEY.ALT     Key.b 

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
    
    #É true por que só não imprime ao finalizar caso o botão imprimir esteja bloqueado
    Valida impressao direta de venda(${True})

    Wait Until Screen Contain    ${TELA_DEVOLUÇÕES}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}