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

  test('disponibiliza seis perguntas com quatro alternativas', () {
    expect(questions, hasLength(6));
    expect(questions.every((question) => question.options.length == 4), isTrue);
  });

  test('cria mensagem final adequada ao desempenho', () {
    expect(scoreMessage(6, 6), contains('excelente'));
    expect(scoreMessage(2, 6), contains('Continue'));
  });
}
