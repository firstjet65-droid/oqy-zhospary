class AppUser {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    required this.salt,
    required this.createdAt,
  });

  final String id;
  final String fullName;
  final String email;
  final String passwordHash;
  final String salt;
  final DateTime createdAt;

  String get firstName {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? fullName : parts.first;
  }

  /// Up to two uppercase initials, e.g. "АЖ".
  String get initials {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    final first = parts.first.substring(0, 1);
    final second = parts.length > 1 ? parts[1].substring(0, 1) : '';
    return (first + second).toUpperCase();
  }

  Map<String, Object?> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'passwordHash': passwordHash,
    'salt': salt,
    'createdAt': createdAt.toIso8601String(),
  };

  /// Returns null when the map is malformed.
  static AppUser? tryFromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'];
    final fullName = json['fullName'];
    final email = json['email'];
    final hash = json['passwordHash'];
    final salt = json['salt'];
    final created = json['createdAt'];
    if (id is! String ||
        fullName is! String ||
        email is! String ||
        hash is! String ||
        salt is! String ||
        created is! String) {
      return null;
    }
    final date = DateTime.tryParse(created);
    if (date == null) return null;
    return AppUser(
      id: id,
      fullName: fullName,
      email: email,
      passwordHash: hash,
      salt: salt,
      createdAt: date,
    );
  }
}
