import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/presentation/controllers/auth_controller.dart';
import 'package:flutter_app_architecture/presentation/pages/auth/auth_page.dart';
import 'package:flutter_app_architecture/presentation/pages/core/error_page.dart';
import 'package:flutter_app_architecture/presentation/pages/core/loading_page.dart';
import 'package:flutter_app_architecture/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSession extends ConsumerWidget {
  const UserSession({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerAsync = ref.watch(authControllerProvider);
    return authControllerAsync.when(
      data: (userModel) {
        if (userModel == null) {
          return const AuthPage();
        } else {
          return const HomePage();
        }
      },
      error: (error, _) => ErrorPage(error: error),
      loading: () => const LoadingPage(),
    );
  }
}
