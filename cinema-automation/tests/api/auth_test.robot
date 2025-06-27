*** Settings ***
Documentation       Esta suíte de testes valida os endpoints de autenticação da API.
...                 Cobre registro, login e validações de dados.

Resource            ../../resources/api/auth_keywords.resource
Variables           ../../variables/local_env.py

Suite Setup         Criar Sessão da API

*** Test Cases ***