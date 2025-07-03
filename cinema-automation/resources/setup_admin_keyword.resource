*** Settings ***
Documentation    Keywords para o Endpoint de Admin  

Resource        ./base.resource

*** Keywords ***
Criar Filme
    [Arguments]    ${caminho_dados_filme}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    # Força Codificação UTF-8
    ${body}=       Evaluate    json.load(open(r'''${caminho_dados_filme}''', encoding='utf-8'))    json
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    ${response}=   POST    ${BASE_API_URL}/movies
    ...            headers=${headers}
    ...            data=${body_str}
    ...            expected_status=any

    Evaluate       setattr($response, 'encoding', 'utf-8')
    ${json}=       Set Variable        ${response.json()}

    Set Suite Variable    ${FILME_ID}           ${json["data"]["_id"]}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Listar Todos os Filmes
    [Arguments]         ${index}=None
    ${headers}=         Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=        GET                  ${BASE_API_URL}/movies    headers=${headers}
    Status Should Be    200                  ${response}

    # Força Codificação UTF-8
    Evaluate          setattr($response, 'encoding', 'utf-8')
    ${json}=          Set Variable    ${response.json()}

    Log To Console     \nFilmes disponíveis:
    FOR    ${filme}    IN    @{json["data"]}
        Log To Console    - ${filme["title"]}
    END

    # Guarda o número do filme recebido como argumento.
    Run Keyword If    '${index}' != 'None'
    ...    Set Suite Variable    ${FILME_SELECIONADO}    ${json["data"][${index}]}

Atualizar Filme
    [Arguments]    ${caminho_dados_filme}    ${id_filme}=
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    # Força Codificação UTF-8
    ${body}=       Evaluate    json.load(open(r'''${caminho_dados_filme}''', encoding='utf-8'))    json
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    Run Keyword If    '${id_filme}' == ''    Set Test Variable    ${id_filme}    ${FILME_ID}
    Log To Console    Atualizando filme: ${body["title"]}

    ${url}=        Set Variable     ${BASE_API_URL}/movies/${id_filme}
    ${response}=   PUT    ${url}    headers=${headers}    data=${body_str}    expected_status=any

    Evaluate              setattr($response, 'encoding', 'utf-8')
    Log To Console        \n🔄 Filme atualizado: ${response.status_code} - ${response.text}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Deletar Filme
    [Arguments]       ${id_filme}=
    ${headers}=       Create Dictionary    Authorization=Bearer ${TOKEN}

    Run Keyword If    '${id_filme}' == ''    Set Test Variable    ${id_filme}    ${FILME_ID}
    Log To Console    \n🗑️ Deletando filme com ID: ${id_filme}

    ${url}=           Set Variable    ${BASE_API_URL}/movies/${id_filme}
    ${response}=      DELETE          ${url}    headers=${headers}    expected_status=any

    Evaluate          setattr($response, 'encoding', 'utf-8')
    Log To Console    \n🧾 Resposta do delete: ${response.status_code} - ${response.text}

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Criar Sala
    [Arguments]    ${nome}              ${capacidade}                    ${tipo}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    ${body}=       Create Dictionary
    ...            name=${nome}
    ...            capacity=${capacidade}
    ...            type=${tipo}
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    ${response}=   POST    ${BASE_API_URL}/theaters
    ...            headers=${headers}
    ...            data=${body_str}
    ...            expected_status=any

    Evaluate              setattr($response, 'encoding', 'utf-8')
    ${json}=              Set Variable          ${response.json()}
    Set Suite Variable    ${SALA_ID}            ${json["data"]["_id"]}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Listar Todas as Salas
    [Arguments]         ${index}=None
    ${response}=        GET    ${BASE_API_URL}/theaters
    Status Should Be    200    ${response}

    Evaluate            setattr($response, 'encoding', 'utf-8')
    ${json}=            Set Variable        ${response.json()}

    Log To Console    \nSalas disponíveis:
    FOR    ${sala}    IN    @{json["data"]}
        Log To Console    - ${sala["name"]} (${sala["type"]}) - Capacidade: ${sala["capacity"]}
    END

    # Só sobrescreve SALA_ID se for explicitamente solicitado com o argumento
    Run Keyword If    '${index}' != '' and '${index}' != 'None'
    ...    Set Suite Variable    ${SALA_ID}    ${json["data"][${index}]["_id"]}

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Atualizar Sala
    [Arguments]    ${nome}              ${capacidade}        ${tipo}     ${id_sala}=
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json; charset=UTF-8

    ${body}=       Create Dictionary
    ...            name=${nome}
    ...            capacity=${capacidade}
    ...            type=${tipo}
    ${body_str}=   Evaluate    json.dumps(${body}, ensure_ascii=False)    json

    Run Keyword If    '${id_sala}' == ''    Set Test Variable    ${id_sala}    ${SALA_ID}
    Log To Console    Atualizando sala: ${body["name"]}

    ${url}=        Set Variable    ${BASE_API_URL}/theaters/${id_sala}
    ${response}=   PUT             ${url}    headers=${headers}    data=${body_str}    expected_status=any

    Evaluate    setattr($response, 'encoding', 'utf-8')
    Log To Console    \n🔄 Sala atualizada: ${response.status_code} - ${response.text}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Deletar Sala
    [Arguments]       ${id_sala}=
    ${id_sala}=    Set Variable If    '${id_sala}' == '' or '${id_sala}' == 'None'    ${SALA_ID}    ${id_sala}
    Set Suite Variable    ${SALA_ID}    ${id_sala}
    # Run Keyword If    '${id_sala}' == '' or '${id_sala}' == 'None'    Set Variable    ${id_sala}    ${SALA_ID}
    ${headers}=       Create Dictionary    Authorization=Bearer ${TOKEN}

    Log To Console    \n🗑️ Deletando sala com ID: ${id_sala}
    ${url}=           Set Variable    ${BASE_API_URL}/theaters/${id_sala}
    ${response}=      DELETE          ${url}    headers=${headers}    expected_status=any

    Evaluate              setattr($response, 'encoding', 'utf-8')
    Log To Console        \n🧾 Resposta do delete: ${response.status_code} - ${response.text}
    Set Suite Variable    ${ULTIMA_RESPOSTA}        ${response}

