*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary

Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Emissão/Carregamento/Venda/KeyCarregamentoVenda.robot


*** Variables ***
${CPF_CLIENTE}    NONE
${CODIGO_OS_CRIADA}    NONE
${CODIGO_ULTIMA_OS_ANTES}    NONE

${AVISO_CLIENTE_NAO_CADASTRADO_CPF}   aviso_ClienteNaoCadastradoCPF.png
${BT_SIM}                                            bt_Sim.png

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

E informo cliente com CPF não existente
    ${CPF}=    Gerar CPF válido não cadastrado no banco
    Set Test Variable    ${CPF_CLIENTE}    ${CPF}
    Press Special Key    TAB
    Input Text    ${EMPTY}    ${CPF}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}
    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO_CPF}    3
    IF    ${AVISO}
        Log    Aviso de CPF não cadastrado exibido com sucesso
    ELSE
        Fail    Aviso de CPF não cadastrado não foi exibido
    END
    SikuliLibrary.Click    ${BT_NAO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ESC
    Sleep    ${SLEEP_MEDIO}
    SikuliLibrary.Click    ${BT_SIM}
    Sleep    ${SLEEP_MEDIO}

Então o sistema exibe aviso de CPF não cadastrado
    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO_CPF}    3
    IF    ${AVISO}
        Log    Aviso de CPF não cadastrado exibido com sucesso
    ELSE
        Fail    Aviso de CPF não cadastrado não foi exibido
    END

Clicar no botão Não
    SikuliLibrary.Click    ${BT_NAO}

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

Gerar CPF válido não cadastrado no banco
    ${encontrado}=    Set Variable    ${TRUE}
    FOR    ${I}    IN RANGE    10
        ${CPF_GERADO}=    Evaluate    random.randint(100000000, 999999999)
        ${CPF_STR}=    Convert To String    ${CPF_GERADO}
        ${D1}=    Evaluate    int(${CPF_STR}[0])
        ${D2}=    Evaluate    int(${CPF_STR}[1])
        ${D3}=    Evaluate    int(${CPF_STR}[2])
        ${D4}=    Evaluate    int(${CPF_STR}[3])
        ${D5}=    Evaluate    int(${CPF_STR}[4])
        ${D6}=    Evaluate    int(${CPF_STR}[5])
        ${D7}=    Evaluate    int(${CPF_STR}[6])
        ${D8}=    Evaluate    int(${CPF_STR}[7])
        ${D9}=    Evaluate    int(${CPF_STR}[8])
        ${SOMA1}=    Evaluate    ${D1}*10 + ${D2}*9 + ${D3}*8 + ${D4}*7 + ${D5}*6 + ${D6}*5 + ${D7}*4 + ${D8}*3 + ${D9}*2
        ${RESTO1}=    Evaluate    ${SOMA1} % 11
        ${DIGITO1}=    Evaluate    0 if ${RESTO1} < 2 else 11 - ${RESTO1}
        ${SOMA2}=    Evaluate    ${D1}*11 + ${D2}*10 + ${D3}*9 + ${D4}*8 + ${D5}*7 + ${D6}*6 + ${D7}*5 + ${D8}*4 + ${D9}*3 + ${DIGITO1}*2
        ${RESTO2}=    Evaluate    ${SOMA2} % 11
        ${DIGITO2}=    Evaluate    0 if ${RESTO2} < 2 else 11 - ${RESTO2}
        ${CPF_COMPLETO}=    Set Variable    ${CPF_GERADO}${DIGITO1}${DIGITO2}
        ${resultado}=    Query    SELECT c.CPF FROM clientes c WHERE c.CPF LIKE '%${CPF_COMPLETO}%' LIMIT 1;
        ${tamanho}=    Get Length    ${resultado}
        IF    ${tamanho} == 0
            ${encontrado}=    Set Variable    ${FALSE}
            BREAK
        END
    END
    Should Not Be Equal    ${encontrado}    ${TRUE}    msg=Não foi possível encontrar um CPF não cadastrado após 10 tentativas
    Log    CPF gerado não cadastrado: ${CPF_COMPLETO}
    RETURN    ${CPF_COMPLETO}

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

Dado que gravo o código da última OS existente
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Tipo = 'OS' ORDER BY v.Codigo DESC LIMIT 1;
    ${existe}=    Run Keyword And Return Status    Should Not Be Empty    ${resultado}
    IF    ${existe}
        Set Test Variable    ${CODIGO_ULTIMA_OS_ANTES}    ${resultado[0][0]}
        Log    Código da última OS antes do teste: ${CODIGO_ULTIMA_OS_ANTES}
    ELSE
        Set Test Variable    ${CODIGO_ULTIMA_OS_ANTES}    0
        Log    Nenhuma OS encontrada antes do teste
    END

Então nenhuma OS deve ter sido persistida no banco
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Tipo = 'OS' ORDER BY v.Codigo DESC LIMIT 1;
    ${existe}=    Run Keyword And Return Status    Should Not Be Empty    ${resultado}
    IF    ${existe}
        ${CODIGO_DEPOIS}=    Set Variable    ${resultado[0][0]}
        Log    Código da última OS depois do teste: ${CODIGO_DEPOIS}
        Should Be Equal As Integers    ${CODIGO_ULTIMA_OS_ANTES}    ${CODIGO_DEPOIS}
        Log    Nenhuma OS foi persistida no banco - teste OK
    ELSE
        Should Be Equal As Integers    ${CODIGO_ULTIMA_OS_ANTES}    0
        Log    Nenhuma OS foi persistida no banco - teste OK
    END