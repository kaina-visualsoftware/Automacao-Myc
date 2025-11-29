*** Settings ***
Library    DatabaseLibrary
Library    Collections
Resource   ../utils/parametros_admin_sistema.robot

*** Variables ***
@{PARAMS_ALTERADOS}
@{PARAMS_PRE_CONDICOES}

*** Keywords ***

Inicializar Pré-Condições
    Log To Console    \n\n╔══════════ PRÉ-CONDIÇÕES ═════════╗

    FOR    ${parametro}    ${valor}    IN    @{PARAMS_PRE_CONDICOES}

        Pré Condições Parâmetros    ${parametro}    ${valor}

    END

    Log To Console    \n╚══════════════════════════════════╝\n

Pré Condições Parâmetros
    [Arguments]    ${NOME_PARAMETRO}    ${VALOR_DESEJADO}

    ${IS_CONFIG}     Run Keyword And Return Status    Dictionary Should Contain Key    ${PARAM}        ${NOME_PARAMETRO}
    ${IS_EMPRESA}    Run Keyword And Return Status    Dictionary Should Contain Key    ${PARAM_EMP}    ${NOME_PARAMETRO}

    IF    ${IS_CONFIG} == False and ${IS_EMPRESA} == False

        Fail    O parâmetro "${NOME_PARAMETRO}" não existe nos dicionários PARAM ou PARAM_EMP.

    END

    IF    ${IS_CONFIG}

        ${NOME_COLUNA}    Set Variable    ${PARAM["${NOME_PARAMETRO}"]}

    END

    IF    ${IS_EMPRESA}

        ${NOME_COLUNA}    Set Variable    ${PARAM_EMP["${NOME_PARAMETRO}"]}

    END

    IF    ${IS_CONFIG}

        ${SQL_SELECT}     Set Variable    SELECT ${NOME_COLUNA} FROM config;

        ${VALOR_ATUAL}    Query    ${SQL_SELECT}
        ${VALOR_ATUAL}    Set Variable    ${VALOR_ATUAL[0][0]}

        Log To Console    \n[VALOR ATUAL] ${NOME_COLUNA} = ${VALOR_ATUAL}

        Set Global Variable    ${RESTORE_${NOME_PARAMETRO}}    ${VALOR_ATUAL}

        ${ATUAL_STR}       Convert To String    ${VALOR_ATUAL}
        ${DESEJADO_STR}    Convert To String    ${VALOR_DESEJADO}

        IF    '${ATUAL_STR}' == '${DESEJADO_STR}'

            Log To Console    Nenhuma alteração necessária.

        ELSE

            Log To Console    [UPDATE] ${NOME_COLUNA}: ${VALOR_ATUAL} → ${VALOR_DESEJADO}

            ${SQL_UPDATE}    Set Variable    UPDATE config SET ${NOME_COLUNA} = ${VALOR_DESEJADO};

            Execute Sql String    ${SQL_UPDATE}

            Append To List    ${PARAMS_ALTERADOS}    ${NOME_PARAMETRO}

        END

    END

    IF    ${IS_EMPRESA}

        ${SQL_SELECT}    Set Variable    SELECT ${NOME_COLUNA} FROM configempresa WHERE empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

        ${VALOR_ATUAL}    Query    ${SQL_SELECT}
        ${VALOR_ATUAL}    Set Variable    ${VALOR_ATUAL[0][0]}

        Log To Console    \n[VALOR ATUAL] ${NOME_COLUNA} = ${VALOR_ATUAL}

        Set Global Variable    ${RESTORE_${NOME_PARAMETRO}}    ${VALOR_ATUAL}

        ${ATUAL_STR}       Convert To String    ${VALOR_ATUAL}
        ${DESEJADO_STR}    Convert To String    ${VALOR_DESEJADO}

        IF    '${ATUAL_STR}' == '${DESEJADO_STR}'

            Log To Console    Nenhuma alteração necessária.

        ELSE

            Log To Console    [UPDATE] ${NOME_COLUNA}: ${VALOR_ATUAL} → ${VALOR_DESEJADO}

            ${SQL_UPDATE}    Set Variable    UPDATE configempresa SET ${NOME_COLUNA} = ${VALOR_DESEJADO} WHERE empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);

            Execute Sql String    ${SQL_UPDATE}

            Append To List    ${PARAMS_ALTERADOS}    ${NOME_PARAMETRO}

        END
    END

Restaurar Parametro
    [Arguments]    ${NOME_PARAMETRO}

    ${VALOR_ORIGINAL}    Get Variable Value    ${RESTORE_${NOME_PARAMETRO}}

    ${IS_CONFIG}     Run Keyword And Return Status    Dictionary Should Contain Key    ${PARAM}        ${NOME_PARAMETRO}
    ${IS_EMPRESA}    Run Keyword And Return Status    Dictionary Should Contain Key    ${PARAM_EMP}    ${NOME_PARAMETRO}

    IF    ${IS_CONFIG}

        ${NOME_COLUNA}    Set Variable    ${PARAM["${NOME_PARAMETRO}"]}

        Log To Console    [VALOR ORIGINAL] ${NOME_COLUNA} = ${VALOR_ORIGINAL}
        Log To Console    [UPDATE] ${NOME_COLUNA} = ${VALOR_ORIGINAL}

        ${SQL_UPDATE}    Set Variable    UPDATE config SET ${NOME_COLUNA} = ${VALOR_ORIGINAL};
        
        Execute Sql String    ${SQL_UPDATE}

    END

    IF    ${IS_EMPRESA}

        ${NOME_COLUNA}    Set Variable    ${PARAM_EMP["${NOME_PARAMETRO}"]}

        Log To Console    [VALOR ORIGINAL] ${NOME_COLUNA} = ${VALOR_ORIGINAL}
        Log To Console    [UPDATE] ${NOME_COLUNA} = ${VALOR_ORIGINAL}

        ${SQL_UPDATE}    Set Variable    UPDATE configempresa SET ${NOME_COLUNA} = ${VALOR_ORIGINAL} WHERE empresa = (SELECT ua_empresa FROM usuario_acesso WHERE ua_data = CURDATE() ORDER BY ua_id DESC LIMIT 1);
        
        Execute Sql String    ${SQL_UPDATE}

    END

Restaurar Parametros Alterados

    ${TEM_ALTERACOES}    Get Length    ${PARAMS_ALTERADOS}

    IF    not ${TEM_ALTERACOES}
        RETURN
    END

    Log To Console    \n╔═════ RESTAURAÇÃO PARÂMETROS ═════╗\n

    FOR    ${parametro}    IN    @{PARAMS_ALTERADOS}
        Restaurar Parametro    ${parametro}
    END

    Set Global Variable    @{PARAMS_ALTERADOS}    @{EMPTY}

    Log To Console    \n╚══════════════════════════════════╝\n
