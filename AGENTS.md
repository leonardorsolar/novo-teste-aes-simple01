# novo-teste-aes-simple01

Projeto de teste da software factory. Stack: Node + Express (CommonJS).

## Estrutura

- `src/app.js`: cria e exporta o app Express (não abre porta).
- `src/server.js`: ponto de entrada; chama `listen` na porta `PORT` (padrão 3000).
- `test/`: testes com `node:test`.

## Setup de um checkout novo

- Node (quando existir `package.json`): `npm ci` (ou `npm install` se não houver lockfile).
- Não há arquivos `.env` a copiar por enquanto.

## Dev server

`PORT=<porta> npm start`. A porta vem de `PORT` (padrão 3000; a fábrica usa 5300+ por job, ver `factory/config.json`).

## Validação

`bash factory/checks.sh` roda, se existirem: `npm run lint`, `typecheck`, `test`, `build` e `pytest`.
Hoje o projeto define só `test`, então a validação roda `npm test` (`node --test`).

## Software factory

`/factory run` builds every open GitHub issue labeled `factory` through
intake → spec → build → gate → review → approve, one PR per issue. State is in
`factory/jobs/` (gitignored); `factory/bin/job` is its only writer. Checks:
`factory/checks.sh`. Dashboard: `cd factory && python3 -m http.server`, then
open http://localhost:8000/dashboard.html.

Each job works in its own git worktree, a full checkout of the repo at
`.worktrees/<job-id>` (gitignored). A tool run from the repo root that doesn't
read `.gitignore` sees those copies too; exclude `.worktrees/` in its config.
