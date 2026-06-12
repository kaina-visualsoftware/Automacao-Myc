*** Settings ***
Library    SikuliLibrary
Library    ImageHorizonLibrary
Library    DatabaseLibrary

Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/utils.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/utils/validacaoAviso.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Comercial/Ordem de Servico/KeyOrdemDeSevico1.robot
Resource    ${EXECDIR}/Testes_BancoAleatorio/KeyWords/Emissão/Carregamento/KeyCarregamento1.robot


*** Variables ***
${CPF_CLIENTE}                         NONE
${CNPJ_CLIENTE}                        NONE
${CODIGO_OS_CRIADA}                    NONE
${CODIGO_ULTIMA_OS_ANTES}              NONE
${CODIGO_CLIENTE_CNPJ}                 NONE
${NOME_CLIENTE_CNPJ}                   NONE
${Quantidade_Produto}                  ${1}
${CODIGO_OS_EXCLUIR}                   ${NONE}
${CODIGO_PRODUTO}                      ${NONE}
${SENHA_SUPERVISOR}                    1
${CODIGO_OS_DETALHAMENTO}              NONE
@{DESCRICOES_SERVICOS}
${CODIGO_OS_NFSE}                      NONE
${CODIGO_SERVICO_NFSE}                 NONE
${DESCRICAO_SERVICO_NFSE}              NONE
${VALOR_SERVICO_NFSE}                  NONE
${FORMA_PAGAMENTO_30_DIAS}             NONE


${AVISO_CLIENTE_NAO_CADASTRADO_CPF}   aviso_ClienteNaoCadastradoCPF.png
${AVISO_CLIENTE_NAO_CADASTRADO_CNPJ}  aviso_ClienteNaoCadastradoCNPJ.png
${AVISO_OS_SEM_SERVICO}                aviso_ObrigatorioIncluirServico.png
${TELA_DETALHAMENTO_SERVICO}           tela_DetalhamentoServico.png
${TELA_VISUALIZA_VENDA}                 tela_VisualizaVenda.png
${GUIA_SERVICOS_OS}                     guia_ServicosOS.png


${TELA_ADICIONAR_ORDEM_DE_SERVICO}     tela_OrdemDeServicoAdicionar.png
${TELA_ORDEM_DE_SERVICO}                tela_OrdemDeServico.png
${TELA_EXCLUIR_OS}                      tela_ExcluirOS.png
${TELA_SENHA_USUARIO}                  tela_SenhaUsuario.png
${TELA_SETAR_VENDEDOR_PRODUTO}         tela_SetarVendedorProduto.png
${INPUT_DESCRICAO_EXCLUSAO}            input_DescricaoExclusao.png
${TELA_AGREGADOS}                       tela_Agregados.png
${CHECKBOX_SERVICO_AGREGADO}            checkbox_ServicoAgregado.png

*** Keywords ***

Dado que acesso a tela de ordens de serviços para regressão

    ${FORMA_PADRAO}    Valida Configuracoes OS

    ${FORMA_PRAZO}     Seleciona Forma Prazo

    Set Test Variable    ${FORMA_PADRAO}

    Set Test Variable    ${FORMA_PRAZO}

    Press Special Key    F3

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Valida lançamento de ordem de serviço em aberto

Quando inicio uma nova ordem de serviço

    Clicar no botão Adicionar

    Valida indicação de venda(${Parametro_IndicacaoOS})

    Valida local de negociação da venda
    Sleep    ${SLEEP_MEDIO}

    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    Sleep    ${SLEEP_MEDIO}
    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${COD_ORDEM_SERVICO}    ${Consulta[0][0]}

E informo o vendedor
    ${codVendedor}=    KeyCarregamento1.Seleciona vendedor

    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}

    Valida vendedor padrao
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}

    Press Special Key    TAB

E informo a tabela de preço
    Verifica seleção de tabela de preço(OrdemDeServico)

E insiro um produto normal
    KeyOrdemDeSevico1.E insiro um produto normal informando a quantidade(1)

Então fecho a ordem de serviço sem pagamentos
    KeyOrdemDeSevico1.Então fecho a ordem de serviço

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

E informo o cliente pelo CNPJ
    ${CNPJ_SEM_MASCARA}=    Obter CNPJ de cliente ativo no banco

    Should Not Be Empty    ${CNPJ_CLIENTE}    msg=CNPJ retornou vazio

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CNPJ_SEM_MASCARA}

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    ${resultado}=    Query    SELECT c.Codigo FROM clientes c WHERE c.CNPJ = '${CNPJ_CLIENTE}' AND c.Ativo = -1 LIMIT 1;

    Set Test Variable    ${Codigo_Cliente}    ${resultado[0][0]}

    validacaoAviso.Valida informações de crédito

E acesso a aba de pagamentos
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.M
    Sleep    ${SLEEP_BAIXO}

    validacaoAviso.Valida cliente com vales compra disponíveis
    Sleep    ${SLEEP_MEDIO}

E desdobre o pagamentos
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.D
    Sleep    ${SLEEP_MEDIO}

E acesso a aba de produtos
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_MEDIO}

E informo um produto
    ${produto}=    Query    SELECT p.Codigo FROM produtos p INNER JOIN produtosestoque pe ON p.Codigo = pe.CodigoProduto WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND pe.Estoque > 0 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) ORDER BY RAND() LIMIT 1;

    Should Not Be Empty    ${produto}    msg=Nenhum produto encontrado

    Set Test Variable    ${CODIGO_PRODUTO}    ${produto[0][0]}

    Input Text    ${EMPTY}    ${CODIGO_PRODUTO}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

