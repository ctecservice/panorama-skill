---
name: panorama
description: Gera e mantém panorama-atual.md, o arquivo-base de status de um projeto (fase atual, o que está implementado, o que falta, decisões vigentes). Use quando o usuário pedir "panorama do projeto", "status das implementações", "o que falta fazer", "como está o projeto", ao iniciar trabalho num projeto sem esse arquivo, ou ao concluir implementação/correção/decisão relevante que exija atualizar o panorama no mesmo commit.
---

# Panorama — estado atual do projeto

## Objetivo

Manter um arquivo único — `panorama-atual.md` — que responde em segundos: como está o projeto, o que já foi feito, o que falta fazer e quais decisões vigentes o moldam.

## Quando usar

- O usuário pede "panorama", "status das implementações", "como está o projeto", "o que falta".
- Você começa a trabalhar num projeto que não tem o arquivo → gerar do zero.
- Você concluiu uma implementação, correção ou decisão relevante → atualizar no mesmo commit (ver "Workflow de atualização").
- O `AGENTS.md` do projeto exige manter o panorama atualizado (padrão recomendado).

## O arquivo (estrutura obrigatória)

Ordem fixa das seções — use o template `templates/panorama-atual.template.md`:

1. **Cabeçalho** — regra de manutenção + "Última atualização" com data real.
2. **Decisões vigentes** — decisões que moldam o projeto (ex.: "sem repo git próprio por enquanto").
3. **Fase atual** — versão/fase em vigor + 1-2 linhas de resumo; próxima fase com escopo resumido.
4. **Implementado** — por área: tabela de módulos (arquivo → responsabilidade em 1 linha), testes com contagem real, CI.
5. **Pendente (roadmap)** — tabela fase × status (Não iniciada / Parcial / Concluída) com observação do que falta.
6. **Como manter este arquivo** — instruções curtas.

## Local e nome do arquivo

- **Padrão:** `panorama-atual.md` na **raiz do workspace** (pasta do projeto).
- **Exceção:** se o `AGENTS.md` do projeto definir outro caminho/nome (ex.: `docs/panorama-atual.md`), use exatamente o que estiver definido lá — o `AGENTS.md` tem precedência.

## Workflow — gerar do zero

1. **Contexto do projeto**: leia o `AGENTS.md` (se existir) e os docs de plano/roadmap. Se o projeto tiver mais de uma fonte de plano, leia as duas.
2. **Coleta em paralelo** (use background/subagentes quando disponíveis — nunca faça buscas sequenciais desnecessárias):
   - Exploração do código: liste os módulos/arquivos principais e a responsabilidade de cada um (1 linha); testes e o que cobrem; CI/workflows e scripts do `package.json`.
   - Leitura dos docs de plano: fases/milestones e critérios de saída.
3. **Cruzamento**: marque cada fase do roadmap como concluída/parcial/não iniciada **com base no código**, não no plano.
4. **Escrita**: gere o arquivo no local definido (padrão: `panorama-atual.md` na raiz do workspace; se o `AGENTS.md` definir outro caminho/nome, use o definido) seguindo o template, apenas com fatos verificados.
5. **Regra no AGENTS.md**: se o projeto não tiver a regra de manutenção, adicione ao `AGENTS.md` do projeto (seção de fluxo de trabalho):
   > `panorama-atual.md` é o arquivo-base de status: toda implementação, correção ou decisão relevante deve atualizá-lo no mesmo commit, usando a skill `panorama`.
   - Se o usuário quiser o arquivo em outro lugar ou com outro nome, ele deve deixar isso **explícito no `AGENTS.md`** — a skill segue o caminho definido lá.

## Workflow — atualizar

- Mudanças pequenas (1-2 módulos, contagem de testes, decisão nova): edite apenas as seções afetadas + "Última atualização".
- Mudanças grandes (nova fase concluída, refatoração ampla): refaça o levantamento do código em vez de editar de memória.
- Atualize no **mesmo commit** da mudança que o gerou.

## Regras obrigatórias

- **Apenas fatos verificados**: nunca invente módulos, números de testes ou status; na dúvida, leia o código ou rode o runner de testes para obter a contagem real.
- **Encoding**: UTF-8 sem BOM; após gravar, verifique se acentos e caracteres especiais estão intactos.
- **Idioma**: o idioma do projeto (padrão: português do Brasil). Nomes técnicos (variáveis, módulos, ferramentas) permanecem como estão.
- **Data real** em "Última atualização" (formato DD/MM/AAAA).
- **Não substitui os docs de plano**: o panorama é o resumo do estado real; detalhes continuam no roadmap/plano — link para eles quando fizer sentido.
- Se o projeto já tiver o arquivo de panorama em outro idioma/formato/caminho, respeite o existente e o registrado no `AGENTS.md`.

## Coleta eficiente

- Paralelize: exploração de código e leitura de docs ao mesmo tempo.
- Use subagentes de exploração (ex.: explorer no opencode) para mapear o código e manter seu contexto limpo.
- Peça contagens reais (testes, arquivos) por terminal (ex.: `node --test`) em vez de estimar.
