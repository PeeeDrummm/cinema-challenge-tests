from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from pymongo import MongoClient
import os

# (Opcional) carrega variáveis do .env se estiver rodando localmente
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

# Pega URI do ambiente
MONGO_URI = os.getenv("MONGO_URI")
if not MONGO_URI:
    raise ValueError("❌ MONGO_URI não definida. Configure no .env ou GitHub Secrets.")

# Conecta ao MongoDB
client = MongoClient(MONGO_URI)
db = client["cinemaapp"]
users = db["users"]

@keyword("Remover Usuário do Banco de Dados")
def remove_user(email):
    result = users.delete_many({"email": email})
    msg = f"🧹 Usuário(s) com email '{email}' removido(s): {result.deleted_count}"
    print(msg)
    BuiltIn().log(msg, level="INFO")