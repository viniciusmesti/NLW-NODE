# NLW Connect

Este projeto é uma API construída com Fastify (em TypeScript) para gerenciar inscrições em um evento, além de fornecer um sistema de referral (convites) com estatísticas de cliques e ranking de usuários.

## Tecnologias

- **Fastify** + **TypeScript**
- **Zod** para validação de schemas
- **Redis** (gerenciado via ioredis) para contagem de convites
- **PostgreSQL** (configuração via Drizzle, opcional)
- **Swagger** para documentação da API

## Rotas Principais

- `POST /subscriptions` - Cria uma nova inscrição. Recebe `name`, `email` e opcionalmente `referrer` para associar o inscrito a quem o convidou.
- `GET /invites/:referrerId` - Retorna (ou redireciona) o link de convite associado a determinado usuário.
- `GET /subscribers/:subscriberId/ranking/clicks` - Retorna quantos cliques de convite foram gerados por esse inscrito.
- `GET /subscribers/:subscriberId/ranking/count` - Retorna quantos inscritos (ou convites) foram gerados por esse inscrito.
- `GET /subscribers/:subscriberId/ranking/position` - Retorna a posição do inscrito no ranking geral.
- `GET /ranking` - Retorna o ranking completo dos inscritos.

Para facilitar o teste dessas rotas, o arquivo **api.http** contém requisições de exemplo que podem ser executadas via **REST Client** no VS Code.

## Estrutura de Pastas

```
.
├── dist/                 # Build gerado (caso utilize TypeScript)
├── node_modules/         # Dependências
├── src/
│   ├── drizzle/          # Configurações de migrations (Postgres)
│   │   ├── migrations/
│   │   └── schema/
│   ├── functions/        # Funções de lógica de negócio
│   ├── redis/            # Conexão e setup do Redis
│   ├── routes/           # Declaração das rotas Fastify
│   ├── env.ts            # Validação e export das variáveis de ambiente
│   └── server.ts         # Arquivo principal para subir o servidor
├── .env                  # Variáveis de ambiente
├── docker-compose.yml    # (Opcional) Configuração de containers para Redis/Postgres
├── package.json
├── tsconfig.json
└── ...
```

## Variáveis de Ambiente

O arquivo **env.ts** utiliza o **Zod** para validar as variáveis:

- `PORT`: Porta para rodar a aplicação (padrão 3333)
- `POSTGRES_URL`: URL de conexão com o Postgres
- `REDIS_URL`: URL de conexão com o Redis
- `WEB_URL`: URL da aplicação web (caso exista uma parte frontend)

Crie um arquivo `.env` na raiz do projeto e defina esses valores, por exemplo:

```ini
PORT=3333
POSTGRES_URL=postgres://user:password@localhost:5432/db_name
REDIS_URL=redis://localhost:6379
WEB_URL=http://localhost:3000
```

## Como Rodar Localmente

### 1. Instale as dependências

```bash
npm install
# ou
yarn
```

### 2. Inicie o Redis e o Postgres (opcional, se quiser usar bancos locais)

Se estiver usando Docker, basta rodar:

```bash
docker-compose up -d
```

Ou inicie manualmente:

```bash
redis-server
# e
pg_ctl start  # ou outro comando equivalente
```

### 3. Configure as variáveis de ambiente

Edite o arquivo `.env` com suas credenciais (PORT, POSTGRES_URL, etc.).

### 4. Execute o projeto

```bash
npm run dev
```

Se estiver tudo correto, o servidor iniciará na porta configurada (padrão 3333).

### 5. Acesse a documentação (Swagger)

Abra seu navegador em [http://localhost:3333/docs](http://localhost:3333/docs) para visualizar as rotas e fazer chamadas de teste.

### 6. Testando as Rotas

Você pode usar o arquivo **api.http** na raiz do projeto com a extensão **REST Client** do VS Code. Basta abrir o arquivo e clicar em `Send Request` em cada bloco de requisição para testar.
