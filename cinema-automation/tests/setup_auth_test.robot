*** Settings ***
Documentation    Testes para o Endpoint de Autenticação  

Resource       ../resources/base.resource
Resource       ../resources/setup_auth_keyword.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Criar um novo usuário com dados válidos e únicos
    [Tags]    API    CT001
    Registrar um Novo Usuário
    Validar Código de Status    201
    Salvar Token de Autenticação