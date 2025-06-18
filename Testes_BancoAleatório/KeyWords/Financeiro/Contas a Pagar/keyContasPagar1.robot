*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary 
Library    DatabaseLibrary
Library    DateTime
Library    ../libs/validaParametros.py
Library    ../libs/verificacoesExtras.py
Library    ../libs/estoque.py
Library    OperatingSystem
Variables    ../libs/leituraConfig.py

Resource    ../utils/validacaoAviso.robot
Resource    ../utils/utils.robot
Resource    ../utils/montadorDeCenarios.robot

*** Variables ***
# Repositório de Imagens
${IMAGES}                          ./Testes_BancoAleatório/images

# Conexão com o Banco de Dados
${DBHost}                          ${config.IpServidor}
${DBName}                          ${config.Database}
${DBPass}                          vssql
${DBPort}                          ${config.Porta}
${DBUser}                          root
  
# Sleep's
${SLEEP_BAIXO}                     0.7
${SLEEP_MEDIO}                     1.5
${SLEEP_ALTO}                      3
${TEMPO_TELA}                      20

# Telas
${TELA_CONTAS_A_PAGAR_AVULSA}      tela_CadastroContasAPagar.png
${TELA_CADASTRO_CONTAS_A_PAGAR}    tela_CadastroContasPagar.png

# Botões
${BT_CONTAS_A_PAGAR}               bt_ContasAPagar.png

# Outros
${NomeTerminalExecucao}            ${config.terminal_name}

*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${IMAGES}

Dado que acesso a tela de cadastro avulso de contas a pagar

    Recuperando numero documento

    SikuliLibrary.Click    ${BT_CONTAS_A_PAGAR}
    Wait Until Screen Contain    ${TELA_CONTAS_A_PAGAR_AVULSA}    ${TEMPO_TELA}

E insiro um cliente qualquer
    
    ${Codigo_Cliente}    Seleciona cliente

    Set Test Variable    ${Codigo_Cliente}

    Input Text    ${EMPTY}    ${Codigo_Cliente}

    Press Special Key    TAB

Quando clico em adicionar
    
    Press Combination    KEY.ALT     Key.A    
    Wait Until Screen Contain    ${TELA_CADASTRO_CONTAS_A_PAGAR}    ${TEMPO_TELA}

E insiro as informações necessárias(${Valor_Conta})
    
    ${FORMA_PADRAO[4]}    Evaluate    1

    ${Plano_de_Contas}    Seleciona plano de contas - Débito

    ${Modalidade_de_Cobranca}    Seleciona modalidade de cobrança

    Informando data competência
    Sleep    ${SLEEP_BAIXO}
        
    Input Text    ${EMPTY}    ${CODIGO_OPERACAO_MOV}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}
    
    FOR    ${I}    IN RANGE    2
        
        Input Text    ${EMPTY}    1

        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    Conta a pagar automacao

    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Valida vencimento fim de semana(1)
    
    Input Text    ${EMPTY}    ${Valor_Conta}
    Press Special Key    TAB
    Input Text    ${EMPTY}    ${Plano_de_Contas}
    
    FOR    ${I}    IN RANGE    2
        
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
        
    END

    Input Text    ${EMPTY}    ${Modalidade_de_Cobranca}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    
    Set Test Variable    ${VALOR_FINAL_OPERAÇÃO}    ${Valor_Conta}
    
Então gravo o lançamento de conta a pagar avulsa

    Sleep    ${SLEEP_BAIXO}
    Press Combination    KEY.ALT     Key.G
    Wait Until Screen Not Contain    ${TELA_CADASTRO_CONTAS_A_PAGAR}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT     Key.S

Recuperando numero documento 

    # O número do documento será sempre o número da sequência que está sendo lançada.
    ${Ultima_Sequencia}    Query    SELECT Sequencia FROM contasapagar ORDER BY Sequencia DESC LIMIT 1;

    ${Ultima_Sequencia}    Evaluate    ${Ultima_Sequencia[0][0]} + 1

    Set Test Variable    ${CODIGO_OPERACAO_MOV}    ${Ultima_Sequencia}

Informando data competência

    Press Combination    KEY.SHIFT    KEY.TAB
    Sleep    ${SLEEP_BAIXO}

    Type With Modifiers    H
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}