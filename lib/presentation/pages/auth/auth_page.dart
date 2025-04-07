import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン画面'),
      ),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メールアドレスを入力してください';
                      }
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'アルファベットのみを入力してください';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'アルファベットのみを入力してください';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              formKey.currentState?.validate();
              ref.read(authControllerProvider.notifier).login(
                  _emailTextController.text, _passwordTextController.text);
            },
            child: const Text('ログイン'),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () {
              context.go('/register-page');
            },
            child: const Text('新規登録はこちら'),
          ),
        ],
      ),
    );
  }
}
