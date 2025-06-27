*** Settings ***
Documentation       Esta suíte de testes valida a funcionalidade de gerenciamento de filmes via API.
...                 Ela foca em cenários de criação e acesso por diferentes perfis de usuário.

Resource            ../../resources/api/auth_keywords.resource
Resource            ../../resources/api/movies_keywords.resource
Variables           ../../variables/local_env.py

Suite Setup         Criar Sessão da API

*** Test Cases ***