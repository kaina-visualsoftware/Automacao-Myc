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
${CNPJ_CLIENTE}    NONE
${CODIGO_OS_CRIADA}    NONE
${CODIGO_ULTIMA_OS_ANTES}    NONE
${CODIGO_CLIENTE_CNPJ}    NONE
${NOME_CLIENTE_CNPJ}    NONE
${Quantidade_Produto}                  ${1}
${CODIGO_OS_EXCLUIR}                   ${NONE}
${CODIGO_PRODUTO}                      ${NONE}
${SENHA_SUPERVISOR}                    1

${AVISO_CLIENTE_NAO_CADASTRADO_CPF}   aviso_ClienteNaoCadastradoCPF.png
${AVISO_CLIENTE_NAO_CADASTRADO_CNPJ}  aviso_ClienteNaoCadastradoCNPJ.png
${AVISO_OS_SEM_SERVICO}                aviso_ObrigatorioIncluirServico.png


${TELA_ADICIONAR_ORDEM_DE_SERVICO}     tela_OrdemDeServicoAdicionar.png
${TELA_ORDEM_DE_SERVICO}                tela_OrdemDeServico.png
${TELA_EXCLUIR_OS}                      tela_ExcluirOS.png
${TELA_SENHA_USUARIO}                  tela_SenhaUsuario.png
${TELA_SETAR_VENDEDOR_PRODUTO}         tela_SetarVendedorProduto.png
${INPUT_DESCRICAO_EXCLUSAO}            input_DescricaoExclusao.png

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
    ${codVendedor}=    Seleciona vendedor
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
    Sleep    ${SLEEP_MEDIO}
    Input Text    ${EMPTY}    ${Codigo_Vendedor}
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_BAIXO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}

Então o foco deve estar no campo de código do produto
    Wait Until Screen Contain    ${TELA_ADICIONAR_ORDEM_DE_SERVICO}    ${TEMPO_TELA}
    Sleep    ${SLEEP_MEDIO}
    Log    Foco está no campo de código do produto

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
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${GUIA_SERVICOS_OS}    ${TEMPO_TELA}
    Log    Foco alterado para a guia de serviços com sucesso
    Press Special Key    ESC
    Sleep    ${SLEEP_MEDIO}
    Press Special Key    ENTER
    Sleep    ${SLEEP_MEDIO}
    Log    OS cancelada com sucesso

Então o foco deve estar na guia de serviços
    Sleep    ${SLEEP_MEDIO}
    Press Combination    KEY.ALT    KEY.S
    Sleep    ${SLEEP_BAIXO}
    Wait Until Screen Contain    ${GUIA_SERVICOS_OS}    ${TEMPO_TELA}
    Log    Foco alterado para a guia de serviços com sucesso

Verifica ordem de serviço após ser fechada
    KeyOrdemDeSevico1.Verifica ordem de serviço após ser fechada

Então a OS com produto normal deve estar salva no banco
    ${resultado}=    Query    SELECT v.Codigo, v.Tipo, v.Status FROM vendas v WHERE v.Codigo = ${COD_ORDEM_SERVICO} AND v.Tipo = 'OS' AND v.Status = 'c' AND v.Cancelada IS NULL;
    Should Not Be Empty    ${resultado}
    ${produtos}=    Query    SELECT COUNT(*) FROM vendasprodutos vp WHERE vp.CodigoVenda = ${COD_ORDEM_SERVICO} AND vp.Cancelada IS NULL;
    Should Be True    ${produtos[0][0]} > 0    msg=A OS não possui produtos
    Log    OS com produto normal validada com sucesso! Código: ${COD_ORDEM_SERVICO}, Status: ${resultado[0][2]}, Produtos: ${produtos[0][0]}

E que existe uma OS com produto normal salva
    ${resultado}=    Query    SELECT v.Codigo FROM vendas v WHERE v.Tipo = 'OS' AND v.Status = 'c' AND v.Cancelada IS NULL AND EXISTS (SELECT 1 FROM vendasprodutos vp WHERE vp.CodigoVenda = v.Codigo AND vp.Cancelada IS NULL) ORDER BY v.Codigo DESC LIMIT 1;
    Should Not Be Empty    ${resultado}    msg=Nenhuma OS com produto normal encontrada
    Set Test Variable    ${CODIGO_OS_EXCLUIR}    ${resultado[0][0]}
    Log    OS encontrada para exclusão: ${CODIGO_OS_EXCLUIR}

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
    Clicar no botão Editar
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
