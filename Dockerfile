# Etapa 1: Escolher a imagem base oficial do Python
# Usamos a versão 'slim' para manter a imagem final o menor possível.
FROM python:3.11-slim

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
# Isso garante que os comandos subsequentes sejam executados neste diretório.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências e instalá-las
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o restante do código da aplicação
COPY . .

# Etapa 5: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 6: Definir o comando para iniciar a aplicação com Uvicorn
# Usamos --host 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "127.0.0.1", "--port", "8000", "--reload"]