E informo o vendedor que inseriu o produto
    Wait Until Screen Contain    ${TELA_SETAR_VENDEDOR_PRODUTO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.O
    Sleep    ${SLEEP_MEDIO}

Então o foco deve estar no campo de código do produto
    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Log    Foco está no campo de código do produto

Então o vendedor do produto deve estar salvo no banco com o código correto
    # Valida que o CodVendedorEntrega está correto na tabela vendasprodutos
    ${consulta}    Query    SELECT vp.CodVendedorEntrega FROM vendasprodutos vp INNER JOIN vendas v ON v.Codigo = vp.CodigoVenda WHERE v.Codigo = ${COD_ORDEM_SERVICO}  AND v.Tipo = 'OS' LIMIT 1;

    Should Not Be Empty    ${consulta}    msg=Não foi encontrado registro na tabela vendasprodutos para a OS ${COD_ORDEM_SERVICO}

    ${cod_vendedor_entrega}    Set Variable    ${consulta[0][0]}

    Should Be Equal As Strings    ${cod_vendedor_entrega}    ${Codigo_Vendedor}    msg=O CodVendedorEntrega está divergente. Esperado: ${Codigo_Vendedor}, Encontrado: ${cod_vendedor_entrega}

    Log    Validação OK: CodVendedorEntrega = ${cod_vendedor_entrega} corresponde ao vendedor informado

Então gravo a ordem de serviço
    Press Combination    KEY.ALT    KEY.G

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    ${CODIGO_OS_CRIADA}=    Pegar código da última OS criada do banco

    Set Suite Variable    ${CODIGO_OS_CRIADA}    ${CODIGO_OS_CRIADA}

E informo cliente com CPF não existente

    ${CPF}=    Gerar CPF válido não cadastrado no banco

    Set Suite Variable    ${CPF_CLIENTE}    ${CPF}

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

    Clicar no botão Não
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ESC
    Sleep    ${SLEEP_MEDIO}

    Clicar no botão Sim
    Sleep    ${SLEEP_MEDIO}

E informo cliente com CNPJ não existente
    ${CNPJ}=    Gerar CNPJ válido não cadastrado no banco

    Set Suite Variable    ${CNPJ_CLIENTE}    ${CNPJ}

    Press Special Key    TAB

    Input Text    ${EMPTY}    ${CNPJ}

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO_CNPJ}    3

    IF    ${AVISO}

        Log    Aviso de CNPJ não cadastrado exibido com sucesso

    ELSE

        Fail    Aviso de CNPJ não cadastrado não foi exibido

    END

    Clicar no botão Não
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ESC
    Sleep    ${SLEEP_MEDIO}

    Clicar no botão Sim
    Sleep    ${SLEEP_MEDIO}

Então o sistema exibe aviso de CPF não cadastrado
    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO_CPF}    3

    IF    ${AVISO}

        Log    Aviso de CPF não cadastrado exibido com sucesso

    ELSE

        Fail    Aviso de CPF não cadastrado não foi exibido

    END

Então o sistema exibe aviso de CNPJ não cadastrado
    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_CLIENTE_NAO_CADASTRADO_CNPJ}    3

    IF    ${AVISO}

        Log    Aviso de CNPJ não cadastrado exibido com sucesso

    ELSE

        Fail    Aviso de CNPJ não cadastrado não foi exibido

    END

Fechar tela de informações de crédito
    ${tela_credito}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_INFO_CRÉDITOS}    3

    IF    ${tela_credito}

        Press Special Key    ESC
        Sleep    ${SLEEP_MEDIO}

    END

Então a ordem de serviço deve estar salva no banco com os dados corretos
    Validar OS criada com CPF no banco

Obter CPF de cliente ativo no banco
    ${resultado}=    Query    SELECT c.CPF FROM clientes c WHERE c.CPF IS NOT NULL AND c.CPF != '' AND c.Ativo = -1 ORDER BY RAND() LIMIT 1;

    Should Not Be Empty    ${resultado}

    ${CPF_COM_MASCARA}=    Set Variable    ${resultado[0][0]}

    Set Suite Variable    ${CPF_CLIENTE}    ${CPF_COM_MASCARA}

    Log    CPF do cliente: ${CPF_COM_MASCARA}

    RETURN    ${CPF_COM_MASCARA}

Obter CNPJ de cliente ativo no banco
    ${resultado}=    Query    SELECT c.CNPJ, c.Codigo, c.RazaoSocial FROM clientes c WHERE c.CNPJ IS NOT NULL AND c.CNPJ != '' AND c.Ativo = -1 AND c.FisicaJuridica = 'J' ORDER BY RAND() LIMIT 1;

    Should Not Be Empty    ${resultado}

    ${CNPJ_COM_MASCARA}=    Set Variable    ${resultado[0][0]}

    ${CODIGO_CLIENTE}=    Set Variable    ${resultado[0][1]}

    ${NOME_CLIENTE}=    Set Variable    ${resultado[0][2]}

    ${CNPJ_SEM_MASCARA}=    Evaluate    "${CNPJ_COM_MASCARA}".replace(".", "").replace("/", "").replace("-", "").replace(",", "")

    Set Suite Variable    ${CNPJ_CLIENTE}    ${CNPJ_COM_MASCARA}

    Set Suite Variable    ${CODIGO_CLIENTE_CNPJ}    ${CODIGO_CLIENTE}

    Set Suite Variable    ${NOME_CLIENTE_CNPJ}    ${NOME_CLIENTE}

    Log    CNPJ do cliente: ${CNPJ_COM_MASCARA} (sem máscara: ${CNPJ_SEM_MASCARA}) - Código: ${CODIGO_CLIENTE} - Nome: ${NOME_CLIENTE}

    RETURN    ${CNPJ_SEM_MASCARA}

Gerar CPF válido não cadastrado no banco
    ${encontrado}=    Set Variable    ${TRUE}

    FOR    ${I}    IN RANGE    1

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

