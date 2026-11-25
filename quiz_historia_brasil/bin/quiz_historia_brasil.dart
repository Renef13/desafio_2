import 'dart:io';

import 'package:quiz_historia_brasil/quiz_historia_brasil.dart';

const questionsFilePath = 'data/questions.json';
const rankingFilePath = 'data/ranking.txt';

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

int chooseQuestionCount() {
  while (true) {
    stdout.write('Quantidade de perguntas (6, 12 ou 20): ');
    final count = int.tryParse(stdin.readLineSync()?.trim() ?? '');
    if (count == 6 || count == 12 || count == 20) return count!;
    print('Escolha apenas 6, 12 ou 20.');
  }
}

Difficulty? chooseDifficulty() {
  while (true) {
    print('\nEscolha a dificuldade:');
    print('1) Fácil');
    print('2) Média');
    print('3) Difícil');
    print('4) Surpresa (mistura todas as dificuldades)');
    stdout.write('Opção: ');
    switch (stdin.readLineSync()?.trim()) {
      case '1':
        return Difficulty.easy;
      case '2':
        return Difficulty.medium;
      case '3':
        return Difficulty.hard;
      case '4':
        return null;
      default:
        print('Opção inválida.');
    }
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

int playQuiz(String playerName, List<Question> questions) {
  var score = 0;
  for (var index = 0; index < questions.length; index++) {
    final question = questions[index];
    print(
      '\nPergunta ${index + 1} de ${questions.length} (${question.difficulty.label})',
    );
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
  return score;
}

Future<void> saveAndShowRanking(RankingEntry entry) async {
  final file = File(rankingFilePath);
  await file.writeAsString('${entry.toFileLine()}\n', mode: FileMode.append);
  final entries =
      (await file.readAsLines())
          .where((line) => line.trim().isNotEmpty)
          .map(RankingEntry.fromFileLine)
          .toList();
  print('\n${formatRanking(entries)}');
}

Future<void> showRanking() async {
  final file = File(rankingFilePath);
  if (!await file.exists()) {
    print('\nAinda não há partidas registradas no ranking.');
    return;
  }
  final entries =
      (await file.readAsLines())
          .where((line) => line.trim().isNotEmpty)
          .map(RankingEntry.fromFileLine)
          .toList();
  print('\n${formatRanking(entries)}');
}

String readMenuOption() {
  while (true) {
    print('\n1) Jogar');
    print('2) Ver placar');
    print('3) Sair');
    stdout.write('Opção: ');
    final option = stdin.readLineSync()?.trim();
    if (option == '1' || option == '2' || option == '3') return option!;
    print('Opção inválida.');
  }
}

Future<void> main() async {
  print('========================================');
  print('       QUIZ: HISTÓRIA DO BRASIL');
  print('========================================');
  print('Boas-vindas! Escolha a quantidade e a dificuldade do seu desafio.\n');

  final questionBank = questionsFromJson(
    await File(questionsFilePath).readAsString(),
  );

  while (true) {
    final option = readMenuOption();
    if (option == '2') {
      await showRanking();
      continue;
    }
    if (option == '3') {
      print('\nObrigado por usar o quiz. Até a próxima!');
      return;
    }

    final playerName = readPlayerName();
    do {
      List<Question> selectedQuestions;
      while (true) {
        final count = chooseQuestionCount();
        final difficulty = chooseDifficulty();
        try {
          selectedQuestions = selectQuestions(
            questionBank,
            difficulty: difficulty,
            count: count,
          );
          break;
        } on ArgumentError {
          print(
            'Não há perguntas suficientes nessa dificuldade para essa quantidade.',
          );
          print('Tente 6 perguntas ou escolha o modo Surpresa.');
        }
      }

      final score = playQuiz(playerName, selectedQuestions);
      print('\nFim do quiz, $playerName!');
      print(
        'Sua pontuação: $score de ${selectedQuestions.length} perguntas corretas.',
      );
      print(scoreMessage(score, selectedQuestions.length));
      await saveAndShowRanking(
        RankingEntry(
          name: playerName,
          score: score,
          total: selectedQuestions.length,
        ),
      );
    } while (wantsToPlayAgain());
  }
}
