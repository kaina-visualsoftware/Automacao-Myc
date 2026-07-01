*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary

Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Comercial/Vendas/keyVendas1.robot


*** Variables ***
${CPF_CLIENTE}                         NONE
${CNPJ_CLIENTE}                        NONE
${CODIGO_VENDA_CRIADA}                 NONE
${CODIGO_CLIENTE}                      NONE
${CODIGO_VENDEDOR}                      NONE

${AVISO_CLIENTE_NAO_CADASTRADO_CPF}   aviso_ClienteNaoCadastradoCPF.png
${AVISO_CLIENTE_NAO_CADASTRADO_CNPJ}  aviso_ClienteNaoCadastradoCNPJ.png

${TELA_VENDAS_BALCAO}                  tela_VendasDeBalcao.png
${TELA_ADICIONAR_VENDA}               tela_VendasDeBalcao.png


*** Keywords ***
Ler imagens iniciais
    Add Image Path    ${EXECDIR}/Testes_BancoAleatorio/images

Dado que acesso a tela de vendas de balcao para revisao
    Press Special Key    F2
    Wait Until Screen Contain    ${TELA_VENDAS_BALCAO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

Quando inicio uma nova venda
    Press Combination    KEY.ALT    KEY.A
    Wait Until Screen Contain    ${TELA_ADICIONAR_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    # Salva o codigo da ultima venda antes de iniciar
    ${consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;
    Set Test Variable    ${CODIGO_VENDA_CRIADA}    ${consulta[0][0]}

E informo o vendedor
    ${codVendedor}=    Seleciona vendedor
    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}
    Valida vendedor padrao
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Press Special Key    TAB

E informo o cliente pelo CPF
    ${CPF_COM_MASCARA}=    Obter CPF de cliente ativo no banco

    ${CPF_SEM_MASCARA}=    Evaluate    "${CPF_COM_MASCARA}".replace("-", "").replace(".", "").replace(",", "")

    Set Suite Variable    ${CPF_CLIENTE}    ${CPF_COM_MASCARA}

    Should Not Be Empty    ${CPF_COM_MASCARA}    msg=CPF retornou vazio

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CPF_SEM_MASCARA}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.CPF = '${CPF_COM_MASCARA}' AND c.Ativo = -1 LIMIT 1;

    Set Test Variable    ${Codigo_Cliente}    ${resultado[0][0]}

    Sleep    ${SLEEP_BAIXO}
    validacaoAviso.Valida informações de crédito

E saio da tela(Vendas)
    Press Combination    KEY.ALT    KEY.r
    Sleep    ${SLEEP_MEDIO}
    Wait Until Screen Contain    ${TELA_VENDAS_BALCAO}    ${TEMPO_TELA}

Então a venda com cliente CPF deve estar salva no banco
    # Valida que a venda foi criada
    ${venda_info}    Query    SELECT v.Codigo, v.CodigoCliente, v.CPFCNPJ, v.Tipo FROM vendas v WHERE v.Codigo = ${CODIGO_VENDA_CRIADA}

    Should Not Be Empty    ${venda_info}    msg=Venda nao encontrada no banco

    # Valida que o cliente foi associado corretamente
    ${cliente_venda}    Query    SELECT v.CodigoCliente, c.CPF FROM vendas v INNER JOIN clientes c ON c.Codigo = v.CodigoCliente WHERE v.Codigo = ${CODIGO_VENDA_CRIADA} AND c.CPF = '${CPF_CLIENTE}'

    Should Not Be Empty    ${cliente_venda}
    ...    msg=Cliente com CPF ${CPF_CLIENTE} nao encontrado na venda ${CODIGO_VENDA_CRIADA}

    Log    Venda ${CODIGO_VENDA_CRIADA} validada com sucesso - Cliente CPF: ${CPF_CLIENTE}


# ====================================================================
# HELPERS
# ====================================================================

Obter CPF de cliente ativo no banco
    ${resultado}=    Query    SELECT c.CPF FROM clientes c WHERE c.CPF IS NOT NULL AND c.CPF != '' AND c.Ativo = -1 ORDER BY RAND() LIMIT 1;

    Should Not Be Empty    ${resultado}

    ${CPF_COM_MASCARA}=    Set Variable    ${resultado[0][0]}

    Set Suite Variable    ${CPF_CLIENTE}    ${CPF_COM_MASCARA}

    Log    CPF do cliente: ${CPF_COM_MASCARA}

    RETURN    ${CPF_COM_MASCARA}