Criar Sessão de Filme
    [Arguments]    ${datetime}    ${fullPrice}    ${halfPrice}    ${filme_id}=${FILME_ID}    ${sala_id}=${SALA_ID}
    ${body}=    Create Dictionary
    ...    movie=${filme_id}
    ...    theater=${sala_id}
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${response}=    POST    ${BASE_API_URL}/sessions    json=${body}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    Set Variable    ${response.json()}
    Set Suite Variable    ${SESSAO_ID}    ${json["data"]["_id"]}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Atualizar Sessão de Filme
    [Arguments]    ${datetime}    ${fullPrice}    ${halfPrice}    ${sessao_id}=${SESSAO_ID}
    ${body}=    Create Dictionary
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${response}=    PUT    ${BASE_API_URL}/sessions/${sessao_id}    json=${body}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    Set Suite Variable    ${SESSAO_ID}    ${json["data"]["_id"]}
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Deletar Sessão de Filme
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${response}=    DELETE    ${BASE_API_URL}/sessions/${SESSAO_ID}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}

Listar Todas Sessões de Filmes
    [Arguments]    ${index}=None
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=   GET    ${BASE_API_URL}/sessions    headers=${headers}
    Status Should Be    200    ${response}

    Evaluate        setattr($response, 'encoding', 'utf-8')
    ${json}=        Set Variable    ${response.json()}

    Log To Console    \n🎬 Sessões disponíveis:
    FOR    ${sessao}    IN    @{json["data"]}
        ${filme}=    Set Variable If    'title' in ${sessao["movie"]}     ${sessao["movie"]["title"]}     N/A
        ${sala}=     Set Variable If    'name' in ${sessao["theater"]}    ${sessao["theater"]["name"]}    N/A
        ${horario}=  Set Variable If    'datetime' in ${sessao}           ${sessao["datetime"]}           N/A
        Log To Console    - Filme: ${filme} | Sala: ${sala} | Horário: ${horario}
    END

    Run Keyword If    '${index}' != '' and '${index}' != 'None'
    ...    Set Suite Variable    ${SESSAO_ID}    ${json["data"][${index}]["_id"]}

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}