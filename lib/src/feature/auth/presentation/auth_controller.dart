import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/auth_state.dart';
import '../repository/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthState> build() {
    return AuthState.notAuthenticated;
  }

  Future<void> submit(String email, String password) async {
    state = const AsyncValue.loading();
    final token = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password));
    if (token.hasError) {
      state = AsyncValue.error(token.error as Object, StackTrace.current);
      return;
    }
    state = const AsyncValue.data(AuthState.authenticated);
  }
}
