import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../presentation/login_provider.dart';

class AuthGuard {
  static String? requireLogin(BuildContext context, GoRouterState state) {
    final user = context.read<LoginProvider>().user;

    if (user == null) return "/";

    return null;
  }

  static String? requireAdmin(BuildContext context, GoRouterState state) {
    final user = context.read<LoginProvider>().user;

    if (user == null) return "/";
    if (user.role != "admin") return "/access-denied";

    return null;
  }
}
