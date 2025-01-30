# 🏗️ Projeto de Testes Automatizados com Robot Framework

Este repositório contém um conjunto de testes automatizados utilizando o **Robot Framework**, dividido em **testes de API** e **testes de frontend**. O projeto abrange três cenários principais:

- 🔑 **Login**
- 👤 **Usuários**
- 📦 **Produtos**

A estrutura do repositório foi projetada para melhor organização e clareza, separando os arquivos em:
- **`resources`**: Contém palavras-chave reutilizáveis e configurações gerais.
- **`tests`**: Contém os casos de teste propriamente ditos.

Foram implementados testes utilizando diferentes abordagens e estilos para maior flexibilidade e aprendizado.
Lembrando que o ServeRest é uma aplicação dinamica que pode haver mudanças devido ao fluxo de pessoas testando simultaneamente.

---

## 🚀 Tecnologias Utilizadas
- **Python** 3.12.5
- **Pip** 25.0
- **Robot Framework**
- **SeleniumLibrary** (para testes frontend)
- **RequestsLibrary** (para testes API)
- **FakerLibrary** (para geração de dados dinâmicos)
- **Docker** (para execução isolada dos testes)

---

## 📦 Instalação

### 1️⃣ Clonar o repositório
```bash
 git clone https://github.com/pedro-h-felix/serverest-automation.git
 cd serverest-automation
```

### 2️⃣ Criar um ambiente virtual (opcional, mas recomendado)
```bash
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate  # Windows
```

### 3️⃣ Instalar as dependências
```bash
pip install -r requirements.txt
```
Caso não tenha um `requirements.txt`, instale manualmente:
```bash
pip install robotframework selenium robotframework-seleniumlibrary robotframework-requests robotframework-faker
```

---

## 🏗️ Estrutura do Repositório
```
serverest-automation/
│
├── .gitignore              # Arquivos a serem ignorados pelo Git
├── Dockerfile              # Arquivo de configuração do Docker
├── .dockerignore           # Arquivos a serem ignorados pelo Docker
├── requirements.txt        # Dependências de Python
├── frontend/               # Testes de Frontend
│   ├── tests/
│   │   ├── login_test.robot
│   │   ├── product_test.robot
│   │   └── register_test.robot
│   ├── resources/
│   │   ├── frontend_login_resources.robot
│   │   ├── frontend_product_resources.robot
│   │   ├── frontend_register_resources.robot
│   │   └── variables.robot
├── api/                    # Testes de API
│   ├── tests/
│   │   ├── login_test.robot
│   │   ├── products_test.robot
│   │   └── users_test.robot
│   ├── resources/
│   │   ├── api_resources_login.robot
│   │   ├── api_resources_products.robot
│   │   ├── api_resources_users.robot
│   │   └── variables.robot
├── logs/                   # Resultados dos testes
│   ├── log.html
│   ├── output.xml
│   ├── report.html
│   ├── interactive_console_output.xml
└── README.md               # Documentação do repositório
```

---

## 🏃‍♂️ Executando os Testes

### 🎭 Testes de Frontend
Para executar cada um dos testes de frontend, utilize os seguintes comandos:

📌 **Login**
```bash
robot frontend/tests/login_test.robot
```
📌 **Produtos**
```bash
robot frontend/tests/product_test.robot
```
📌 **Cadastro de Usuários**
```bash
robot frontend/tests/register_test.robot
```

### 🔗 Testes de API
📌 **Login**
```bash
robot api/tests/login_test.robot
```
📌 **Produtos**
```bash
robot api/tests/products_test.robot
```
📌 **Usuários**
```bash
robot api/tests/users_test.robot
```

---

## 🐳 Executando os Testes com Docker

O uso do Docker permite isolar o ambiente de testes, garantindo que todas as dependências sejam instaladas corretamente e evitando conflitos com outras versões de bibliotecas.

### 1️⃣ Construir a imagem Docker
```bash
docker build -t robot-tests .
```

### 2️⃣ Executar os testes dentro do container
```bash
docker run --rm robot-tests
```

Caso queira rodar testes específicos, utilize:
```bash
docker run --rm robot-tests robot frontend/tests/login_test.robot
```

Isso garante um ambiente controlado e independente do sistema operacional local.

---

## 🤖 Considerações Finais
- Os testes são executados utilizando **Robot Framework**, garantindo uma sintaxe legível e estruturada.
- Foi utilizada a **FakerLibrary** para gerar e-mails e senhas aleatórios.
- O Selenium foi utilizado para interação com a interface de frontend.
- Para testes de API, foi empregada a **RequestsLibrary** para facilitar as chamadas HTTP.
- O Docker foi incluído para garantir a padronização e facilitar a execução dos testes.

Qualquer dúvida, sinta-se à vontade para abrir uma issue! 🚀

