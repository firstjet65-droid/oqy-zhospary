/// Hand-written Kazakh date names (no intl locale data needed).
class KkDate {
  KkDate._();

  static const weekdays = [
    'Дүйсенбі',
    'Сейсенбі',
    'Сәрсенбі',
    'Бейсенбі',
    'Жұма',
    'Сенбі',
    'Жексенбі',
  ];

  static const months = [
    'қаңтар',
    'ақпан',
    'наурыз',
    'сәуір',
    'мамыр',
    'маусым',
    'шілде',
    'тамыз',
    'қыркүйек',
    'қазан',
    'қараша',
    'желтоқсан',
  ];

  /// e.g. "Сенбі, 9 қазан"
  static String full(DateTime d) =>
      '${weekdays[d.weekday - 1]}, ${d.day} ${months[d.month - 1]}';

  /// e.g. "9 қазан 2026"
  static String withYear(DateTime d) =>
      '${d.day} ${months[d.month - 1]} ${d.year}';

  /// e.g. "9 қазан"
  static String short(DateTime d) => '${d.day} ${months[d.month - 1]}';

  static String time(int hour, int minute) =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// Human readable deadline hint relative to today.
  static String relative(DateTime d, {DateTime? now}) {
    final today = _dayOnly(now ?? DateTime.now());
    final diff = _dayOnly(d).difference(today).inDays;
    if (diff == 0) return 'Бүгін';
    if (diff == 1) return 'Ертең';
    if (diff == -1) return 'Кеше';
    if (diff > 1) return '$diff күннен кейін';
    return '${-diff} күн бұрын';
  }

  static DateTime _dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
