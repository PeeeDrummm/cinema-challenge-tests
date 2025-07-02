*** Settings ***
Documentation    Testes para o Endpoint de Regras de Negócio e Validações

Resource       ../resources/base.resource
Resource       ../resources/regras_validacoes_keyword.resource
Resource       ../resources/setup_auth_keyword.resource

Suite Setup    Criar Sessão API

*** Test Cases ***
Criar Usuário Com E-mail Existente
    [Tags]    API    CT002
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Registrar um Novo Usuário             Pedro Afonso    pedro.teste@qa.com    senha123    invalido
    Validar Código de Status              400
    Validar Mensagem Response             User already exists
    # Analisar e Validar Resposta com IA    400    Usuário já cadastrado/User already exists or invalid data

Login Com Senha Incorreta
    [Tags]    API    CT006
    Remover Usuário do Banco de Dados     pedro.teste@qa.com
    Inserir Usuário no Banco de Dados     Pedro Afonso    pedro.teste@qa.com    senha123
    Realizar Login Com Senha Incorreta
    Validar Código de Status     401
    Validar Mensagem Response    Invalid email or password
    # Analisar e Validar Resposta com IA    401    Senha incorreta/Invalid email or password

Selecionar Assento Já Ocupado
    [Tags]    API    CT018    AI
    Realizar Login Admin
    Salvar Token de Autenticação
    Obter Primeira Sessão Disponível
    Resetar Assentos Da Sessão

    # --- AÇÃO 1: CRIAR A PRIMEIRA RESERVA (bem-sucedida) ---
    Efetuar Nova Reserva    A    1
    # Validar Código de Status     201
    Analisar e Validar Resposta com IA    201    Presença de `paymentStatus: "completed"` e o campo `_id`

    # --- AÇÃO 2: TENTAR CRIAR A MESMA RESERVA NOVAMENTE ---
    Efetuar Nova Reserva    A    1
    # Validar Código de Status     400
    Analisar e Validar Resposta com IA    400    The following seats are not available: A1