class Question {
  const Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });

  final String text;
  final List<String> options;
  final String correctAnswer;

  String get correctOptionText => options[correctAnswer.codeUnitAt(0) - 65];
}

String normalizeAnswer(String? answer) => answer?.trim().toUpperCase() ?? '';

bool isValidAnswer(String answer) => RegExp(r'^[A-D]$').hasMatch(answer);

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

const List<Question> questions = [
  Question(
    text: 'Em que ano o Brasil declarou sua Independência de Portugal?',
    options: ['1808', '1822', '1888', '1889'],
    correctAnswer: 'B',
  ),
  Question(
    text: 'Quem assinou a Lei Áurea, que aboliu oficialmente a escravidão?',
    options: [
      'Maria Quitéria',
      'Princesa Isabel',
      'Anita Garibaldi',
      'Dona Leopoldina',
    ],
    correctAnswer: 'B',
  ),
  Question(
    text:
        'Qual líder ficou conhecido como o principal símbolo da Inconfidência Mineira?',
    options: [
      'Zumbi dos Palmares',
      'Dom Pedro I',
      'Tiradentes',
      'Marechal Deodoro',
    ],
    correctAnswer: 'C',
  ),
  Question(
    text:
        'Quem foi o primeiro presidente do Brasil após a Proclamação da República?',
    options: [
      'Marechal Deodoro da Fonseca',
      'Getúlio Vargas',
      'Juscelino Kubitschek',
      'Floriano Peixoto',
    ],
    correctAnswer: 'A',
  ),
  Question(
    text: 'Em que ano Brasília foi inaugurada como capital do Brasil?',
    options: ['1930', '1945', '1954', '1960'],
    correctAnswer: 'D',
  ),
  Question(
    text: 'O movimento Diretas Já defendia principalmente:',
    options: [
      'a volta da monarquia',
      'eleições diretas para presidente',
      'a independência do Brasil',
      'a criação de Brasília',
    ],
    correctAnswer: 'B',
  ),
];
