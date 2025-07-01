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