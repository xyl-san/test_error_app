import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'other_screen.dart';
import 'src/feature/auth/domain/auth_state.dart';
import 'src/feature/auth/presentation/auth_controller.dart';
import 'src/feature/auth/presentation/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);

    return state.when(
      data: (state) {
        return state == AuthState.authenticated
            ? const OtherScreen()
            : const LoginScreen();
      },
      error: (error, stackTrace) => const Scaffold(
        body: Center(child: Text("ERROR ERROR")),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
