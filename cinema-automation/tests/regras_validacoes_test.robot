*** Settings ***
Documentation    Testes para o Endpoint de Regras de Negócio e Validações

Resource       ../resources/base.resource
Resource       ../resources/regras_validacoes_keyword.resource
Resource       ../resources/setup_auth_keyword.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Criar Usuário Com E-mail Existente
    [Tags]    API    CT002
    Remover Usuário do Banco de Dados    pedro.teste@qa.com
    Inserir Usuário no Banco de Dados    Pedro Afonso    pedro.teste@qa.com    senha123
    Registrar um Novo Usuário    Pedro Afonso    pedro.teste@qa.com    senha123    invalido
    Validar Código de Status     400
    Validar Mensagem Response    User already exists