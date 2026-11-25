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
    return 'Desempenho excelente! Voce domina a Historia do Brasil.';
  }
  if (percentage >= 0.7) {
    return 'Muito bom! Voce conhece bastante a Historia do Brasil.';
  }
  if (percentage >= 0.4) {
    return 'Bom esforco! Continue estudando para aprender ainda mais.';
  }
  return 'Continue estudando. A Historia do Brasil tem muitas historias interessantes!';
}

const List<Question> questions = [
  Question(
    text: 'Em que ano o Brasil declarou sua Independencia de Portugal?',
    options: ['1808', '1822', '1888', '1889'],
    correctAnswer: 'B',
  ),
  Question(
    text: 'Quem assinou a Lei Aurea, que aboliu oficialmente a escravidao?',
    options: [
      'Maria Quiteria',
      'Princesa Isabel',
      'Anita Garibaldi',
      'Dona Leopoldina',
    ],
    correctAnswer: 'B',
  ),
  Question(
    text:
        'Qual lider ficou conhecido como o principal simbolo da Inconfidencia Mineira?',
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
        'Quem foi o primeiro presidente do Brasil apos a Proclamacao da Republica?',
    options: [
      'Marechal Deodoro da Fonseca',
      'Getulio Vargas',
      'Juscelino Kubitschek',
      'Floriano Peixoto',
    ],
    correctAnswer: 'A',
  ),
  Question(
    text: 'Em que ano Brasilia foi inaugurada como capital do Brasil?',
    options: ['1930', '1945', '1954', '1960'],
    correctAnswer: 'D',
  ),
  Question(
    text: 'O movimento Diretas Ja defendia principalmente:',
    options: [
      'a volta da monarquia',
      'eleicoes diretas para presidente',
      'a independencia do Brasil',
      'a criacao de Brasilia',
    ],
    correctAnswer: 'B',
  ),
];