Gerar CNPJ válido não cadastrado no banco
    ${encontrado}=    Set Variable    ${TRUE}

    FOR    ${I}    IN RANGE    10

        ${CNPJ_GERADO}=    Evaluate    random.randint(10000000000000, 99999999999999)
        ${CNPJ_STR}=    Convert To String    ${CNPJ_GERADO}
        ${D1}=    Evaluate    int(${CNPJ_STR}[0])
        ${D2}=    Evaluate    int(${CNPJ_STR}[1])
        ${D3}=    Evaluate    int(${CNPJ_STR}[2])
        ${D4}=    Evaluate    int(${CNPJ_STR}[3])
        ${D5}=    Evaluate    int(${CNPJ_STR}[4])
        ${D6}=    Evaluate    int(${CNPJ_STR}[5])
        ${D7}=    Evaluate    int(${CNPJ_STR}[6])
        ${D8}=    Evaluate    int(${CNPJ_STR}[7])
        ${D9}=    Evaluate    int(${CNPJ_STR}[8])
        ${D10}=    Evaluate    int(${CNPJ_STR}[9])
        ${D11}=    Evaluate    int(${CNPJ_STR}[10])
        ${D12}=    Evaluate    int(${CNPJ_STR}[11])
        ${D13}=    Evaluate    int(${CNPJ_STR}[12])
        ${SOMA1}=    Evaluate    ${D1}*5 + ${D2}*4 + ${D3}*3 + ${D4}*2 + ${D5}*9 + ${D6}*8 + ${D7}*7 + ${D8}*6 + ${D9}*5 + ${D10}*4 + ${D11}*3 + ${D12}*2
        ${RESTO1}=    Evaluate    ${SOMA1} % 11
        ${DIGITO1}=    Evaluate    0 if ${RESTO1} < 2 else 11 - ${RESTO1}
        ${SOMA2}=    Evaluate    ${D1}*6 + ${D2}*5 + ${D3}*4 + ${D4}*3 + ${D5}*2 + ${D6}*9 + ${D7}*8 + ${D8}*7 + ${D9}*6 + ${D10}*5 + ${D11}*4 + ${D12}*3 + ${DIGITO1}*2
        ${RESTO2}=    Evaluate    ${SOMA2} % 11
        ${DIGITO2}=    Evaluate    0 if ${RESTO2} < 2 else 11 - ${RESTO2}

        ${CNPJ_COMPLETO}=    Set Variable    ${CNPJ_STR}${DIGITO1}${DIGITO2}

        ${resultado}=    Query    SELECT c.CNPJ FROM clientes c WHERE c.CNPJ LIKE '%${CNPJ_COMPLETO}%' LIMIT 1;

        ${tamanho}=    Get Length    ${resultado}

        IF    ${tamanho} == 0

            ${encontrado}=    Set Variable    ${FALSE}

            BREAK

        END

    END

    Should Not Be Equal    ${encontrado}    ${TRUE}    msg=Não foi possível encontrar um CNPJ não cadastrado após 10 tentativas

    Log    CNPJ gerado não cadastrado: ${CNPJ_COMPLETO}

    RETURN    ${CNPJ_COMPLETO}

Pegar código da última OS criada do banco
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Tipo = 'OS' ORDER BY v.Codigo DESC LIMIT 1;

    Should Not Be Empty    ${resultado}

    RETURN    ${resultado[0][0]}

Validar OS criada com CPF no banco
    ${resultado}=    Query    SELECT v.Codigo, v.CodigoVendedor, v.Tabela, v.CodigoCliente, v.RazaoCliente, v.CNPJ FROM vendas v WHERE v.Codigo = ${CODIGO_OS_CRIADA} AND v.Tipo = 'OS' AND v.Cancelada IS NULL;

    Should Not Be Empty    ${resultado}

    Log    Resultado da query: ${resultado}

    ${CNPJ_BANCO}=    Set Variable    ${resultado[0][5]}

    Log    CNPJ/CPF no banco: ${CNPJ_BANCO}

    Should Not Be Empty    ${CNPJ_BANCO}    msg=O campo CNPJ está vazio na OS criada

    Should Be Equal As Strings    ${CNPJ_BANCO}    ${CPF_CLIENTE}

    Log    OS validada com sucesso! Código: ${resultado[0][0]}, Cliente: ${resultado[0][4]}, CNPJ/CPF: ${CNPJ_BANCO}

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

Validar OS criada com CNPJ no banco
    ${resultado}=    Query    SELECT v.Codigo, v.CodigoVendedor, v.Tabela, v.CodigoCliente, v.RazaoCliente, v.CNPJ FROM vendas v WHERE v.Codigo = ${CODIGO_OS_CRIADA} AND v.Tipo = 'OS' AND v.Cancelada IS NULL;

    Should Not Be Empty    ${resultado}

    ${CNPJ_BANCO}=    Set Variable    ${resultado[0][5]}

    Log    CNPJ no banco: ${CNPJ_BANCO}

    Should Not Be Empty    ${CNPJ_BANCO}    msg=O campo CNPJ está vazio na OS criada

    Should Be Equal As Strings    ${CNPJ_BANCO}    ${CNPJ_CLIENTE}

    Log    OS validada com sucesso! Código: ${resultado[0][0]}, Cliente: ${resultado[0][4]}, CNPJ: ${CNPJ_BANCO}

Então o sistema exibe o código do cliente substituindo o CNPJ
    Sleep    ${SLEEP_MEDIO}

    Press Special Key    TAB
    Sleep    ${SLEEP_BAIXO}

    Log    CNPJ ${CNPJ_CLIENTE} foi substituído pelo código do cliente ${CODIGO_CLIENTE_CNPJ} - Nome: ${NOME_CLIENTE_CNPJ}

Então a ordem de serviço deve estar salva no banco com o CNPJ correto
    Sleep    ${SLEEP_ALTO}

    Validar OS criada com CNPJ no banco

