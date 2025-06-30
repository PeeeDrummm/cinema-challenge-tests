*** Settings ***
Documentation    Arquivo base com inicialização de sessão e variáveis comuns
Library          RequestsLibrary
Library          OperatingSystem
Library          Collections
Library          ../utils/db_keywords.py

*** Variables ***
# Loca / Nuvem - Mudar antes de mandar para Develop
# ${BASE_API_URL}    http://localhost:3000/api/v1
${BASE_API_URL}    https://cinema-challenge-back-xelh.onrender.com/api/v1

*** Keywords ***
Criar Sessão API
    # Cria uma sessão HTTP nomeada "CinemaAPP" com a URL base da API
    Create Session    CinemaAPP    ${BASE_API_URL}

Validar Código de Status
    [Arguments]                    ${status_esperado}
    # Compara o status da última resposta com o esperado
    Should Be Equal As Integers    ${ULTIMA_RESPOSTA.status_code}    ${status_esperado}

Validar Mensagem Response
    # Valida a Mensagem de Retorno
    [Arguments]        ${mensagem_esperada}
    ${mensagem}=       Set Variable            ${ULTIMA_RESPOSTA.json()['message']}
    Should Be Equal    ${mensagem}             ${mensagem_esperada}