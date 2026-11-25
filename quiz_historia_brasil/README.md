# Quiz: História do Brasil

Jogo de perguntas e respostas executado no terminal, criado para o **Desafio 2 - Meu Quiz** da trilha de **Desenvolvimento Mobile**.

## Integrantes

- Renef Ricardo Costa da Silva
- Juan Carlos Melo do Nascimento

## Sobre o quiz

O jogador informa seu nome e responde seis perguntas de múltipla escolha sobre a História do Brasil. As alternativas vão de A a D; o programa aceita letras maiúsculas ou minúsculas, avisa quando a resposta está incorreta e mostra a alternativa correta. Ao final, apresenta a pontuação e uma mensagem de acordo com o desempenho.

Exemplo de pergunta: **Em que ano o Brasil declarou sua Independência de Portugal?**

## Tecnologias utilizadas

- Dart
- `dart:io` para ler dados digitados com `stdin.readLineSync()`
- Listas, repetição `for`, condicionais e funções

## Como executar

Na pasta do projeto, execute:

```bash
cd quiz_historia_brasil
dart run
```

Para executar os testes das regras do quiz:

```bash
dart test
```

