import '../../l10n/kk_strings.dart';

/// Form validators returning a Kazakh error text or null when valid.
class Validators {
  Validators._();

  static final _emailRegex = RegExp(
    r'^[\w.+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$',
  );
  // Any Unicode letter, space or hyphen.
  static final _nameRegex = RegExp(r"^[\p{L}\s-]+$", unicode: true);

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return KkStrings.errRequired;
    return null;
  }

  static String? name(String? value) {
    final empty = required(value);
    if (empty != null) return empty;
    final v = value!.trim();
    if (v.length < 2) return KkStrings.errNameShort;
    if (!_nameRegex.hasMatch(v)) return KkStrings.errNameChars;
    return null;
  }

  static String? email(String? value) {
    final empty = required(value);
    if (empty != null) return empty;
    if (!_emailRegex.hasMatch(value!.trim())) return KkStrings.errEmail;
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return KkStrings.errRequired;
    if (value.length < 6) return KkStrings.errPasswordShort;
    final hasLetter = RegExp(r'\p{L}', unicode: true).hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    if (!hasLetter || !hasDigit) return KkStrings.errPasswordFormat;
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return KkStrings.errRequired;
    if (value != original) return KkStrings.errPasswordMismatch;
    return null;
  }

  /// Login only checks that the field is filled.
  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) return KkStrings.errRequired;
    return null;
  }
}
