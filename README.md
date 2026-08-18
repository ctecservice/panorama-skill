<div align="center">

# Panorama — Skill para agentes de IA

Skill universal que gera e mantém o arquivo `panorama-atual.md`: um resumo sempre atualizado do estado real de um projeto — fase atual, o que está implementado, o que falta e decisões vigentes.

[![Claude Code](https://img.shields.io/badge/Claude%20Code-Anthropic-purple?style=flat-square)](https://claude.ai)
[![OpenCode](https://img.shields.io/badge/OpenCode-CLI-gray?style=flat-square)](https://opencode.ai)
[![Cursor](https://img.shields.io/badge/Cursor-AI%20IDE-orange?style=flat-square)](https://cursor.sh)
[![Codex CLI](https://img.shields.io/badge/Codex%20CLI-OpenAI-green?style=flat-square)](https://github.com/openai/codex)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)
[![skills.sh](https://skills.sh/b/ctecservice/panorama-skill)](https://skills.sh/ctecservice/panorama-skill)

**Idiomas / Languages:** [Português](README.md) · [English](README.en.md)

</div>

---

## Índice

- [O que é](#o-que-é)
- [Por que usar](#por-que-usar)
- [Instalação](#instalação)
  - [Claude Code](#claude-code)
  - [OpenCode](#opencode)
  - [Cursor](#cursor)
  - [Codex CLI](#codex-cli)
  - [Outros agentes](#outros-agentes)
- [Como usar](#como-usar)
- [Exemplos](#exemplos)
- [Estrutura do repositório](#estrutura-do-repositório)
- [Manutenção contínua](#manutenção-contínua)
- [Troubleshooting](#troubleshooting)
- [Licença](#licença)

## O que é

A skill panorama mantém um único arquivo no repositório — `panorama-atual.md` — que responde em segundos: como está o projeto, o que já foi feito, o que falta fazer e quais decisões vigentes o moldam.

Compatível com qualquer agente de IA que aceite skills ou arquivos de instrução: **Claude Code**, **OpenCode**, **Cursor**, **Codex CLI** e outros. Independente de linguagem, framework ou estrutura de projeto.

### O que são Agent Skills?

Agent Skills são pastas de instruções e recursos que agentes de IA carregam sob demanda para executar tarefas especializadas. Saiba mais:

- [What are skills? (Anthropic)](https://support.claude.com/en/articles/12512176-what-are-skills)
- [OpenCode Skills](https://opencode.ai/docs/skills/)
- [Agent Skills Standard](https://agentskills.io)

## Por que usar

- **Onboarding rápido**: em ~30 segundos de leitura, você (ou qualquer agente) entende o estado do projeto.
- **Memória confiável**: o estado consolidado vive no repositório, não na cabeça de quem programa.
- **Disciplina de manutenção**: regra clara de atualizar o panorama no mesmo commit de cada mudança relevante.
- **Padronização**: todos os seus projetos com o mesmo formato de status.

## Instalação

Escolha o agente que você usa.

### Claude Code

Copie a pasta da skill para `~/.claude/skills/`:

```bash
# Windows (PowerShell)
Copy-Item -Recurse .\panorama-skill "$env:USERPROFILE\.claude\skills\panorama-skill"
# macOS/Linux
cp -r panorama-skill ~/.claude/skills/
```

A skill é ativada automaticamente quando o prompt combina.

### OpenCode

Copie para `~/.agents/skills/` (carregada automaticamente) ou `~/.config/opencode/skills/`:

```bash
# Windows (PowerShell)
Copy-Item -Recurse .\panorama-skill "$env:USERPROFILE\.agents\skills\panorama-skill"
# macOS/Linux
cp -r panorama-skill ~/.agents/skills/
```

Reinicie o OpenCode para recarregar as skills.

> Windows: o mantenedor usa `instalar-skill.bat` para copiar para `%USERPROFILE%\.agents\skills\panorama-skill`.

### Cursor

Cursor usa regras, não skills. Copie o conteúdo do `SKILL.md` para uma regra do projeto:

1. Crie `.cursor/rules/panorama.mdc` na raiz do projeto.
2. Adicione um frontmatter simples e cole o corpo do `SKILL.md`:

   ```md
   ---
   description: Gera e mantém docs/panorama-atual.md
   globs: **/*
   alwaysApply: false
   ---
   ```

3. Use com `@panorama` no chat ou peça "gere o panorama do projeto".

### Codex CLI (OpenAI)

Codex lê instruções via `AGENTS.md`:

1. Adicione ao `AGENTS.md` do projeto:

   ```md
   ## Status do projeto
   - Manter `panorama-atual.md` atualizado: usar a skill `panorama`
     (conteúdo em ~/.agents/skills/panorama-skill/SKILL.md) para gerar/atualizar
     o arquivo no mesmo commit de cada mudança relevante.
   ```

2. Peça "atualize o panorama usando a skill panorama".

### Outros agentes

Qualquer agente que aceite instruções: use o `SKILL.md` como instrução/conhecimento e `templates/panorama-atual.template.md` como molde do arquivo gerado.

## Como usar

Peça em linguagem natural — exemplos:

| Ferramenta | Exemplo de prompt |
|---|---|
| Claude Code / OpenCode | "Use a skill panorama para gerar o status do projeto" ou "gere o panorama do projeto" |
| Cursor | "@panorama gere o panorama do projeto" |
| Codex CLI | "Atualize docs/panorama-atual.md seguindo a skill panorama" |
| Qualquer agente | "Crie panorama-atual.md com fase atual, implementado, pendente e decisões, seguindo o template" |

A skill explora o código, lê os docs de plano/roadmap, cruza com as fases e gera (ou atualiza) o arquivo com fatos verificados.

## Exemplos

Exemplo de `panorama-atual.md` gerado pela skill em um projeto Node.js:

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

## Estrutura do repositório

```
panorama-skill/
├── SKILL.md                          # instruções da skill (Claude Code, OpenCode)
├── templates/
│   └── panorama-atual.template.md    # molde do arquivo de panorama
├── instalar-skill.bat                # instalação no Windows (OpenCode)
├── README.md                         # este arquivo (pt-BR, oficial)
├── README.en.md                      # inglês
└── LICENSE                           # MIT
```

## Manutenção contínua (recomendado)

Adicione ao `AGENTS.md` de cada projeto:

> `panorama-atual.md` é o arquivo-base de status: toda implementação, correção ou decisão relevante deve atualizá-lo no mesmo commit, usando a skill `panorama`.

O arquivo é gerado por padrão na raiz do workspace. Se quiser outro caminho/nome (ex.: `docs/panorama-atual.md`), deixe explícito no `AGENTS.md` do projeto — a skill segue o que estiver definido lá.

Assim qualquer agente mantém o panorama em dia automaticamente.

## Troubleshooting

### A skill não é carregada pelo agente
- Confirme que `SKILL.md` existe na raiz da pasta da skill.
- Verifique o frontmatter YAML (`name` e `description` são obrigatórios).
- Reinicie o agente após instalar a skill.

### A skill não é acionada pelo prompt
- Use palavras-chave do gatilho: "panorama", "status do projeto", "o que falta".
- No Cursor, mencione `@panorama` explicitamente no chat.

### O arquivo de panorama não é atualizado no commit
- Confirme que a regra de manutenção está no `AGENTS.md` do projeto (ver [Manutenção contínua](#manutenção-contínua)).

## Licença

MIT — veja [LICENSE](LICENSE).
