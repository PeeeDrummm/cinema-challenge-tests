*** Settings ***
Documentation    Arquivo base com inicialização de sessão e variáveis comuns
Library          RequestsLibrary
Library          OperatingSystem
Library          Collections
Library          JSONLibrary
Library          ../utils/db_keywords.py
Library          ../utils/GeminiValidationLibrary.py    WITH NAME    base
Library    Browser

*** Variables ***
# Loca / Nuvem - Mudar antes de mandar para Develop
# ${BASE_API_URL}    http://localhost:3000/api/v1
${BASE_API_URL}    https://cinema-challenge-back-xelh.onrender.com/api/v1
${BASE_FRONT_URL}    https://cinema-challenge-front.onrender.com/
${BROWSER}    chromium

*** Keywords ***
Criar Sessão API
    # Cria uma sessão HTTP nomeada "CinemaAPP" com a URL base da API
    Create Session    CinemaAPP    ${BASE_API_URL}

Iniciar Navegador
    New Browser    browser=${BROWSER}    headless=false
    New Page       url=${BASE_FRONT_URL}

Validar Código de Status
    [Arguments]                    ${status_esperado}
    # Compara o status da última resposta com o esperado
    Should Be Equal As Integers    ${ULTIMA_RESPOSTA.status_code}    ${status_esperado}

Analisar e Validar Resposta com IA
    # Valida o status code e o conteúdo de uma resposta usando o Gemini.
    [Arguments]    ${status_code_esperado}    ${contexto_esperado}
    
    ${analise}=    Validar Resposta Da Api Com Ia
    ...            ${ULTIMA_RESPOSTA.text}          # Argumento 1: resposta_real_api
    ...            ${ULTIMA_RESPOSTA.status_code}   # Argumento 2: status_code_real
    ...            ${status_code_esperado}          # Argumento 3: status_code_esperado
    ...            ${contexto_esperado}             # Argumento 4: contexto_esperado
    
    Log To Console    \nAnálise da IA: ${analise}

Validar Mensagem Response
    # Valida a Mensagem de Retorno
    [Arguments]        ${mensagem_esperada}
    ${mensagem}=       Set Variable            ${ULTIMA_RESPOSTA.json()['message']}
    Should Be Equal    ${mensagem}             ${mensagem_esperada}