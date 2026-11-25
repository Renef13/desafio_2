import 'dart:convert';
import 'dart:math';

enum Difficulty { easy, medium, hard }

extension DifficultyLabel on Difficulty {
  String get label => switch (this) {
    Difficulty.easy => 'Fácil',
    Difficulty.medium => 'Média',
    Difficulty.hard => 'Difícil',
  };

  static Difficulty fromJson(String value) => switch (value.toLowerCase()) {
    'fácil' => Difficulty.easy,
    'média' => Difficulty.medium,
    'difícil' => Difficulty.hard,
    _ => throw FormatException('Dificuldade inválida: $value'),
  };
}

class Question {
  const Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.difficulty,
  });

  final String text;
  final List<String> options;
  final String correctAnswer;
  final Difficulty difficulty;

  String get correctOptionText => options[correctAnswer.codeUnitAt(0) - 65];

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    text: json['text'] as String,
    options: List<String>.from(json['options'] as List),
    correctAnswer: json['correctAnswer'] as String,
    difficulty: DifficultyLabel.fromJson(json['difficulty'] as String),
  );
}

class RankingEntry {
  const RankingEntry({
    required this.name,
    required this.score,
    required this.total,
  });

  final String name;
  final int score;
  final int total;
  double get percentage => score / total;

  String toFileLine() => '$name|$score|$total';

  factory RankingEntry.fromFileLine(String line) {
    final values = line.split('|');
    return RankingEntry(
      name: values[0],
      score: int.parse(values[1]),
      total: int.parse(values[2]),
    );
  }
}

String normalizeAnswer(String? answer) => answer?.trim().toUpperCase() ?? '';

bool isValidAnswer(String answer) => RegExp(r'^[A-D]$').hasMatch(answer);

List<Question> questionsFromJson(String source) {
  final decoded = jsonDecode(source) as List<dynamic>;
  return decoded
      .map((item) => Question.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<Question> selectQuestions(
  List<Question> questions, {
  Difficulty? difficulty,
  required int count,
  Random? random,
}) {
  final available =
      questions
          .where(
            (question) =>
                difficulty == null || question.difficulty == difficulty,
          )
          .toList();
  if (count > available.length) {
    throw ArgumentError('Não há perguntas suficientes para essa seleção.');
  }
  available.shuffle(random);
  return available.take(count).toList();
}

List<RankingEntry> sortRanking(List<RankingEntry> entries) {
  final sorted = [...entries];
  sorted.sort((first, second) {
    final byPercentage = second.percentage.compareTo(first.percentage);
    return byPercentage != 0
        ? byPercentage
        : second.score.compareTo(first.score);
  });
  return sorted;
}

String formatRanking(List<RankingEntry> entries) {
  final lines = ['--- RANKING ---'];
  var position = 1;
  for (final entry in sortRanking(entries).take(10)) {
    lines.add('$position. ${entry.name}: ${entry.score}/${entry.total}');
    position++;
  }
  return lines.join('\n');
}

String scoreMessage(int score, int total) {
  final percentage = score / total;
  if (percentage == 1) {
    return 'Desempenho excelente! Você domina a História do Brasil.';
  }
  if (percentage >= 0.7) {
    return 'Muito bom! Você conhece bastante a História do Brasil.';
  }
  if (percentage >= 0.4) {
    return 'Bom esforço! Continue estudando para aprender ainda mais.';
  }
  return 'Continue estudando. A História do Brasil tem muitas histórias interessantes!';
}