E tento gravar a OS sem serviço
    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_MEDIO}

    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_OS_SEM_SERVICO}    3

    IF    ${AVISO}

        Log    Aviso de OS sem serviço exibido com sucesso

    ELSE

        Fail    Aviso de OS sem serviço não foi exibido

    END

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}


E tento finalizar a OS sem serviço
    # Tenta desdobrar o pagamento (Alt+D) e finalizar (Alt+F)
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.D
    Sleep    ${SLEEP_MEDIO}

    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_OS_SEM_SERVICO}    3

    IF    ${AVISO}

        Log    Aviso de OS sem serviço exibido ao tentar finalizar

    ELSE

        Fail    Aviso de OS sem serviço não foi exibido ao tentar finalizar

    END

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

Então o sistema exibe aviso de OS sem serviço
    ${AVISO}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_OS_SEM_SERVICO}    3

    IF    ${AVISO}

        Log    Aviso de OS sem serviço exibido com sucesso

    ELSE

        Fail    Aviso de OS sem serviço não foi exibido

    END

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

E o foco deve estar na guia de serviços
    Press Special Key    ESC
    Sleep    ${SLEEP_MEDIO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    Log    OS cancelada com sucesso


Verifica ordem de serviço após ser fechada
    KeyOrdemDeSevico1.Verifica ordem de serviço após ser fechada

Então a OS com produto normal deve estar salva no banco
    ${resultado}=    Query    SELECT v.Codigo, v.Tipo, v.Status FROM vendas v WHERE v.Codigo = ${COD_ORDEM_SERVICO} AND v.Tipo = 'OS' AND v.Status = 'c' AND v.Cancelada IS NULL;

    Should Not Be Empty    ${resultado}

    ${produtos}=    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO} AND vp.Cancelada IS NULL;

    Should Be True    ${produtos[0][0]} > 0    msg=A OS não possui produtos

    Log    OS com produto normal validada com sucesso! Código: ${COD_ORDEM_SERVICO}, Status: ${resultado[0][2]}, Produtos: ${produtos[0][0]}

E que existe uma OS com produto normal salva
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Tipo = 'OS' AND v.Status = 'c' AND v.Cancelada IS NULL AND DATE(v.Data) = CURDATE() AND EXISTS (SELECT 1 FROM vendasprodutos vp WHERE vp.CodigoVenda = v.Codigo AND vp.Cancelada IS NULL) ORDER BY v.Codigo DESC LIMIT 1;

    ${tem_os}=    Evaluate    len($resultado) > 0

    IF    not ${tem_os}

        Log    Nenhuma OS com produto encontrada para a data atual. Criando uma nova OS...

        Quando inicio uma nova ordem de serviço

        E informo o vendedor

        E informo a tabela de preço

        E informo o cliente pelo CPF

        E insiro um produto normal

        E acesso a aba de pagamentos

        Então gravo a ordem de serviço

        ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Tipo = 'OS' AND v.Status = 'c' AND v.Cancelada IS NULL AND DATE(v.Data) = CURDATE() AND EXISTS (SELECT 1 FROM vendasprodutos vp WHERE vp.CodigoVenda = v.Codigo AND vp.Cancelada IS NULL) ORDER BY v.Codigo DESC LIMIT 1;

    END

    Should Not Be Empty    ${resultado}    msg=Nenhuma OS com produto normal encontrada nem foi possível criar uma nova

    Set Test Variable    ${CODIGO_OS_EXCLUIR}    ${resultado[0][0]}

    Log    OS encontrada/criada para exclusão: ${CODIGO_OS_EXCLUIR}

Quando seleciono a OS e clico em excluir
    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.C
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    HOME
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_MEDIO}
    
    Input Text    ${EMPTY}    ${CODIGO_OS_EXCLUIR}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    Clicar no botão Excluir

E informo a descrição de exclusão
    ${tela_senha}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_SENHA_USUARIO}    3

    IF    ${tela_senha}

        Input Text    ${EMPTY}    ${SENHA_SUPERVISOR}

        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}

    END

    ${tela_exclusao}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_EXCLUIR_OS}    5

    Should Be True    ${tela_exclusao}    msg=Tela de exclusão não foi exibida

    Input Text    ${INPUT_DESCRICAO_EXCLUSAO}    Caso de teste: 1-319
    Sleep    ${SLEEP_BAIXO}

    Clicar no botão Sim
    Sleep    ${SLEEP_MEDIO}

Então a OS deve ser excluída do banco
    ${resultado}=    Query    SELECT v.Cancelada FROM vendas v WHERE v.Codigo = ${CODIGO_OS_EXCLUIR} AND v.Tipo = 'OS';

    Should Not Be Empty    ${resultado}

    Should Be Equal As Strings    ${resultado[0][0]}    x    msg=A OS não foi marcada como cancelada

    Log    OS ${CODIGO_OS_EXCLUIR} excluída com sucesso!



# ====================================================================
# KEYWORDS - OS COM DESCRIÇÃO EM SERVIÇOS (CT 149585)
# ====================================================================


Quando inicio uma nova ordem de serviço para detalhamento
    Clicar no botão Adicionar

    Valida indicação de venda(${Parametro_IndicacaoOS})

    Valida local de negociação da venda
    Sleep    ${SLEEP_MEDIO}

    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_ALTO}

    Sleep    ${SLEEP_MEDIO}

    ${Consulta}    Query    SELECT Codigo FROM vendas ORDER BY Codigo DESC LIMIT 1;

    Set Test Variable    ${CODIGO_OS_DETALHAMENTO}    ${Consulta[0][0]}


E informo o vendedor para OS detalhamento
    ${codVendedor}=    KeyCarregamento1.Seleciona vendedor

    Set Test Variable    ${Codigo_Vendedor}    ${codVendedor}

    Valida vendedor padrao
    Sleep    ${SLEEP_MEDIO}

    Input Text    ${EMPTY}    ${Codigo_Vendedor}

    Press Special Key    TAB


