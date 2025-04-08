import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Object error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('エラーが発生しました: $error'),
      ),
    );
  }
}
