import 'dart:io';
import 'dart:math';

import 'package:quiz_historia_brasil/quiz_historia_brasil.dart';
import 'package:test/test.dart';

void main() {
  group('respostas do quiz', () {
    test('normaliza letras minúsculas e remove espaços', () {
      expect(normalizeAnswer('  b '), 'B');
    });

    test('rejeita alternativa vazia ou fora de A a D', () {
      expect(isValidAnswer(''), isFalse);
      expect(isValidAnswer('E'), isFalse);
      expect(isValidAnswer('C'), isTrue);
    });
  });

  test('lê perguntas classificadas a partir de JSON', () {
    const source = '''[
      {"text":"Pergunta?","options":["A","B","C","D"],"correctAnswer":"A","difficulty":"fácil"}
    ]''';

    final questions = questionsFromJson(source);

    expect(questions, hasLength(1));
    expect(questions.single.difficulty, Difficulty.easy);
    expect(questions.single.options, hasLength(4));
  });

  test('sorteia perguntas sem repetição da dificuldade escolhida', () {
    final questions = List.generate(
      10,
      (index) => Question(
        text: 'Fácil $index',
        options: const ['A', 'B', 'C', 'D'],
        correctAnswer: 'A',
        difficulty: Difficulty.easy,
      ),
    );

    final selected = selectQuestions(
      questions,
      difficulty: Difficulty.easy,
      count: 6,
      random: Random(1),
    );

    expect(selected, hasLength(6));
    expect(selected.map((question) => question.text).toSet(), hasLength(6));
    expect(
      selected.every((question) => question.difficulty == Difficulty.easy),
      isTrue,
    );
  });

  test('modo surpresa seleciona perguntas de todas as dificuldades', () {
    final questions = [
      Question(
        text: 'Fácil',
        options: const ['A', 'B', 'C', 'D'],
        correctAnswer: 'A',
        difficulty: Difficulty.easy,
      ),
      Question(
        text: 'Média',
        options: const ['A', 'B', 'C', 'D'],
        correctAnswer: 'A',
        difficulty: Difficulty.medium,
      ),
      Question(
        text: 'Difícil',
        options: const ['A', 'B', 'C', 'D'],
        correctAnswer: 'A',
        difficulty: Difficulty.hard,
      ),
    ];

    final selected = selectQuestions(questions, count: 3, random: Random(2));

    expect(selected.map((question) => question.difficulty).toSet(), {
      Difficulty.easy,
      Difficulty.medium,
      Difficulty.hard,
    });
  });

  test('ordena o ranking por pontuação e percentual', () {
    final ranking = sortRanking([
      const RankingEntry(name: 'Ana', score: 4, total: 6),
      const RankingEntry(name: 'Renef', score: 8, total: 12),
      const RankingEntry(name: 'Juan', score: 5, total: 6),
    ]);

    expect(ranking.map((entry) => entry.name), ['Juan', 'Renef', 'Ana']);
  });

  test('formata o placar para ser exibido no terminal', () {
    final text = formatRanking([
      const RankingEntry(name: 'Renef', score: 5, total: 6),
    ]);

    expect(text, contains('--- RANKING ---'));
    expect(text, contains('1. Renef: 5/6'));
  });

  test('distribui as alternativas corretas de forma equilibrada', () async {
    final source = await File('data/questions.json').readAsString();
    final questions = questionsFromJson(source);
    final totals = <String, int>{'A': 0, 'B': 0, 'C': 0, 'D': 0};
    for (final question in questions) {
      totals[question.correctAnswer] = totals[question.correctAnswer]! + 1;
    }

    expect(questions, hasLength(30));
    expect(totals, {'A': 8, 'B': 8, 'C': 7, 'D': 7});
  });

  test('cria mensagem final adequada ao desempenho', () {
    expect(scoreMessage(6, 6), contains('excelente'));
    expect(scoreMessage(2, 6), contains('Continue'));
  });
}
