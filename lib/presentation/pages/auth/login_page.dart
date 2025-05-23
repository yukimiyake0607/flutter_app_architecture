import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, state) {
      state.whenOrNull(
        data: (user) {
          if (user != null) {
            context.go('/home-page');
          }
        },
        error: (error, stackTrace) {
          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$error'),
          ));
        },
      );
    });
    return Column(
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

                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'パスワードを入力してください';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return 'アルファベットと数字のみを入力してください';
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
            authState.isLoading
                ? null
                : ref.read(authControllerProvider.notifier).login(
                    _emailTextController.text, _passwordTextController.text);
          },
          child: const Text('ログイン'),
        ),
        const SizedBox(height: 30),
        TextButton(
          onPressed: () {
            context.push('/register-page');
          },
          child: const Text('新規登録はこちら'),
        ),
      ],
    );
  }
}
