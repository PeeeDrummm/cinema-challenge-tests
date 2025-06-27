*** Settings ***
Documentation       Page Object da Página de Seleção de Assentos e Reserva.

Library             Browser

*** Variables ***
${GRID_SESSOES}           css=.session-times
${BOTAO_PRIMEIRA_SESSAO}    css=.session-times button:first-of-type
${GRID_ASSENTOS}          css=.seat-selection
${BOTAO_RESERVAR}         xpath=//button[text()="Reservar Assentos"]
${TITULO_CHECKOUT}        xpath=//h2[text()="Checkout"]

*** Keywords ***