# novo-teste-aes-simple01

Projeto de teste da software factory. Ainda sem código: a primeira issue define a stack.

## Setup de um checkout novo

- Node (quando existir `package.json`): `npm ci` (ou `npm install` se não houver lockfile).
- Não há arquivos `.env` a copiar por enquanto.

## Dev server

Ainda não há. Quando houver, deve aceitar a porta por `PORT` (a fábrica usa 5300+ por job, ver `factory/config.json`).

## Validação

`bash factory/checks.sh` roda, se existirem: `npm run lint`, `typecheck`, `test`, `build` e `pytest`.
Ao criar o projeto, defina esses scripts em `package.json` para o gate ter o que verificar.

## Software factory

`/factory run` builds every open GitHub issue labeled `factory` through
intake → spec → build → gate → review → approve, one PR per issue. State is in
`factory/jobs/` (gitignored); `factory/bin/job` is its only writer. Checks:
`factory/checks.sh`. Dashboard: `cd factory && python3 -m http.server`, then
open http://localhost:8000/dashboard.html.

Each job works in its own git worktree, a full checkout of the repo at
`.worktrees/<job-id>` (gitignored). A tool run from the repo root that doesn't
read `.gitignore` sees those copies too; exclude `.worktrees/` in its config.
