*** Settings ***
Documentation    Keywords para o Endpoint de Regras de Negócio e Validações  

Resource        ./base.resource

*** Keywords ***
Realizar Login Com Senha Incorreta
    # Monta o corpo com dados fixos para o registro - CENÁRIO NEGATIVO
    ${body}=    Create Dictionary
    ...         email=${TEST_USER_EMAIL}
    ...         password=pwd123456
    
    # Executa o POST e salva a última resposta na suíte
    ${response}=    POST           ${BASE_API_URL}/auth/login    json=${body}    expected_status=ANY
    Set Suite Variable             ${ULTIMA_RESPOSTA}            ${response}
    RETURN                         ${response}

Obter Primeira Sessão Disponível
    # Pega o ID da primeira sessão listada pela API e o salva para uso no teste.
    ${headers}=                Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=               GET                  ${BASE_API_URL}/sessions    headers=${headers}
    Status Should Be    200    ${response}
    
    ${session_id}=       Set Variable     ${response.json()}[data][0][_id]
    Set Test Variable    ${SESSION_ID}    ${session_id}
    Log                  Sessão de Teste Selecionada: ${SESSION_ID}

Resetar Assentos Da Sessão
    # Chama o endpoint da API para libertar todos os assentos de uma sessão.
    ${headers}=      Create Dictionary    Authorization=Bearer ${TOKEN}
    
    # O endpoint correto para resetar é PUT, não POST
    ${response}=     PUT    ${BASE_API_URL}/sessions/${SESSION_ID}/reset-seats    headers=${headers}
    
    # Validações para garantir que o setup funcionou
    Status Should Be    200                            ${response}
    Should Contain      ${response.json()}[message]    All seats reset to available status

Efetuar Nova Reserva
    # Cria o corpo da requisição e envia um POST para criar uma nova reserva.
    [Arguments]    ${row}    ${number}

    # Converte o número para inteiro
    ${number_int}=    Convert To Integer    ${number}

    # Criar o dicionário do assento e DEPOIS o adicionamos à lista
    ${seat}=          Create Dictionary    row=${row}    number=${number_int}    type=full
    ${seats_list}=    Create List          ${seat}

    ${body}=          Create Dictionary    session=${SESSION_ID}    seats=${seats_list}
    
    ${headers}=       Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=      POST    ${BASE_API_URL}/reservations    json=${body}    headers=${headers}    expected_status=any

    # Salva a resposta para que a keyword de validação com IA possa usá-la
    Set Test Variable    ${ULTIMA_RESPOSTA}    ${response}

Obter Primeiro Teatro Disponível
    # Pega o ID do primeiro teatro listada pela API e o salva para uso no teste.
    ${headers}=         Create Dictionary    Authorization=Bearer ${TOKEN}
    ${response}=        GET                  ${BASE_API_URL}/theaters    headers=${headers}
    Status Should Be    200                  ${response}

    ${json}=              Convert To Dictionary    ${response.json()}
    ${theater_id}=        Get From Dictionary      ${json["data"][0]}    _id
    Set Suite Variable    ${THEATER_ID}            ${theater_id}

Criar Nova Sessão de Filme
    [Arguments]    ${movie_id}

    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${body}=       Create Dictionary
    ...            movie=${movie_id}
    ...            theater=${THEATER_ID}
    ...            datetime=2025-06-23T23:00:00.000Z
    ...            fullPrice=80.0
    ...            halfPrice=20.0

    ${response}=          POST                  ${BASE_API_URL}/sessions    headers=${headers}    json=${body}    expected_status=any
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}