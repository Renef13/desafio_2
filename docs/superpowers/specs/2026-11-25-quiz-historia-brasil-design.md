# Quiz História do Brasil — Design

## Intenção

Entregar um jogo de perguntas e respostas em Dart para terminal, como desafio da trilha Desenvolvimento Mobile. O jogador se identifica pelo nome, responde questões sobre História do Brasil e recebe correção e pontuação.

## Objetivos

- Executar com `dart run` a partir da pasta do projeto.
- Manter perguntas e alternativas numa lista; usar `for` para apresentá-las.
- Aceitar `A` a `D`, sem distinguir maiúsculas de minúsculas, e repetir a leitura de uma resposta vazia ou inválida.
- Exibir acerto/erro, alternativa correta, pontuação e mensagem final variável.
- Usar terminal simples, sem cores ou efeitos visuais.

## Limites

- Sem interface gráfica, dependências externas, ranking persistente ou embaralhamento.
- O recurso opcional incluído será apenas jogar novamente.

## Estrutura

- `lib/quiz.dart`: modelo `Question`, perguntas e regras puras de normalização/validação.
- `bin/quiz_historia_brasil.dart`: interação com `stdin`, exibição e ciclo do jogo.
- `test/quiz_test.dart`: testes de regras sem interação de terminal.

## Abordagens consideradas

1. Uma pergunta codificada por bloco: descartada, pois contraria a exigência de lista e repetição.
2. Uma lista de mapas dentro de `main`: atende ao mínimo, mas dificulta ler e testar.
3. Modelo `Question` e lista no `lib`, com terminal em `bin`: escolhido por manter o jogo simples e organizado.
