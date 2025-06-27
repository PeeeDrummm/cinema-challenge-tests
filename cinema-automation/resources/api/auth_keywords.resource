*** Settings ***
Documentation       Este arquivo implementa a camada de serviço para a API de Autenticação.
...                 Contém keywords de alto nível para interagir com os endpoints de /auth.

Library             RequestsLibrary
Library             FakerLibrary    locale=pt_BR

*** Keywords ***