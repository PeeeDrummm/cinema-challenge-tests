<p align="center">
  <h1 align="center">🎬 Cinema Challenge | Automação de Testes</h1>
  <h3 align="center">🔍 Testes funcionais robustos com Robot Framework + GitHub Actions</h3>
</p>

<p align="center">
  <a href="https://github.com/PeeeDrummm/cinema-challenge-tests/actions/workflows/ci-cd-pipeline.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/PeeeDrummm/cinema-challenge-tests/ci-cd-pipeline.yml?branch=develop&style=for-the-badge&logo=github-actions&logoColor=white&label=CI/CD%20Pipeline" alt="CI/CD Status" />
  </a>
  <img src="https://img.shields.io/badge/Robot%20Framework-333333?style=for-the-badge&logo=robotframework&logoColor=white" />
  <img src="https://img.shields.io/badge/Playwright-45ba4b?style=for-the-badge&logo=playwright&logoColor=white" />
  <img src="https://img.shields.io/badge/python-3.11-3776AB?style=for-the-badge&logo=python&logoColor=white" />
</p>

---

## 🚀 Sobre o Projeto

Este repositório contém os **testes automatizados** para o projeto [Cinema Challenge Front](https://github.com/juniorschmitz/cinema-challenge-front) + [Cinema Challenge Back](https://github.com/juniorschmitz/cinema-challenge-back), utilizando Robot Framework com integração contínua via GitHub Actions.  

A pipeline cobre testes funcionais completos, garantindo qualidade e robustez para o backend (API REST) e o frontend da aplicação.

---

<p align="center">
  <img src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExeDE5b2xhOHo4Znc1d3BtOW54dm0xajYxamdqZmVlb3l5bGp1aG1nNiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gG6OcTSRWaSis/giphy.gif" width="500" />
</p>

---

## 📊 Status e Relatórios

| Recurso | Link |
|---------|------|
| 🔥 **Status da Pipeline** | [![Status](https://img.shields.io/github/actions/workflow/status/PeeeDrummm/cinema-challenge-tests/ci-cd-pipeline.yml?branch=develop&logo=github)](https://github.com/PeeeDrummm/cinema-challenge-tests/actions/workflows/ci-cd-pipeline.yml) |
| 📑 **Relatório Completo** | [📊 report.html](https://peeedrummm.github.io/cinema-challenge-tests/report.html) |
| 📝 **Log Detalhado** | [📄 log.html](https://peeedrummm.github.io/cinema-challenge-tests/log.html) |

---

<details open>
  <summary>🔨 <strong>Tecnologias Utilizadas</strong></summary>

  - 🐍 **Python 3.11**
  - 🤖 **Robot Framework**
  - 🌍 **Robot Framework Browser (Playwright)**
  - 🚀 **GitHub Actions (CI/CD)**
  - 📊 **GitHub Pages**
  - 📦 **MongoDB**
  - 🔑 **JWT Authentication**
</details>

---

<details>
  <summary>⚡ <strong>Como Executar os Testes Localmente</strong></summary>

```bash
# Clone o repositório
git clone https://github.com/PeeeDrummm/cinema-challenge-tests.git
cd cinema-automation

# Ambiente virtual
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows

# Dependências
pip install -r requirements.txt
rfbrowser init

# Executar testes
robot --outputdir logs tests/
```

</details>

---

## 🧩 Estrutura do Projeto

```bash
cinema-challenge-tests/
├── cinema-automation/
│   ├── tests/                  # Testes automatizados
│   ├── logs/                   # Logs (não versionado)
│   └── requirements.txt        # Dependências
├── .github/workflows/          # CI/CD e GitHub Pages
└── README.md                   # Este documento
```

---

## 🌟 Recursos da Pipeline Automatizada

- 🔄 Push na branch `develop` dispara testes automaticamente.
- ✅ Se os testes passarem, a pipeline mescla automaticamente o código na branch `main`.
- 🌐 Relatórios automáticos publicados no GitHub Pages.

---

## 🔐 Secrets Necessários (GitHub)

| Secret | Descrição |
|--------|-----------|
| `MONGO_URI` | URI do MongoDB |
| `JWT_SECRET` | Chave secreta JWT |
| `PAT` | Token de acesso ao repositório |
| `GEMINI_API_KEY` | Chave API Google Gemini LLM |

---

## 🤝 Contribuindo

Pull requests são bem-vindas. Para mudanças maiores, por favor abra uma issue primeiro para discutir o que você gostaria de alterar.

---

## 📄 Licença

Distribuído sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

<p align="center">
  <img src="https://media.giphy.com/media/ZVik7pBtu9dNS/giphy.gif" width="60"/><br>
  Feito com ❤️ por <b><a href="https://github.com/PeeeDrummm">Pedro Afonso</a></b>
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/pedro-afonso-a-silva/">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />
  </a>
  <a href="https://github.com/PeeeDrummm">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" />
  </a>
</p>
