# Este arquivo centraliza todas as variáveis de ambiente e dados de teste.
# Ele pode ser facilmente importado nos arquivos do Robot Framework.

URL_BASE = "http://localhost:3002"  # URL do Front-end
API_URL_BASE = "http://localhost:3000/api/v1" # URL do Back-end

VALID_USER = {
    "name": "Pedro QA User",
    "email": "pedro.user@test.com",
    "password": "pwd123"
}

ADMIN_USER = {
    "name": "Pedro QA Admin",
    "email": "pedro.admin@test.com",
    "password": "pwd123"
}

INVALID_CREDENTIALS = {
    "email": VALID_USER["email"],
    "password": "senha_errada"
}