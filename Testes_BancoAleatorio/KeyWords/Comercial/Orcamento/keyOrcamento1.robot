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

*** Variables ***
# Repositório de Imagens
${IMAGENS}                           ./testes_bancoAleatorio/images

# Conexão com o Banco de Dados
${DBHost}                            ${config.IpServidor}
${DBName}                            ${config.Database}
${DBPass}                            vssql
${DBPort}                            ${config.Porta}
${DBUser}                            root

# Sleep's
${SLEEP_BAIXO}                       0.7
${SLEEP_MEDIO}                       1.5
${SLEEP_ALTO}                        3
${TEMPO_TELA}                        20

# Telas
${TELA_ORCAMENTO}                    tela_Orcamento.png
${TELA_ORC_ADICIONAR}                tela_OrcamentoAdicionar.png
${TELA_VISUALIZA_VENDA}              tela_VisualizaVenda.png
${TELA_CONFIRMAÇÃO_EXCLUSÃO}         tela_exclusaoVenda.png
${MODAL_PERSONALIZACAO_PAGAMENTO}    modal_PersonalizacaoPagamento.png

# Telas Avisos
${AVISO_DESEJA_EXCLUIR}              aviso_DesejaExcluir.png

# Inputs
${INPUT_QUANTIDADE_PRODUTO}          input_QuantidadeProduto.png

# Outros
${ABA_PAGAMENTOS}                    aba_Pagamentos.png

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGENS}

Dado que acesso a tela de orçamentos
    
    ${FORMA_PADRAO}    Valida Configuracoes Venda
    ${FORMA_PRAZO}    Seleciona Forma Prazo

    Verifica parâmetros que interferem na venda

    Type With Modifiers    O    CTRL

    Valida lançamento de orçamento em aberto

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

Quando pressiono o atalho de adicionar

    Press Combination    KEY.ALT     Key.A
    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    IF    ${Parametro_Local_Negociacao} 

        Valida local da negociação

    END

    IF    ${Parametro_IndicacaoVenda}
        
        Valida indicacao Venda

    END

    ${Consulta}    Query    SELECT Codigo FROM orcamentos ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_ORCAMENTO}    ${Consulta[0][0]}

E adiciono vendedor e cliente
    
    utils.Adicionar Vendedor e Cliente(Orcamento)

    validacaoAviso.Verifica avisos presentes ao incluir cliente(${DBName} ${Codigo_Cliente})

Quando insiro um produto normal informando a quantidade(${Quantidade_Produto})

    IF     ${Parametro_RealizaVendaSemEstoque}

        utils.Inserir Produto normal - Permite sem estoque

    ELSE

        utils.Inserir Produto normal - Necessita de estoque

    END

    Informa a quantidade do produto(${Quantidade_Produto})

    utils.Valida parametros após incluir produto

Então gravo o orçamento

    ${FORMA_PACELAMENTO_CLIENTE}    Verifica Forma Parcelamento Cliente    ${Codigo_Cliente}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.M 
    Sleep    ${SLEEP_BAIXO}

    Valida cliente com vales compra disponíveis

    IF    '${FORMA_PACELAMENTO_CLIENTE}' == 'Personalizada'
        
        Wait Until Screen Contain    ${MODAL_PERSONALIZACAO_PAGAMENTO}    ${SLEEP_ALTO}

        FOR    ${I}    IN RANGE    3
            
            Press Special Key    TAB
            Sleep    ${SLEEP_BAIXO}
            
        END

        Press Combination    KEY.ALT     Key.G

    END

    Wait Until Screen Contain    ${ABA_PAGAMENTOS}    ${TEMPO_TELA}

    Press Combination    KEY.ALT     Key.G

    Valida impressao direta de venda(${Parametro_ImprimeVendaDireto})

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Então visualizo o orçamento
    
    Press Combination    KEY.ALT     KEY.U
    Sleep    ${SLEEP_MEDIO}

    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.r
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}

Quando clico em editar

    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT     Key.E
    Sleep    ${SLEEP_BAIXO}

    IF    ${Parametro_IndicacaoVenda}
        
        Valida indicacao Venda

    END

    Wait Until Screen Contain    ${TELA_ORC_ADICIONAR}    ${TEMPO_TELA}
    
    IF    ${Observacao_existe}
            
        Valida observaco cliente

    END

Quando clico em excluir

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.X

    Wait Until Screen Contain    ${AVISO_DESEJA_EXCLUIR}    ${SLEEP_ALTO}
    Press Combination    KEY.ALT     Key.S
    Sleep    ${SLEEP_BAIXO}

Então finalizo a exclusão

    Wait Until Screen Contain    ${TELA_CONFIRMAÇÃO_EXCLUSÃO}    ${TEMPO_TELA}

    Input Text    ${EMPTY}    Exclusao de Venda - Teste Automacao

    Press Special Key    TAB
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    
    Wait Until Screen Contain    ${TELA_ORCAMENTO}    ${TEMPO_TELA}

    Check If Exists In Database    SELECT * FROM orcamentos WHERE Codigo = ${COD_ORCAMENTO} AND `Status` LIKE 'x'

Informa a quantidade do produto(${Quantidade_Produto})

    IF    ${Quantidade_Produto} != 1
        
        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
    
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    ${Quantidade_Produto}

    END

    Press Special Key    TAB

    Set Test Variable    ${Quantidade_Produto}

    Set Test Variable    ${QTDE_BAIXA_PRODUTO}    ${Quantidade_Produto}