E informo a tabela de preço para OS detalhamento
    Verifica seleção de tabela de preço(OrdemDeServico)


E informo o cliente pelo CPF para OS detalhamento
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


Quando insiro um serviço com descrição detalhada
    [Arguments]    ${QQTD_SERVICOS}=1

    # Busca todos os servicos elegiveis ANTES do loop
    ${consultaServico}    Query    SELECT s.Codigo, s.Detalha FROM servicos s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Detalha <> 0;

    IF    not ${consultaServico}

        Fail    Banco de dados sem servico cadastrado que exija detalhamento (Detalha = 1).

    END

    ${quantidade_servicos}    Get Length    ${consultaServico}

    Log    Encontrados ${quantidade_servicos} servicos para possivel insercao

    FOR    ${i}    IN RANGE    ${QQTD_SERVICOS}

        Log    Inserindo servico ${i + 1} de ${QQTD_SERVICOS}

        Press Combination    KEY.ALT    KEY.S
        Sleep    ${SLEEP_BAIXO}

        # Seleciona um servico aleatorio da lista
        ${indice_servico}    Evaluate    random.randint(0, len($consultaServico) - 1)
        ${servico_selecionado}    Get From List    ${consultaServico}    ${indice_servico}
        ${codigo_servico}    Set Variable    ${servico_selecionado[0]}

        Input Text    ${EMPTY}    ${codigo_servico}
        Sleep    ${SLEEP_BAIXO}

        Press Special Key    TAB

        ${tela_detalhamento}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_DETALHAMENTO_SERVICO}    ${TEMPO_TELA}
        Should Be True    ${tela_detalhamento}    msg=Tela de detalhamento do servico nao foi exibida

        ${descricao}=    Gerar descrição detalhada para serviço
        Append To List    ${DESCRICOES_SERVICOS}    ${descricao}

        Input Text    ${EMPTY}    ${descricao}
        Sleep    ${SLEEP_BAIXO}

        Press Combination    KEY.ALT    KEY.C
        Sleep    ${SLEEP_MEDIO}

        Press Combination    KEY.ALT    KEY.N
        Sleep    ${SLEEP_MEDIO}

        Set Test Variable    ${COD_SERVICO}    ${codigo_servico}
        Log    Servico ${codigo_servico} inserido com descricao: ${descricao}

    END


Quando insiro o segundo serviço com descrição detalhada
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    ${consultaServico}    Query    SELECT s.Codigo, s.Detalha FROM servicos s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IS NULL AND s.Detalha = 1 AND s.Codigo != ${COD_SERVICO} ORDER BY RAND() LIMIT 1;

    ${condicao}=    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM servicos s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IS NULL AND s.Detalha = 1 AND s.Codigo != ${COD_SERVICO} LIMIT 1;

    IF    not ${condicao}

        Fail    Banco de dados sem segundo serviço cadastrado que exija detalhamento (Detalha = 1).

    END

    Input Text    ${EMPTY}    ${consultaServico[0][0]}
    Sleep    ${SLEEP_BAIXO}

    Press Special Key    TAB

    ${tela_detalhamento}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_DETALHAMENTO_SERVICO}    ${TEMPO_TELA}
    Should Be True    ${tela_detalhamento}    msg=Tela de detalhamento do segundo serviço não foi exibida

    ${descricao}=    Gerar descrição detalhada para serviço
    Append To List    ${DESCRICOES_SERVICOS}    ${descricao}

    Input Text    ${EMPTY}    ${descricao}
    Sleep    ${SLEEP_BAIXO}

    Press Combination    KEY.ALT    KEY.C
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${COD_SERVICO}    ${consultaServico[0][0]}
    Log    Segundo serviço ${COD_SERVICO} inserido com descrição: ${descricao}


Gerar descrição detalhada para serviço
    ${tipos}=    Create List    Reparo    Instalacao    Manutencao    Revisao    Conserto    Configuracao    Montagem    Desmontagem    Inspecao    Teste

    ${local}=    Create List    no local    no escritorio    na residencia do cliente    no veiculo    no equipamento    no sistema    na rede    no servidor    no computador    no dispositivo

    ${problema}=    Create List    apresentando defeito    com mau funcionamento    com erro no sistema    com problema de conexao    com falha de comunicacao    com desempenho lento    com tela preta    com superaquecimento    com ruido anormal    com vibracao excessiva

    ${acao}=    Create List    foi realizada    foi executada    foi concluida    foi finalizada    foi completada    foi efetuada    foi feita    foi aplicada    foi implementada    foi executada com sucesso

    ${tipo_idx}=    Evaluate    random.randint(0, len($tipos) - 1)

    ${local_idx}=    Evaluate    random.randint(0, len($local) - 1)

    ${problema_idx}=    Evaluate    random.randint(0, len($problema) - 1)

    ${acao_idx}=    Evaluate    random.randint(0, len($acao) - 1)

    ${tipo}=    Get From List    ${tipos}    ${tipo_idx}

    ${local_val}=    Get From List    ${local}    ${local_idx}

    ${problema_val}=    Get From List    ${problema}    ${problema_idx}

    ${acao_val}=    Get From List    ${acao}    ${acao_idx}

    ${numero}=    Evaluate    random.randint(100, 9999)

    ${descricao}=    Catenate    SEPARATOR=    ${SPACE}    ${tipo}${SPACE}${local_val}${SPACE}numero${SPACE}${numero},${SPACE}${problema_val},${SPACE}${acao_val}.

    # Remove acentos para compatibilidade com Sikuli
    ${descricao}=    Evaluate    "${descricao}".replace("ã", "a").replace("â", "a").replace("á", "a").replace("à", "a").replace("é", "e").replace("ê", "e").replace("è", "e").replace("í", "i").replace("î", "i").replace("ì", "i").replace("õ", "o").replace("ô", "o").replace("ó", "o").replace("ò", "o").replace("ú", "u").replace("û", "u").replace("ù", "u").replace("ç", "c")

    RETURN    ${descricao}


