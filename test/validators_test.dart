import 'package:flutter_test/flutter_test.dart';
import 'package:oqu_zhospary/core/utils/validators.dart';
import 'package:oqu_zhospary/l10n/kk_strings.dart';

void main() {
  group('email', () {
    test('accepts valid addresses', () {
      expect(Validators.email('student@mail.kz'), isNull);
      expect(Validators.email('a.b+c@univ.edu.kz'), isNull);
    });

    test('rejects invalid addresses', () {
      expect(Validators.email('student'), KkStrings.errEmail);
      expect(Validators.email('student@'), KkStrings.errEmail);
      expect(Validators.email('a@b'), KkStrings.errEmail);
    });

    test('rejects empty', () {
      expect(Validators.email('  '), KkStrings.errRequired);
      expect(Validators.email(null), KkStrings.errRequired);
    });
  });

  group('password', () {
    test('accepts letters + digits, 6+ chars', () {
      expect(Validators.password('abc123'), isNull);
      expect(Validators.password('Құпия2026'), isNull);
    });

    test('rejects short, letters-only, digits-only', () {
      expect(Validators.password('ab1'), KkStrings.errPasswordShort);
      expect(Validators.password('abcdefg'), KkStrings.errPasswordFormat);
      expect(Validators.password('1234567'), KkStrings.errPasswordFormat);
    });

    test('rejects empty', () {
      expect(Validators.password(''), KkStrings.errRequired);
    });

    test('confirm must match', () {
      expect(Validators.confirmPassword('abc123', 'abc123'), isNull);
      expect(
        Validators.confirmPassword('abc124', 'abc123'),
        KkStrings.errPasswordMismatch,
      );
    });
  });

  group('name', () {
    test('accepts letters, spaces and hyphens', () {
      expect(Validators.name('Айдос Нұрлан'), isNull);
      expect(Validators.name('Anna-Maria'), isNull);
    });

    test('rejects short, digits and symbols', () {
      expect(Validators.name('А'), KkStrings.errNameShort);
      expect(Validators.name('Айдос1'), KkStrings.errNameChars);
      expect(Validators.name('Айдос!'), KkStrings.errNameChars);
    });

    test('rejects empty', () {
      expect(Validators.name(''), KkStrings.errRequired);
    });
  });
}
