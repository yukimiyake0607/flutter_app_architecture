import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/presentation/pages/auth/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン画面'),
      ),
      body: const LoginPage(),
    );
  }
}
