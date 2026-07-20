*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary

Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Comercial/Vendas/keyVendas1.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Emissão/Carregamento/KeyCarregamento1.robot


*** Variables ***
${CPF_CLIENTE}                         NONE
${CNPJ_CLIENTE}                        NONE
${CODIGO_VENDA_CRIADA}                 NONE
${CODIGO_CLIENTE}                      NONE
${CODIGO_VENDEDOR}                      NONE


*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${EXECDIR}/Testes_BancoAleatorio/images


# ====================================================================
# NAVEGACAO - Reutiliza do keyVendas1.robot
# ====================================================================

Dado que acesso a tela de vendas de balcao para revisao
    keyVendas1.Dado que acesso a tela de vendas de balcão


# ====================================================================
# VENDAS
# ====================================================================

Quando inicio uma nova venda
    keyVendas1.Quando pressiono o atalho de adicionar
    Sleep    ${SLEEP_MEDIO}

    # Salva o codigo da ultima venda antes de iniciar
    ${consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${CODIGO_VENDA_CRIADA}    ${consulta[0][0]}

E informo o vendedor
    ${codVendedor}=    KeyCarregamento1.Seleciona vendedor
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}
    keyVendas1.Valida vendedor padrao
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Press Special Key    TAB

E informo o cliente pelo CPF
    # Busca CPF de cliente ativo no banco
    ${resultado}    Query    SELECT c.CPF FROM clientes c WHERE c.CPF IS NOT NULL AND c.CPF != '' AND c.Ativo = -1 ORDER BY RAND() LIMIT 1;

    Should Not Be Empty    ${resultado}    msg=Nenhum cliente com CPF encontrado

    ${CPF_COM_MASCARA}=    Set Variable    ${resultado[0][0]}
    ${CPF_SEM_MASCARA}=    Evaluate    "${CPF_COM_MASCARA}".replace("-", "").replace(".", "").replace(",", "")

    Set Suite Variable    ${CPF_CLIENTE}    ${CPF_COM_MASCARA}

    Log    CPF do cliente: ${CPF_COM_MASCARA}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CPF_SEM_MASCARA}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    # Obtem o codigo do cliente que foi substituido pelo CPF
    ${cliente_info}    Query    SELECT c.Codigo FROM clientes c WHERE c.CPF = '${CPF_COM_MASCARA}' AND c.Ativo = -1 LIMIT 1;

    Should Not Be Empty    ${cliente_info}    msg=Cliente com CPF ${CPF_COM_MASCARA} nao encontrado

    Set Test Variable    ${Codigo_Cliente}    ${cliente_info[0][0]}

    Log    Cliente encontrado: ${Codigo_Cliente}

    Sleep    ${SLEEP_BAIXO}

    # Reutiliza validacoes do utils e validacaoAviso
    utils.Valida informações de crédito
    validacaoAviso.Valida informações de crédito
    validacaoAviso.Valida cliente com vales compra disponíveis
    validacaoAviso.Verifica avisos presentes ao incluir cliente(${Codigo_Cliente})

E saio da tela(Vendas)
    Press Combination    KEY.ALT    KEY.r
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_VENDAS}    ${TEMPO_TELA}


# ====================================================================
# VALIDACOES
# ====================================================================

Então a venda com cliente CPF deve estar salva no banco
    # Valida que a venda foi criada
    ${venda_info}    Query
    ...    SELECT v.Codigo, v.CodigoCliente, v.CPFCNPJ, v.Tipo FROM vendas v
    ...    WHERE v.Codigo = ${CODIGO_VENDA_CRIADA} AND v.Tipo = 'VB'

    Should Not Be Empty    ${venda_info}    msg=Venda nao encontrada no banco

    # Valida que o cliente foi associado corretamente
    ${cliente_venda}    Query
    ...    SELECT v.CodigoCliente, c.CPF FROM vendas v
    ...    INNER JOIN clientes c ON c.Codigo = v.CodigoCliente
    ...    WHERE v.Codigo = ${CODIGO_VENDA_CRIADA} AND c.CPF = '${CPF_CLIENTE}'

    Should Not Be Empty    ${cliente_venda}
    ...    msg=Cliente com CPF ${CPF_CLIENTE} nao encontrado na venda ${CODIGO_VENDA_CRIADA}

    Log    Venda ${CODIGO_VENDA_CRIADA} validada com sucesso - Cliente CPF: ${CPF_CLIENTE}