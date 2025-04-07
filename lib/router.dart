import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/presentation/pages/auth/register_page.dart';
import 'package:flutter_app_architecture/presentation/pages/user_session.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'initial',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const UserSession(),
        );
      },
    ),
    GoRoute(
      path: '/register-page',
      name: 'register-page',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const RegisterPage(),
        );
      },
    ),
  ],
);