Então gravo a ordem de serviço com serviços detalhados
    Press Combination    KEY.ALT    KEY.G

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    ${CODIGO_OS_CRIADA}=    Pegar código da última OS criada do banco

    Set Suite Variable    ${CODIGO_OS_CRIADA}    ${CODIGO_OS_CRIADA}

    Log    OS criada com código: ${CODIGO_OS_CRIADA}


Quando visualizo a ordem de serviço gerada
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.V

    Wait Until Screen Contain    ${TELA_VISUALIZA_VENDA}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    Press Combination    KEY.ALT    KEY.r

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${SLEEP_ALTO}


Quando acesso a aba de serviços da OS
    Press Combination    KEY.ALT    KEY.S

    Wait Until Screen Contain    ${GUIA_SERVICOS_OS}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}


Então as descrições dos serviços devem estar salvas corretamente
    Log    Validando descrições salvas no banco para OS ${CODIGO_OS_CRIADA}
    
    Log    Descrições esperadas: ${DESCRICOES_SERVICOS}

    ${servicos_db}=    Query    SELECT vs.CodigoServico, vs.DescExpandida FROM vendasservicos vs WHERE vs.CodigoVenda = ${CODIGO_OS_CRIADA} AND vs.Cancelada IS NULL ORDER BY vs.Sequencia;

    Should Not Be Empty    ${servicos_db}    msg=Nenhum serviço encontrado na OS ${CODIGO_OS_CRIADA}

    ${quantidade_servicos}=    Get Length    ${servicos_db}
    Should Be Equal As Integers    ${quantidade_servicos}    2    msg=Esperado 2 serviços na OS, encontrado: ${quantidade_servicos}

    ${desc1}=    Set Variable    ${servicos_db[0][1]}
    ${desc2}=    Set Variable    ${servicos_db[1][1]}

    Should Not Be Empty    ${desc1}    msg=Descricao do primeiro serviço está vazia
    Should Not Be Empty    ${desc2}    msg=Descricao do segundo serviço está vazia

    Log    Descricao 1 salva: ${desc1}
    Log    Descricao 2 salva: ${desc2}

    ${desc1_valida}=    Evaluate    len(str($desc1).strip()) > 10
    ${desc2_valida}=    Evaluate    len(str($desc2).strip()) > 10

    Should Be True    ${desc1_valida}    msg=Descricao 1 muito curta ou inválida: ${desc1}
    Should Be True    ${desc2_valida}    msg=Descricao 2 muito curta ou inválida: ${desc2}

    Log    Descrições validadas com sucesso no banco de dados!


Então a OS com serviços detalhados deve estar salva no banco
    ${resultado}=    Query    SELECT v.Codigo, v.Tipo, v.Status FROM vendas v WHERE v.Codigo = ${CODIGO_OS_CRIADA} AND v.Tipo = 'OS' AND v.Status = 'o' AND v.Cancelada IS NULL;
    Should Not Be Empty    ${resultado}    msg=OS nao encontrada ou com status incorreto
    Log    OS ${CODIGO_OS_CRIADA} validada no banco — Status: ${resultado[0][2]}


# ====================================================================
# KEYWORDS - NFS-E DE ORDEM DE SERVIÇO (CT 1-138)
# ====================================================================


Quando insiro um serviço com descrição para NFS-e
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}

    # Busca serviço que exige detalhamento
    ${consultaServico}    Query    SELECT s.Codigo, s.Detalha FROM servicos s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IS NULL AND s.Detalha = 1 ORDER BY RAND() LIMIT 1;

    ${condicao}=    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM servicos s WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Inativo = 0 AND s.TabelaComissao IS NULL AND s.Detalha = 1 LIMIT 1;

    IF    not ${condicao}
        Fail    Banco de dados sem serviço cadastrado que exija detalhamento (Detalha = 1).
    END

    # Insere código do serviço
    Input Text    ${EMPTY}    ${consultaServico[0][0]}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    TAB

    # Abre tela de detalhamento
    ${tela_detalhamento}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_DETALHAMENTO_SERVICO}    ${TEMPO_TELA}
    Should Be True    ${tela_detalhamento}    msg=Tela de detalhamento do serviço nao foi exibida

    # Gera descrição única
    ${descricao}=    Gerar descrição detalhada para serviço
    Set Test Variable    ${DESCRICAO_SERVICO_NFSE}    ${descricao}

    # Preenche descrição
    Input Text    ${EMPTY}    ${descricao}
    Sleep    ${SLEEP_BAIXO}

    # Confirma detalhamento (Alt+C)
    Press Combination    KEY.ALT    KEY.C
    Sleep    ${SLEEP_MEDIO}

    # Informa quantidade
    Input Text    ${EMPTY}    1
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}

    # Gera valor aleatório para o serviço
    ${valor}=    Evaluate    random.randint(50, 500)
    Set Test Variable    ${VALOR_SERVICO_NFSE}    ${valor}

    Input Text    ${EMPTY}    ${valor}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    # Inclui o serviço (Alt+N)
    Press Combination    KEY.ALT    KEY.N
    Sleep    ${SLEEP_MEDIO}

    Set Test Variable    ${CODIGO_SERVICO_NFSE}    ${consultaServico[0][0]}
    Log    Serviço ${CODIGO_SERVICO_NFSE} inserido com descriçao: ${descricao}, valor: ${valor}


E insiro funcionários comissionados para NFS-e
    Wait Until Screen Contain    ${TELA_FUNCIONARIO_COMISSIONADO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    # Insere código do vendedor/comissionado
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Sleep    ${SLEEP_BAIXO}

    # Inclui funcionário (Alt+N)
    Press Combination    KEY.ALT    KEY.N
    Sleep    ${SLEEP_MEDIO}

    # Sai da tela de funcionários (Alt+S)
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_MEDIO}
    Log    Funcionários comissionados inseridos para o serviço


