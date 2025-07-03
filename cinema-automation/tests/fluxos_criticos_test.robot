*** Settings ***
Documentation    Testes de Fluxo Completo de Reserva:
...              Fazer login
...              navegar até um filme
...              selecionar uma sessão
...              escolher um assento disponível
...              e verificar se chegou à tela de resumo.

Resource       ../resources/base.resource
Resource       ../resources/regras_validacoes_keyword.resource
Resource       ../resources/fluxos_criticos_keyword.resource
Resource       ../resources/setup_auth_keyword.resource
Resource       ../resources/setup_admin_keyword.resource

Suite Setup       Iniciar Navegador
Suite Teardown    Fechar Navegador

*** Test Cases ***
Fluxo Reserva
    [Tags]    Front    Fluxo1
    Iniciar Página Limpa
    Ir para Página de Login
    Efetuar Login    user@example.com    senha123
    Validar Alerta Contendo Mensagem    Login realizado com sucesso!
    Ir para Página de Filmes em Cartaz
    Selecionar Filme    3
    Selecionar Sessão    3
    Selecionar Assento    D 5    F 9
    Selecionar Método de Pagamento e Finalizar    Cartão de Crédito

    # Resetar Ambiente
    Realizar Login Admin
    Salvar Token de Autenticação
    Deletar Reserva

Fluxo Histórico
    [Tags]    Front    Fluxo2
    Iniciar Página Limpa
    Ir para Página de Login
    Efetuar Login    user@example.com    senha123
    Validar Alerta Contendo Mensagem    Login realizado com sucesso!
    Ir Para Página de Minhas Reservas
    Validar Reservas