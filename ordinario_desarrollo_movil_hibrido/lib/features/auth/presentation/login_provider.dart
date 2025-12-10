import 'package:flutter/material.dart';
import 'dart:convert';

import '../../../core/storage/session_storage.dart';
import '../../auth/data/auth_remote_ds.dart';
import '../../auth/domain/entities/user.dart';

class LoginProvider extends ChangeNotifier {
  final AuthRemoteDataSource remote = AuthRemoteDataSource();

  User? user;
  bool loading = false;
  String? errorMessage;

  LoginProvider() {
    restoreSession();
  }

  Future<void> restoreSession() async {
    final userJson = await SessionStorage.loadUser();
    final token = await SessionStorage.loadToken();

    if (userJson != null && token != null) {
      final data = jsonDecode(userJson);

      user = User(
        id: data["id"],
        email: data["email"],
        name: data["name"],
        role: data["role"],
        avatar: data["avatar"],
        accessToken: token,
      );

      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final u = await remote.login(email, password);
      user = u;

      final jsonUser = jsonEncode({
        "id": u.id,
        "email": u.email,
        "name": u.name,
        "role": u.role,
        "avatar": u.avatar,
      });

      await SessionStorage.saveSession(u.accessToken, jsonUser);

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      errorMessage = "Credenciales inválidas";
      notifyListeners();
      return false;
    }
  }

  void logout() async {
    user = null;
    await SessionStorage.clear();
    notifyListeners();
  }
}
