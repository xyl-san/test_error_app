import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'auth_repository.g.dart';

class AuthRepository {
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> jsonData;
    final String token;
    final url = Uri.parse("http://192.168.0.111:3500/auth/");
    final response = await http
        .post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: json.encode({
            "email": email,
            "password": password,
          }),
        )
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () => throw TimeoutException('Connection timed out'),
        );
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      token = jsonData['token'];
      return token;
    }
    if (response.statusCode == 401) throw Exception(jsonData['message']);
    throw Exception(jsonData['message']);
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}
