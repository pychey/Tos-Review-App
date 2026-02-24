import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api_client.dart';

final _storage = const FlutterSecureStorage();
final _googleSignIn = GoogleSignIn.instance;

class AuthService {
  Future<void> init() async {
    await _googleSignIn.initialize(
      clientId: '247349964177-6bv6oumtoa37oqarjstgvh0r505u9l01.apps.googleusercontent.com',
    );
  }

  Future<void> register(String email, String name, String password) async {
    final response = await dio.post('/register', data: {
      'email': email,
      'name': name,
      'password': password,
    });
    await _storage.write(key: 'access_token', value: response.data['access_token']);
  }

  Future<void> login(String email, String password) async {
    final response = await dio.post('/login', data: {
      'email': email,
      'password': password,
    });
    await _storage.write(key: 'access_token', value: response.data['access_token']);
  }

  Future<void> googleSignIn() async {
    try {
      final result = await _googleSignIn.authenticate();
      final idToken = result.authentication.idToken;
      if (idToken == null) throw Exception('No ID token received');

      final response = await dio.post('/auth/google/mobile', data: {
        'idToken': idToken,
      });
      await _storage.write(key: 'access_token', value: response.data['access_token']);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) throw Exception('cancelled');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _googleSignIn.signOut();
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'access_token');
    return token != null;
  }
}

final authService = AuthService();