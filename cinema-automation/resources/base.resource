*** Settings ***
Documentation    Arquivo base com inicialização de sessão e variáveis comuns
Library          RequestsLibrary

*** Variables ***
${BASE_API_URL}    https://cinema-challenge-back.onrender.com/api/v1

*** Keywords ***
Criar Sessão API
    # Cria uma sessão HTTP nomeada "CinemaAPP" com a URL base da API
    Create Session    CinemaAPP    ${BASE_API_URL}

Validar Código de Status
    [Arguments]                    ${status_esperado}
    # Compara o status da última resposta com o esperado
    Should Be Equal As Integers    ${ULTIMA_RESPOSTA.status_code}    ${status_esperado}