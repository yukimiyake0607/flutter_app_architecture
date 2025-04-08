import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _rePasswordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _rePasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
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
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (value != _rePasswordTextController.text) {
                        return 'パスワードが一致していません';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                        return 'アルファベットと数字のみを入力してください';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _rePasswordTextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (value != _passwordTextController.text) {
                        return 'パスワードが一致していません';
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
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              formKey.currentState?.validate();
              ref.read(authControllerProvider.notifier).register(
                  _emailTextController.text, _passwordTextController.text);
            },
            child: const Text('新規作成'),
          ),
        ],
      ),
    );
  }
}
