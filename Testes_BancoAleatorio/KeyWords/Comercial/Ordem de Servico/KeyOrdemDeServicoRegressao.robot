*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary

Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot


*** Variables ***
${CPF_CLIENTE}    NONE
${CODIGO_OS_CRIADA}    NONE


*** Keywords ***

Dado que acesso a tela de ordens de serviços para regressão
    KeyOrdemDeSevico1.Dado que acesso a tela de ordens de serviços

Quando inicio uma nova ordem de serviço
    KeyOrdemDeSevico1.Quando pressiono o atalho de adicionar

E informo o vendedor
    ${codVendedor}=    Seleciona vendedor
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}
    Valida vendedor padrao
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Press Special Key    TAB

E informo a tabela de preço
    Verifica seleção de tabela de preço(OrdemDeServico)

E informo o cliente pelo CPF
    ${CPF}=    Obter CPF de cliente ativo no banco
    Set Test Variable    ${CPF_CLIENTE}    ${CPF}
    Press Special Key    TAB
    Input Text    ${EMPTY}    ${CPF}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}
    Fechar tela de informações de crédito

Fechar tela de informações de crédito
    ${tela_credito}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_INFO_CRÉDITOS}    3
    IF    ${tela_credito}
        Press Special Key    ESC
        Sleep    ${SLEEP_MEDIO}
    END

E acesso a aba de pagamentos
    KeyOrdemDeSevico1.E acesso a aba pagamentos
    validacaoAviso.Valida cliente com vales compra disponíveis

Então gravo a ordem de serviço
    KeyOrdemDeSevico1.Então gravo a ordem de serviço
    Sleep    ${SLEEP_ALTO}
    ${CODIGO_OS_CRIADA}=    Pegar código da última OS criada do banco
    Set Test Variable    ${CODIGO_OS_CRIADA}    ${CODIGO_OS_CRIADA}

Então a ordem de serviço deve estar salva no banco com os dados corretos
    Validar OS criada com CPF no banco


Obter CPF de cliente ativo no banco
    ${resultado}=    Query    SELECT c.CPF FROM clientes c WHERE c.CPF IS NOT NULL AND c.CPF != '' AND c.Ativo = -1 ORDER BY RAND() LIMIT 1;
    Should Not Be Empty    ${resultado}
    ${CPF_COM_MASCARA}=    Set Variable    ${resultado[0][0]}
    ${CPF_SEM_MASCARA}=    Evaluate    "${CPF_COM_MASCARA}".replace("-", "").replace(".", "").replace(",", "")
    Set Test Variable    ${CPF_CLIENTE}    ${CPF_COM_MASCARA}
    Log    CPF do cliente: ${CPF_COM_MASCARA} (sem máscara: ${CPF_SEM_MASCARA})
    RETURN    ${CPF_SEM_MASCARA}

Pegar código da última OS criada do banco
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Tipo = 'OS' ORDER BY v.Codigo DESC LIMIT 1;
    Should Not Be Empty    ${resultado}
    RETURN    ${resultado[0][0]}

Validar OS criada com CPF no banco
    ${resultado}=    Query    SELECT v.Codigo, v.CodigoVendedor, v.Tabela, v.CodigoCliente, v.RazaoCliente, v.Pres_CPF FROM vendas v WHERE v.Codigo = ${CODIGO_OS_CRIADA} AND v.Tipo = 'OS' AND v.Cancelada IS NULL;
    Should Not Be Empty    ${resultado}
    ${CPF_BANCO}=    Set Variable    ${resultado[0][5]}
    ${CPF_BANCO_SEM_MASCARA}=    Evaluate    "${CPF_BANCO}".replace("-", "").replace(".", "").replace(",", "")
    ${CPF_CLIENTE_SEM_MASCARA}=    Evaluate    "${CPF_CLIENTE}".replace("-", "").replace(".", "").replace(",", "")
    Should Be Equal As Strings    ${CPF_BANCO_SEM_MASCARA}    ${CPF_CLIENTE_SEM_MASCARA}
    Log    OS validada com sucesso! Código: ${resultado[0][0]}, Cliente: ${resultado[0][4]}, CPF: ${CPF_BANCO}