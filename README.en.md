<div align="center">

# Panorama — Skill for AI agents

A universal skill that generates and maintains the `panorama-atual.md` file: an always-up-to-date summary of a project's real state — current phase, what is implemented, what is missing, and standing decisions.

[![Claude Code](https://img.shields.io/badge/Claude%20Code-Anthropic-purple?style=flat-square)](https://claude.ai)
[![OpenCode](https://img.shields.io/badge/OpenCode-CLI-gray?style=flat-square)](https://opencode.ai)
[![Cursor](https://img.shields.io/badge/Cursor-AI%20IDE-orange?style=flat-square)](https://cursor.sh)
[![Codex CLI](https://img.shields.io/badge/Codex%20CLI-OpenAI-green?style=flat-square)](https://github.com/openai/codex)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)
[![skills.sh](https://skills.sh/b/ctecservice/panorama-skill)](https://skills.sh/ctecservice/panorama-skill)

**Languages / Idiomas:** [English](README.en.md) · [Português](README.md)

</div>

---

## Table of contents

- [What is it](#what-is-it)
- [Why use it](#why-use-it)
- [Installation](#installation)
  - [Claude Code](#claude-code)
  - [OpenCode](#opencode)
  - [Cursor](#cursor)
  - [Codex CLI](#codex-cli)
  - [Other agents](#other-agents)
- [Usage](#usage)
- [Examples](#examples)
- [Repository structure](#repository-structure)
- [Continuous maintenance](#continuous-maintenance)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## What is it

The panorama skill keeps a single file in the repository — `panorama-atual.md` — that answers in seconds: how the project is doing, what has been done, what is missing, and which standing decisions shape it.

Works with any AI agent that supports skills or instruction files: **Claude Code**, **OpenCode**, **Cursor**, **Codex CLI**, and others. Independent of language, framework, or project structure.

### What are Agent Skills?

Agent Skills are folders of instructions and resources that AI agents load on demand to perform specialized tasks. Learn more:

- [What are skills? (Anthropic)](https://support.claude.com/en/articles/12512176-what-are-skills)
- [OpenCode Skills](https://opencode.ai/docs/skills/)
- [Agent Skills Standard](https://agentskills.io)

## Why use it

- **Fast onboarding**: in ~30 seconds of reading, you (or any agent) understand the project state.
- **Reliable memory**: the consolidated state lives in the repository, not in the developer's head.
- **Maintenance discipline**: a clear rule to update the panorama in the same commit as every relevant change.
- **Standardization**: all your projects share the same status format.

## Installation

Pick the agent you use.

### Claude Code

Copy the skill folder to `~/.claude/skills/`:

```bash
# Windows (PowerShell)
Copy-Item -Recurse .\panorama-skill "$env:USERPROFILE\.claude\skills\panorama-skill"
# macOS/Linux
cp -r panorama-skill ~/.claude/skills/
```

The skill activates automatically when the prompt matches.

### OpenCode

Copy it to `~/.agents/skills/` (auto-loaded) or `~/.config/opencode/skills/`:

```bash
# Windows (PowerShell)
Copy-Item -Recurse .\panorama-skill "$env:USERPROFILE\.agents\skills\panorama-skill"
# macOS/Linux
cp -r panorama-skill ~/.agents/skills/
```

Restart OpenCode to reload skills.

> Windows: the maintainer uses `instalar-skill.bat` to copy to `%USERPROFILE%\.agents\skills\panorama-skill`.

### Cursor

Cursor uses rules, not skills. Copy the contents of `SKILL.md` into a project rule:

1. Create `.cursor/rules/panorama.mdc` in the project root.
2. Add a simple frontmatter and paste the body of `SKILL.md`:

   ```md
   ---
   description: Generates and maintains docs/panorama-atual.md
   globs: **/*
   alwaysApply: false
   ---
   ```

3. Use `@panorama` in chat or ask "generate the project panorama".

### Codex CLI (OpenAI)

Codex reads instructions through `AGENTS.md`:

1. Add to the project's `AGENTS.md`:

   ```md
   ## Project status
   - Keep `panorama-atual.md` up to date: use the `panorama` skill
     (contents at ~/.agents/skills/panorama-skill/SKILL.md) to generate/update
     the file in the same commit as every relevant change.
   ```

2. Ask "update the panorama using the panorama skill".

### Other agents

Any agent that accepts instructions: use `SKILL.md` as the instruction/knowledge and `templates/panorama-atual.template.md` as the mold for the generated file.

## Usage

Ask in natural language — examples:

| Tool | Example prompt |
|---|---|
| Claude Code / OpenCode | "Use the panorama skill to generate the project status" or "generate the project panorama" |
| Cursor | "@panorama generate the project panorama" |
| Codex CLI | "Update docs/panorama-atual.md following the panorama skill" |
| Any agent | "Create panorama-atual.md with current phase, implemented, pending, and decisions, following the template" |

The skill explores the code, reads the plan/roadmap docs, cross-references the phases, and generates (or updates) the file with verified facts.

## Examples

Example of a `panorama-atual.md` generated by the skill in a Node.js project:

```markdown
# Panorama Atual — App de Pedidos

**Última atualização:** 10/08/2026

## Decisões vigentes
- Backend em Node.js/Express; sem ORM por enquanto.
- Sem repo git próprio nesta fase (monorepo da equipe).

## Fase atual
**Fase 2 — Checkout** — carrinho, cálculo de frete e integração com gateway de pagamento.
Próxima fase: **Fase 3 — Rastreamento** (status do pedido e notificações).

## Implementado
### Core — `src/`
| Módulo | Responsabilidade |
|---|---|
| `server.js` | Bootstrap do Express e rotas |
| `pedidoService.js` | Regras de negócio de pedidos |

### Testes
**42 testes verdes** em 3 arquivos: `pedido.test.js` (28), `frete.test.js` (10), `auth.test.js` (4).

## Pendente (roadmap)
| Fase | Status | Observação |
|---|---|---|
| **Fase 1 — Catálogo** | Concluída | — |
| **Fase 2 — Checkout** | Parcial | Falta integração com gateway |
| **Fase 3 — Rastreamento** | Não iniciada | — |
```

> The example keeps the generated file's original language (Portuguese). The skill writes in the project's language, which may be anything.

## Repository structure

```
panorama-skill/
├── SKILL.md                          # skill instructions (Claude Code, OpenCode)
├── templates/
│   └── panorama-atual.template.md    # mold for the panorama file
├── instalar-skill.bat                # quick install on Windows (OpenCode)
├── README.md                         # Portuguese (pt-BR, official)
├── README.en.md                      # this file (English)
└── LICENSE                           # MIT
```

## Continuous maintenance (recommended)

Add to each project's `AGENTS.md`:

> `panorama-atual.md` is the project's status base file: every relevant implementation, fix, or decision must update it in the same commit, using the `panorama` skill.

The file is generated in the workspace root by default. If you want a different path/name (e.g., `docs/panorama-atual.md`), state it explicitly in the project's `AGENTS.md` — the skill follows what is defined there.

This way any agent keeps the panorama up to date automatically.

## Troubleshooting

### The agent does not load the skill
- Make sure `SKILL.md` exists at the root of the skill folder.
- Check the YAML frontmatter (`name` and `description` are required).
- Restart the agent after installing the skill.

### The skill is not triggered by the prompt
- Use trigger keywords: "panorama", "project status", "what is missing".
- In Cursor, mention `@panorama` explicitly in the chat.

### The panorama file is not updated in the commit
- Make sure the maintenance rule is in the project's `AGENTS.md` (see [Continuous maintenance](#continuous-maintenance)).

## License

MIT — see [LICENSE](LICENSE).
