from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from pymongo import MongoClient

# Conexão com MongoDB Atlas
client = MongoClient("mongodb+srv://Pedrum2025:lvUMqoXAGsCm9jjW@cluster0.xll4lik.mongodb.net/cinemaapp?retryWrites=true&w=majority&appName=Cluster0")

db = client["cinemaapp"]
users = db["users"]

@keyword("Remover Usuário do Banco de Dados")
def remove_user(email):
    result = users.delete_many({"email": email})
    msg = f"Usuário(s) com email '{email}' removido(s): {result.deleted_count}"
    print(msg)
    BuiltIn().log(msg, level="INFO")