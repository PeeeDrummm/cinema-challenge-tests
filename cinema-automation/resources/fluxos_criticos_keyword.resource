*** Settings ***
Documentation    Keywords de Fluxo Completo de Reserva:
...              Fazer login
...              navegar até um filme
...              selecionar uma sessão
...              escolher um assento disponível
...              e verificar se chegou à tela de resumo.

Resource        ./base.resource

*** Keywords ***
Ir para Página de Login
    # Clica no Botão de Login
    Get Text    css=header a[href="/login"]    ==    Login
    Click       css=header a[href="/login"]
    Wait For Elements State    css=.login-container    visible

Efetuar Login    # Recebe o E-mail e Senha
    [Arguments]    ${EMAIL_LOGIN}    ${SENHA_LOGIN}
    Fill Text      id=email          ${EMAIL_LOGIN}
    Fill Text      id=password       ${SENHA_LOGIN}

    Get Text       css=.login-btn    ==    Entrar
    Click          css=.login-btn

Validar Alerta Contendo Mensagem    # Valida se o elemento .alert-contet contém a mensagem recebida
    [Arguments]    ${mensagem_esperada}
    Wait For Elements State    css=div.alert-content    visible
    Get Text                   css=div.alert-content    ==    ${mensagem_esperada}

Ir para Página de Filmes em Cartaz
    # Clica no Botão Filmes em Cartaz
    Click                      css=header a[href="/movies"]
    Wait For Elements State    css=.movies-container    visible

Selecionar Filme
    # Vai clicar no botão "Ver Detalhes" de um filme conforme o índice recebido
    [Arguments]                ${indice}
    ${seletor}=                Set Variable        css=div.movie-card:nth-child(${indice}) > div:nth-child(2) > a:nth-child(5)
    Wait For Elements State    ${seletor}          visible
    Get Text                   ${seletor}    ==    Ver Detalhes
    Click                      ${seletor}
    Wait For Elements State    css=.movie-detail-header    visible

Selecionar Sessão
    # Vai clicar no botão "Selecionar Assentos" de um filme conforme o índice recebido
    [Arguments]                ${indice}
    ${seletor}=                Set Variable        css=div.session-date-group:nth-child(1) > div:nth-child(2) > div:nth-child(${indice}) > a:nth-child(2)
    Wait For Elements State    ${seletor}          visible
    Get Text                   ${seletor}    ==    Selecionar Assentos
    Click                      ${seletor}
    Wait For Elements State    css=.seat-selection-container    visible

    # Valida se tem assentos disponíveis
    ${assentos_disponiveis}=   Get Element Count              css=button:not(.occupied)
    Should Be True             ${assentos_disponiveis} > 0    Nenhum assento disponível nesta sessão!

Selecionar Assento
    # Recebe o Assento que o usuário passar - Se já selecionado o teste falha.
    [Arguments]    @{assentos}

    FOR    ${assento}    IN    @{assentos}
        ${linha}=         Set Variable                  ${assento}[0]
        ${coluna}=        Set Variable                  ${assento}[2]
        ${linha_num}=     Converter Letra Para Linha    ${linha}

        ${seletor}=       Set Variable                   css=div.seat-row:nth-child(${linha_num}) > div:nth-child(2) > button:nth-child(${coluna})
        ${classe}=        Get Attribute                  ${seletor}    class

        Run Keyword If    'occupied' in '${classe}'      Fail    Assento ${linha}${coluna} está ocupado!
        Click             ${seletor}
    END

    # Prossegue para o pagamento se os assentos recebidos estiverem disponiveis
    Get Text    css=.checkout-button    ==    Continuar para Pagamento
    Click       css=.checkout-button

    Wait For Elements State    css=.payment-section    visible

Converter Letra Para Linha
    # Converte A1 para 1 1 / B1 para 2 1...
    [Arguments]    ${letra}
    ${letras}=     Create List    A    B    C    D    E    F    G    H    I    J    K    L    M    N    O    P    Q    R    S    T    U    V    W    X    Y    Z
    ${indice}=     Evaluate       ${letras}.index("${letra}") + 1
    RETURN         ${indice}

Selecionar Método de Pagamento e Finalizar
    [Arguments]    ${metodo}

    ${mapa_metodos}=    Create Dictionary
    ...                 Cartão de Crédito=1
    ...                 Cartão de Débito=2
    ...                 PIX=3
    ...                 Transferência Bancária=4

    ${indice}=    Get From Dictionary    ${mapa_metodos}    ${metodo}
    ${seletor}=   Set Variable           css=.payment-section div.payment-method:nth-child(${indice})

    Wait For Elements State    ${seletor}    visible
    Click                      ${seletor}

    # Clica no botão Finalizar
    Get Text    css=.btn    ==    Finalizar Compra
    Click       css=.btn

    # Valida se a reserva foi confirmada com sucesso e armazena o código da reserva
    # O Código da reserva deve possuir 24 caracteres
    Wait For Elements State    css=.confirmation-header > h1:nth-child(2)    visible
    Get Text                   css=.confirmation-header > h1:nth-child(2)    ==    Reserva Confirmada!

    ${reserva_id}=            Get Text    css=.confirmation-info .info-item span.info-value >> nth=0
    Length Should Be          ${reserva_id}    24
    Log To Console            Código da reserva gerado: ${reserva_id}
    Set Suite Variable        ${RESERVA_ID}    ${reserva_id}

Ir Para Página de Minhas Reservas
    # Clica no Botão de Minhas Reservas
    Get Text    css=header a[href="/reservations"]    ==    Minhas Reservas
    Click       css=header a[href="/reservations"]
    Wait For Elements State    css=.reservations-page    visible
    Wait For Elements State    css=.reservations-list    visible

Validar Reservas
    Wait For Elements State    css=.reservations-list    visible
    ${total}=    Get Element Count    css=.reservation-card
    Should Be True    ${total} > 0    msg=Usuário não possui nenhuma reserva!

    Log To Console    \n🔎 Total de reservas: ${total}
    FOR    ${i}    IN RANGE    1    ${total + 1}
        ${reserva_id}=         Get Text    css=div.reservation-card:nth-child(${i}) h3
        ${status}=             Get Text    css=div.reservation-card:nth-child(${i}) .status-badge
        ${filme}=              Get Text    css=div.reservation-card:nth-child(${i}) .reservation-details h4
        ${data}=               Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[1]/span
        ${hora}=               Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[2]/span
        ${sala}=               Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[3]/span
        ${assentos}=           Get Text    xpath=(//div[@class="reservation-card"][${i}]//div[contains(@class,"detail-item")])[4]/span
        ${preco}=              Get Text    css=div.reservation-card:nth-child(${i}) .price-info .price
        ${pagamento}=          Get Text    css=div.reservation-card:nth-child(${i}) .payment-info span:nth-child(2)

        Log To Console    \n🔹 Reserva ${i}
        Log To Console    ID: ${reserva_id}
        Log To Console    Status: ${status}
        Log To Console    Filme: ${filme}
        Log To Console    Data: ${data}
        Log To Console    Horário: ${hora}
        Log To Console    Sala: ${sala}
        Log To Console    Assentos: ${assentos}
        Log To Console    Preço: ${preco}
        Log To Console    Pagamento: ${pagamento}
    END