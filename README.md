# Email Parser

Aplicação Ruby on Rails para processamento e extração de dados de emails.

## 🚀 Como executar

1. **Configure as variáveis de ambiente**
   Crie o arquivo `.env.docker` na raiz do projeto com o seguinte conteúdo:

   ```bash
   RAILS_ENV=production
   DB_HOST=database
   DB_PORT=5432
   DB_USERNAME=postgres
   DB_PASSWORD=postgres
   REDIS_HOST=redis
   REDIS_PORT=6379
   DATABASE_URL=postgresql://postgres:postgres@database-email-parser:5432/email_parser_development
   REDIS_URL=redis://redis-email-parser:6379/0
   SECRET_KEY_BASE=cdd3581372c7dd9a5d41fc280c26e2cb247988206d98207432d696750a53add9e710567c5d34c641aa6ecf1bf09282e00100d325d66ad163619e721e3c81bb88
   GEMINI_API_KEY=[Vai estar no e-mail]
   ```

2. **Inicie o ambiente**
   ```bash
   docker compose --profile production up
   ```

A aplicação estará disponível em [http://localhost:3000](http://localhost:3000).

## 🧠 Funcionalidade de IA

Foi implementada essa funcionalidade como uma forma de obter dados de emails que não tem padrão definido.

## 🧪 Testes

Para executar a suíte de testes (RSpec):

```bash
docker compose --profile test up
```

## Serviços

- **Web**: Aplicação Rails.
- **Sidekiq**: Processamento de jobs em segundo plano (processamento de emails).
- **Database**: PostgreSQL 15.
- **Redis**: Redis 7 (para Sidekiq e cache).
