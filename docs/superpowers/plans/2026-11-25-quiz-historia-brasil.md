# Quiz História do Brasil Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Criar um quiz de História do Brasil no terminal em Dart para Renef Ricardo Costa da Silva e Juan Carlos Melo do Nascimento.

**Architecture:** `lib/quiz.dart` conterá o modelo, seis perguntas e regras puras. `bin/quiz_historia_brasil.dart` fará toda entrada e saída pelo terminal e iterará a lista com `for`. Testes unitários protegerão a normalização, validação e pontuação.

**Tech Stack:** Dart SDK; `dart:io`; pacote de testes gerado pelo template console.

**Spec:** `docs/superpowers/specs/2026-11-25-quiz-historia-brasil-design.md`

## Global Constraints

- Criar o esqueleto com `dart create -t console quiz_historia_brasil`.
- Executar com `dart run`; sem dependências externas.
- Usar `stdin.readLineSync()`, lista e laço `for`.
- Terminal simples, sem cores ou apresentação rebuscada.

## Review Focus

- Entrada vazia: solicitar novamente, sem avançar a pergunta.
- Letra fora de A–D: solicitar novamente, sem avançar a pergunta.
- Letras minúsculas: tratadas como maiúsculas.
- Resposta errada: apresentar a letra e o texto da alternativa correta.
- Pontuação: contar exatamente um ponto por resposta correta.

### Task 1: Estrutura e regras do quiz

**Files:**
- Create: `quiz_historia_brasil/` via `dart create -t console`
- Modify: `quiz_historia_brasil/lib/quiz.dart`
- Modify: `quiz_historia_brasil/test/quiz_test.dart`

**Interfaces:**
- Produces: `Question`, `questions`, `normalizeAnswer(String?)`, `isValidAnswer(String)`, `scoreMessage(int, int)`.

- [ ] Escrever testes de regras e executá-los, observando falha.
- [ ] Implementar as regras e seis perguntas sobre História do Brasil.
- [ ] Executar `dart test` e observar aprovação.

### Task 2: Interação no terminal e documentação

**Files:**
- Modify: `quiz_historia_brasil/bin/quiz_historia_brasil.dart`
- Modify: `quiz_historia_brasil/README.md`

**Interfaces:**
- Consumes: entidades e funções de `lib/quiz.dart`.
- Produces: jogo interativo executável por `dart run`.

- [ ] Implementar `readValidAnswer()` com `stdin.readLineSync()` e validação.
- [ ] Implementar `playQuiz()` com laço `for`, pontuação e opção de nova partida.
- [ ] Documentar integrantes, trilha, uso, exemplo de pergunta e utilização de IA.
- [ ] Executar `dart analyze`, `dart test` e uma sessão simulada de `dart run`.
