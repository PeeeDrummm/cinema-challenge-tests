*** Settings ***
Documentation       Esta suíte de testes valida o fluxo principal de reserva de ingresso,
...                 desde o login até a seleção do assento, na interface do usuário.

Resource            ../../resources/ui/common_keywords.resource
Resource            ../../resources/ui/login_page_keywords.resource
Resource            ../../resources/ui/home_page_keywords.resource
Resource            ../../resources/ui/reservation_page_keywords.resource
Variables           ../../variables/local_env.py

Suite Setup         Setup do Ambiente Para Reserva
Suite Teardown      Fechar Navegador

*** Test Cases ***