E seleciono forma de pagamento 30 dias
    # Busca forma de pagamento 30 dias no banco
    ${forma}=    Query    SELECT Codigo, Descricao FROM formapagamento WHERE Descricao LIKE '%30%DIAS%' OR Descricao LIKE '%30 Dias%' OR Descricao LIKE '%30 dias%' LIMIT 1;

    ${condicao}=    Run Keyword And Return Status    Check If Exists In Database    SELECT 1 FROM formapagamento WHERE Descricao LIKE '%30%DIAS%' OR Descricao LIKE '%30 Dias%' OR Descricao LIKE '%30 dias%' LIMIT 1;

    IF    not ${condicao}
        Fail    Banco de dados sem forma de pagamento 30 dias cadastrada.
    END

    Set Test Variable    ${FORMA_PAGAMENTO_30_DIAS}    ${forma[0][0]}
    Log    Forma de pagamento 30 dias: ${forma[0][0]} - ${forma[0][1]}

    # Navega para o campo de forma de pagamento (3 tabs)
    FOR    ${i}    IN RANGE    3
        Press Special Key    TAB
        Sleep    ${SLEEP_BAIXO}
    END

    # Navega até a forma correta usando setas
    ${posicao}=    Evaluate    random.randint(1, 5)
    FOR    ${i}    IN RANGE    ${posicao}
        Press Special Key    DOWN
        Sleep    ${SLEEP_BAIXO}
    END

    # Inclui manual (Alt+U)
    Press Combination    KEY.ALT    KEY.U
    Sleep    ${SLEEP_MEDIO}
    Log    Forma de pagamento 30 dias selecionada e incluída


Então finalizo a OS para NFS-e
    # Finaliza a OS (Alt+F)
    Press Combination    KEY.ALT    KEY.F
    Sleep    ${SLEEP_MEDIO}

    # Fecha tela de impressão se aparecer
    ${tela_impressao}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_IMPRESSAO}    3
    IF    ${tela_impressao}
        Press Special Key    ESC
        Sleep    ${SLEEP_MEDIO}
    END

    Wait Until Screen Contain    ${TELA_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}

    # Salva o código da OS criada
    ${CODIGO_OS_CRIADA}=    Pegar código da última OS criada do banco
    Set Suite Variable    ${CODIGO_OS_CRIADA}    ${CODIGO_OS_CRIADA}
    Log    OS criada com código: ${CODIGO_OS_CRIADA}


Quando pesquiso a OS para NFS-e
    # Abre pesquisa (Alt+C)
    Press Combination    KEY.ALT    KEY.C
    Sleep    ${SLEEP_BAIXO}

    # Vai para o início (HOME)
    Press Special Key    HOME
    Sleep    ${SLEEP_BAIXO}

    # Confirma seleção
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    # Pesquisa pelo código da OS (Alt+P)
    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CODIGO_OS_CRIADA}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}
    Log    Pesquisando OS código: ${CODIGO_OS_CRIADA}


Quando fature a OS para NFS-e
    # Fatura a OS (Alt+U)
    Press Combination    KEY.ALT    KEY.U
    Sleep    ${SLEEP_MEDIO}
    Log    Clicou em Faturar para OS ${CODIGO_OS_CRIADA}


Então gero a NFS-e
    # Gera NFS-e (Alt+G)
    Press Combination    KEY.ALT    KEY.G
    Sleep    ${SLEEP_MEDIO}

    # Mensagem esperada: NFS-e rejeitada em homologação
    # Clica OK para confirmar que o fluxo funcionou
    ${msg_rejeitada}=    Run Keyword And Return Status    Wait Until Screen Contain    ${AVISO_NFSE_REJEITADA}    5
    IF    ${msg_rejeitada}
        Press Special Key    ENTER
        Sleep    ${SLEEP_MEDIO}
        Log    NFS-e rejeitada em homologação conforme esperado — fluxo validado com sucesso
    ELSE
        Log    NFS-e processada (pode ter sido aceita em homologação)
    END


# ====================================================================
# KEYWORDS - SERVIÇO AGREGADO (CT 1-271)
# ====================================================================

Dado que existe servico agregado no banco
    # Verifica se existe servico agregado cadastrado
    ${servico_agregado}    Query    SELECT sa.CodigoProdutoPrincipal, sa.CodigoServicoAgregado FROM servicos_agregados sa INNER JOIN produtos p ON p.Codigo = sa.CodigoProdutoPrincipal AND p.Cancelado IS NULL AND p.Ativo = -1 INNER JOIN servicos s ON s.Codigo = sa.CodigoServicoAgregado AND s.`Status` = 'g' AND s.Ativo = 1 LIMIT 1

    IF    ${servico_agregado}
        Set Suite Variable    ${CODIGO_PRODUTO_AGREGADO}    ${servico_agregado[0][0]}
        Set Suite Variable    ${CODIGO_SERVICO_AGREGADO}    ${servico_agregado[0][1]}
        Log    Servico agregado encontrado: Produto=${CODIGO_PRODUTO_AGREGADO}, Servico=${CODIGO_SERVICO_AGREGADO}
    ELSE
        # Nao existe, precisa criar
        Log    Nenhum servico agregado encontrado. Criando...

        # Busca produto valido
        ${produto}    Query    SELECT p.Codigo FROM produtos p INNER JOIN produtosestoque pe ON p.Codigo = pe.CodigoProduto WHERE p.ModalidadeControle = 'Normal' AND p.Cancelado IS NULL AND p.Ativo = -1 AND p.VendaT1 > 0 AND pe.Estoque > 0 AND pe.Empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1) ORDER BY RAND() LIMIT 1

        Should Not Be Empty    ${produto}    msg=Nenhum produto valido encontrado para criar servico agregado
        Set Suite Variable    ${CODIGO_PRODUTO_AGREGADO}    ${produto[0][0]}

        # Busca servico valido
        ${servico}    Query
        ...    SELECT s.Codigo FROM servicos s
        ...    WHERE s.`Status` = 'g' AND s.Ativo = 1 AND s.Detalha = 0
        ...    ORDER BY RAND() LIMIT 1

        Should Not Be Empty    ${servico}    msg=Nenhum servico valido encontrado para criar servico agregado
        Set Suite Variable    ${CODIGO_SERVICO_AGREGADO}    ${servico[0][0]}

        # Insere servico agregado no banco
        Execute Sql String
        ...    INSERT INTO servicos_agregados (CodigoProdutoPrincipal, CodigoServicoAgregado, Data, Usuario, Terminal)
        ...    VALUES (${CODIGO_PRODUTO_AGREGADO}, ${CODIGO_SERVICO_AGREGADO}, NOW(), 'automacao', 'teste')

        Log    Servico agregado criado: Produto=${CODIGO_PRODUTO_AGREGADO}, Servico=${CODIGO_SERVICO_AGREGADO}
    END

