*** Settings ***
Documentation    Keywords para o Endpoint de Autenticação  

Resource        ./base.resource

*** Keywords ***
Registrar um Novo Usuário
    # Monta o corpo com dados fixos para o registro
    [Arguments]     ${nome}    ${email}    ${senha}    ${status_esperado}
    ${body}=        Create Dictionary
    ...             name=${nome}
    ...             email=${email}
    ...             password=${senha}

    # Resultado esperado da requisição = valido: 200 e 201 / invalido: >= 400
    ${response}=    Run Keyword If                   '${status_esperado}' == 'sucesso'
    ...    POST     ${BASE_API_URL}/auth/register    json=${body}
    ...    ELSE
    ...    POST     ${BASE_API_URL}/auth/register    json=${body}    expected_status=any

    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}
    RETURN    ${response}
    
    # Anterior sem a validação de valido e invalido
    # ${body}=    Create Dictionary
    # ...         name=Pedro Afonso
    # ...         email=pedro.teste@qa.com
    # ...         password=senha123
    
    # # Executa o POST e salva a última resposta na suíte
    # ${response}=    POST           ${BASE_API_URL}/auth/register    json=${body}
    # Set Suite Variable             ${ULTIMA_RESPOSTA}               ${response}
    # RETURN                         ${response}

Realizar Login
    # Monta o corpo com dados fixos para o registro
    ${body}=    Create Dictionary
    ...         email=${TEST_USER_EMAIL}
    ...         password=${TEST_USER_PASSWORD}
    
    # Executa o POST e salva a última resposta na suíte
    ${response}=    POST           ${BASE_API_URL}/auth/login    json=${body}
    Set Suite Variable             ${ULTIMA_RESPOSTA}            ${response}
    RETURN                         ${response}

Salvar Token De Autenticação
    # Converte a resposta em dicionário e salva o token para uso posterior
    ${json}=              Convert To Dictionary    ${ULTIMA_RESPOSTA.json()}
    Set Suite Variable    ${TOKEN}                 ${json["data"]["token"]}

Simular Logout (Descarta o Token)
    # Tenta acessar rota protegida com token antigo / Faz requisição SEM o token
    ${response}=          GET                   ${BASE_API_URL}/reservations/me    expected_status=any
    Set Suite Variable    ${ULTIMA_RESPOSTA}    ${response}