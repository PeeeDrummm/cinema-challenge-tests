*** Settings ***
Documentation    Arquivo base com inicialização de sessão e variáveis comuns
Library          RequestsLibrary
Library          OperatingSystem
Library          Collections
Library          ../utils/db_keywords.py

*** Variables ***
${BASE_API_URL}    http://localhost:3000/api/v1    # https://cinema-challenge-back-xelh.onrender.com/api/v1

*** Keywords ***
Criar Sessão API
    # Cria uma sessão HTTP nomeada "CinemaAPP" com a URL base da API
    Create Session    CinemaAPP    ${BASE_API_URL}

Validar Código de Status
    [Arguments]                    ${status_esperado}
    # Compara o status da última resposta com o esperado
    Should Be Equal As Integers    ${ULTIMA_RESPOSTA.status_code}    ${status_esperado}
