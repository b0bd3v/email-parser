# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## Ambiente de desenvolvimento

Executando aplicação em ambiente de desenvolvimento:

```bash
bin/dev
```
Executando dessa forma, o Rails irá iniciar os processos definidos no arquivo `Procfile.dev`. O que inclui:

- `web`: Inicia o servidor Rails
- `css`: Inicia o processador de CSS (Tailwind), que irá compilar os arquivos CSS toda vez que houver alterações.

