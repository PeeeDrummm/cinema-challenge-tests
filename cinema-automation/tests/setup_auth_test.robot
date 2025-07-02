*** Settings ***
Documentation    Testes para o Endpoint de Autenticação  

Resource       ../resources/base.resource
Resource       ../resources/setup_auth_keyword.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Criar um novo usuário com dados válidos e únicos
    [Tags]    API    CT001
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Registrar um Novo Usuário             Pedro Afonso    pedro.teste@qa.com    senha123    valido
    Validar Código de Status    201    
    # Analisar e Validar Resposta com IA    201    O registro do usuário foi bem-sucedido e um token foi retornado.

Realizar Login com Credenciais Válidas
    [Tags]    API    CT005
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Realizar Login
    Validar Código de Status    200
    # Analisar e Validar Resposta com IA    200    O login do usuário foi bem-sucedido e um token foi retornado.

Acessar Rota Protegida Após Logout
    [Tags]    API    CT009
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Realizar Login
    # Analisar e Validar Resposta com IA    200    O login do usuário foi bem-sucedido e um token foi retornado.
    Validar Código de Status    200
    Salvar Token de Autenticação
    Simular Logout (Descarta o Token)
    Validar Código de Status    401
    # Analisar e Validar Resposta com IA    401    Usuário Não Autorizado/Not authorized to access this route para acessar o endpoint.