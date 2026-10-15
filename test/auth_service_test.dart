import 'package:flutter_test/flutter_test.dart';
import 'package:oqu_zhospary/services/auth_service.dart';
import 'package:oqu_zhospary/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AuthService> _createService() async {
  SharedPreferences.setMockInitialValues({});
  return AuthService(await StorageService.create());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('register succeeds and stores a hashed password', () async {
    final service = await _createService();
    final result = await service.register(
      fullName: 'Айдос Нұрлан',
      email: 'Aidos@Mail.kz',
      password: 'secret1',
    );
    expect(result.isSuccess, isTrue);
    expect(result.user!.email, 'aidos@mail.kz');
    expect(result.user!.passwordHash, isNot('secret1'));
    expect(result.user!.salt, isNotEmpty);
  });

  test('duplicate email is rejected (case-insensitive)', () async {
    final service = await _createService();
    await service.register(
      fullName: 'Айдос',
      email: 'a@mail.kz',
      password: 'secret1',
    );
    final second = await service.register(
      fullName: 'Басқа',
      email: 'A@MAIL.KZ',
      password: 'secret2',
    );
    expect(second.error, AuthError.emailTaken);
  });

  test('login succeeds with correct credentials', () async {
    final service = await _createService();
    await service.register(
      fullName: 'Айдос',
      email: 'a@mail.kz',
      password: 'secret1',
    );
    final result = await service.login(email: ' A@mail.kz ', password: 'secret1');
    expect(result.isSuccess, isTrue);
  });

  test('wrong password or unknown email is rejected', () async {
    final service = await _createService();
    await service.register(
      fullName: 'Айдос',
      email: 'a@mail.kz',
      password: 'secret1',
    );
    final wrong = await service.login(email: 'a@mail.kz', password: 'nope123');
    expect(wrong.error, AuthError.invalidCredentials);
    final unknown = await service.login(email: 'x@mail.kz', password: 'secret1');
    expect(unknown.error, AuthError.invalidCredentials);
  });

  test('session is restored after "restart"', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await StorageService.create();
    final first = AuthService(storage);
    final registered = await first.register(
      fullName: 'Айдос',
      email: 'a@mail.kz',
      password: 'secret1',
    );

    // A new service over the same storage simulates an app restart.
    final second = AuthService(storage);
    final restored = await second.restoreSession();
    expect(restored?.id, registered.user!.id);
  });

  test('stale session id is cleared', () async {
    SharedPreferences.setMockInitialValues({'session_user_id': 'ghost'});
    final service = AuthService(await StorageService.create());
    expect(await service.restoreSession(), isNull);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('session_user_id'), isNull);
  });

  test('logout clears the session but keeps the user', () async {
    final service = await _createService();
    await service.register(
      fullName: 'Айдос',
      email: 'a@mail.kz',
      password: 'secret1',
    );
    await service.logout();
    expect(await service.restoreSession(), isNull);
    final again = await service.login(email: 'a@mail.kz', password: 'secret1');
    expect(again.isSuccess, isTrue);
  });
}
