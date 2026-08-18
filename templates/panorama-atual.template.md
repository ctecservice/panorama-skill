# Panorama Atual — <NOME DO PROJETO>

Arquivo-base de status do projeto. **Regra:** toda implementação, correção ou decisão relevante deve atualizar este arquivo no mesmo commit da mudança (mantido pela skill `panorama`).

**Última atualização:** <DATA>

## Decisões vigentes

- <decisões importantes que moldam o projeto e continuam valendo>

## Fase atual

**<fase/versão atual>** — <resumo em 1-2 linhas do marco vigente e data>.

Próxima fase: **<próxima fase>** (<escopo resumido>).

## Implementado

### <Área 1 — ex.: Core — `caminho/da/pasta/`>

| Módulo | Responsabilidade |
|---|---|
| `arquivo.js` | <o que faz, em 1 linha> |

### Testes

**<N> testes verdes** em <N> arquivos: <lista por arquivo com contagens>.

Obs.: <peculiaridades — ex.: pasta de testes vazia/migrada, cobertura por área>.

### CI

<1 linha por job do workflow>.

## Pendente (roadmap)

| Fase | Status | Observação |
|---|---|---|
| **<fase 1>** | Não iniciada / Parcial / Concluída | <o que falta> |

## Como manter este arquivo

- Atualizar a cada implementação/correção/decisão relevante, no mesmo commit da mudança.
- Manter em dia: "Fase atual", "Última atualização", status das fases, contagem de testes e módulos novos.
- Detalhes de planejamento continuam nos docs de plano/roadmap; este arquivo é o resumo do estado real do código.
