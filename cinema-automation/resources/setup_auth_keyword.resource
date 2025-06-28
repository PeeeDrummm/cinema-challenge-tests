*** Settings ***
Documentation    Keywords para o Endpoint de Autenticação  

Library          RequestsLibrary
Library          Collections

*** Keywords ***
Registrar um Novo Usuário
    # Monta o corpo com dados fixos para o registro
    ${body}=    Create Dictionary
    ...         name=João da Silva
    ...         email=joao.silva10@teste.com
    ...         password=senha123
    
    # Executa o POST e salva a última resposta na suíte
    ${response}=    POST           ${BASE_API_URL}/auth/register    json=${body}
    Set Suite Variable             ${ULTIMA_RESPOSTA}               ${response}
    RETURN                         ${response}

Salvar Token De Autenticação
    # Converte a resposta em dicionário e salva o token para uso posterior
    ${json}=              Convert To Dictionary    ${ULTIMA_RESPOSTA.json()}
    Set Suite Variable    ${TOKEN}                 ${json["data"]["token"]}