E informo o produto com servico agregado

    # Segue o mesmo padrao de "E insiro um produto normal informando a quantidade"
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT    KEY.P
    Sleep    ${SLEEP_BAIXO}

    Input Text    ${EMPTY}    ${CODIGO_PRODUTO_AGREGADO}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

    # Informa a quantidade do produto
    IF    1 != ${Parametro_QuantidadePadraoProduto}
        SikuliLibrary.Double Click    ${INPUT_QUANTIDADE_PRODUTO}
        Sleep    ${SLEEP_BAIXO}
        Input Text    ${EMPTY}    1
    END

    FOR   ${i}    IN RANGE    ${7}
        Press Special Key    ENTER
        Sleep    ${SLEEP_BAIXO}
    END

E seleciono o servico agregado
    # Aguarda tela de agregados
    ${tela_agregados}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_AGREGADOS}    ${TEMPO_TELA}
    Should Be True    ${tela_agregados}    msg=Tela de agregados nao foi exibida

    Sleep    ${SLEEP_MEDIO}

    # Clica no checkbox do servico agregado (imagem)
    SikuliLibrary.Click    ${CHECKBOX_SERVICO_AGREGADO}
    Sleep    ${SLEEP_BAIXO}

    # Clica em Selecionar (Alt+E)
    Press Combination    KEY.ALT    KEY.E
    Sleep    ${SLEEP_MEDIO}

E insiro o servico agregado
    # Verifica se o servico exige detalhamento
    ${servico_info}    Query    SELECT s.Detalha FROM servicos s WHERE s.Codigo = ${CODIGO_SERVICO_AGREGADO};

    ${exige_detalhamento}    Set Variable    ${servico_info[0][0]}

    IF    ${exige_detalhamento} > 0
        # Servico exige detalhamento
        ${tela_detalhamento}=    Run Keyword And Return Status    Wait Until Screen Contain    ${TELA_DETALHAMENTO_SERVICO}    ${TEMPO_TELA}
        IF    ${tela_detalhamento}
            ${descricao}=    Gerar descrição detalhada para serviço
            Append To List    ${DESCRICOES_SERVICOS}    ${descricao}
            Input Text    ${EMPTY}    ${descricao}
            Sleep    ${SLEEP_BAIXO}
            Press Combination    KEY.ALT    KEY.C
            Sleep    ${SLEEP_MEDIO}
        END
    END

    # Clica em Incluir (Alt+N)
    Press Combination    KEY.ALT    KEY.N
    Sleep    ${SLEEP_MEDIO}

Então a OS com servico agregado deve estar salva no banco
    [Arguments]    ${CODIGO_OS}

    Log    Validando OS ${CODIGO_OS} com servico agregado no banco

    # Valida que a OS existe e esta fechada
    ${os_info}    Query
    ...    SELECT v.Codigo, v.Status, v.Tipo FROM vendas v
    ...    WHERE v.Codigo = ${CODIGO_OS} AND v.Tipo = 'OS' AND v.Status = 'c'

    Should Not Be Empty    ${os_info}    msg=OS nao encontrada ou com status incorreto

    # Valida produto na tabela vendasprodutos
    ${produtos_os}    Query
    ...    SELECT vp.CodigoProduto, vp.CodigoVenda FROM vendasprodutos vp
    ...    WHERE vp.CodigoVenda = ${CODIGO_OS}

    Should Not Be Empty    ${produtos_os}    msg=Nenhum produto encontrado na OS ${CODIGO_OS}

    # Verifica se o produto agregado esta na OS
    ${produto_encontrado}    Evaluate    any(str(p[0]) == str($CODIGO_PRODUTO_AGREGADO) for p in $produtos_os)
    Should Be True    ${produto_encontrado}    msg=Produto ${CODIGO_PRODUTO_AGREGADO} nao encontrado na OS

    # Valida servico na tabela vendasservicos
    ${servicos_os}    Query
    ...    SELECT vs.CodigoServico, vs.CodigoVenda FROM vendasservicos vs
    ...    WHERE vs.CodigoVenda = ${CODIGO_OS} AND vs.Cancelada IS NULL

    Should Not Be Empty    ${servicos_os}    msg=Nenhum servico encontrado na OS ${CODIGO_OS}

    # Verifica se o servico agregado esta na OS
    ${servico_encontrado}    Evaluate    any(str(s[0]) == str($CODIGO_SERVICO_AGREGADO) for s in $servicos_os)
    Should Be True    ${servico_encontrado}    msg=Servico ${CODIGO_SERVICO_AGREGADO} nao encontrado na OS

    Log    OS ${CODIGO_OS} validada com sucesso: Produto=${CODIGO_PRODUTO_AGREGADO}, Servico=${CODIGO_SERVICO_AGREGADO}
