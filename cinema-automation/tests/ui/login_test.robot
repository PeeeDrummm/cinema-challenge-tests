*** Settings ***
Documentation       Esta suíte de testes valida o fluxo de login do usuário na interface do Cinema App.
...                 Ela testa o caminho feliz e os principais cenários de erro.

Resource            ../../resources/ui/login_page_keywords.resource
Resource            ../../resources/ui/common_keywords.resource
Variables           ../../variables/local_env.py

Suite Setup         Abrir Navegador e Acessar a Página de Login    url=${URL_BASE}
Suite Teardown      Fechar Navegador

*** Test Cases ***