*** Settings ***
Documentation    Keywords de Fluxo de Tratamento de Erro e Regressão.

Resource        ./base.resource

*** Keywords ***
Ir para Página de Registro
    # Clica no Botão de Cadastrar
    Get Text    css=header a[href="/register"]    ==    Cadastrar
    Click       css=header a[href="/register"]
    Wait For Elements State    css=.register-container    visible

Efetuar Registro    # Recebe o Nome, E-mail e Senha
    [Arguments]    ${NOME_REGISTRO}      ${EMAIL_REGISTRO}    ${SENHA_REGISTRO}
    Fill Text      id=name               ${NOME_REGISTRO}
    Fill Text      id=email              ${EMAIL_REGISTRO}
    Fill Text      id=password           ${SENHA_REGISTRO}
    Fill Text      id=confirmPassword    ${SENHA_REGISTRO}

    Get Text       css=button.btn    ==    Cadastrar
    Click          css=button.btn