import 'dart:io';

import 'package:quiz_historia_brasil/quiz_historia_brasil.dart';

String readPlayerName() {
  while (true) {
    stdout.write('Digite seu nome: ');
    final name = stdin.readLineSync()?.trim() ?? '';
    if (name.isNotEmpty) return name;
    print('Por favor, informe um nome para continuar.');
  }
}

String readValidAnswer() {
  while (true) {
    stdout.write('Sua resposta (A, B, C ou D): ');
    final answer = normalizeAnswer(stdin.readLineSync());
    if (isValidAnswer(answer)) return answer;
    print('Resposta inválida. Digite apenas A, B, C ou D.');
  }
}

bool wantsToPlayAgain() {
  while (true) {
    stdout.write('Deseja jogar novamente? (S/N): ');
    final answer = normalizeAnswer(stdin.readLineSync());
    if (answer == 'S') return true;
    if (answer == 'N') return false;
    print('Resposta inválida. Digite S para sim ou N para não.');
  }
}

void playQuiz(String playerName) {
  var score = 0;

  for (var index = 0; index < questions.length; index++) {
    final question = questions[index];
    print('\nPergunta ${index + 1} de ${questions.length}');
    print(question.text);
    for (
      var optionIndex = 0;
      optionIndex < question.options.length;
      optionIndex++
    ) {
      final letter = String.fromCharCode(65 + optionIndex);
      print('$letter) ${question.options[optionIndex]}');
    }

    final answer = readValidAnswer();
    if (answer == question.correctAnswer) {
      score++;
      print('Correto, $playerName!');
    } else {
      print(
        'Incorreto, $playerName. A resposta correta era '
        '${question.correctAnswer}) ${question.correctOptionText}.',
      );
    }
  }

  print('\nFim do quiz, $playerName!');
  print('Sua pontuação: $score de ${questions.length} perguntas corretas.');
  print(scoreMessage(score, questions.length));
}

void main() {
  print('========================================');
  print('       QUIZ: HISTÓRIA DO BRASIL');
  print('========================================');
  print(
    'Boas-vindas! Teste seus conhecimentos sobre momentos importantes da história do Brasil.\n',
  );

  final playerName = readPlayerName();
  do {
    playQuiz(playerName);
  } while (wantsToPlayAgain());

  print('\nObrigado por jogar, $playerName. Até a próxima!');
}
