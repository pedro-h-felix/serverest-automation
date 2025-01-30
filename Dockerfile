# Usar a imagem base com Python 3.12.5
FROM python:3.12.5-slim

# Instalar dependências do Robot Framework e outras bibliotecas necessárias
RUN pip install --no-cache-dir robotframework

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos de teste e recursos para o container
COPY ./frontend/tests /app/frontend/tests
COPY ./frontend/resources /app/frontend/resources
COPY ./api/tests /app/api/tests
COPY ./api/resources /app/api/resources

# Instalar dependências adicionais do requirements.txt (se houver)
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

# Definir o comando padrão para rodar os testes
CMD ["robot", "/app/frontend/tests", "/app/api/tests"]
