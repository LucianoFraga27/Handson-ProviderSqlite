import 'package:flutter/material.dart';
import 'package:todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  void login(String email, String password) async {
    try {
      super.showLoadingAndResetState();
      infoMessage = null;
      super.notifyListeners();
      final user = await _userService.login(email, password);

      if (user != null) {
        super.success();
      } else {
        super.setError("Usuário ou senha inválidos");
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      super.hideLoading();
      super.notifyListeners();
    }
  }

  void forgotPassword(String email) async {
    try {
      super.showLoadingAndResetState();
      infoMessage = null;
      super.notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = "Reset de senha enviado para seu email";
    } catch (e) {
      if (e is AuthException) {
        setError(e.message);
      } else {
        setError("Erro ao resetar a senha");
      }
    } finally {
      super.hideLoading();
      super.notifyListeners();
    }
  }

  Future<void> loginGoogle() async {
    try {
      super.showLoadingAndResetState();
      infoMessage = null;
      super.notifyListeners();
      final user = await _userService.googleLogin();
      if (user != null) {
        success();
      } else {
        setError("Erro ao relizazer login contra google");
      }
    } catch (e) {
      _userService.googleLogout();
      if (e is AuthException) {
        setError(e.message);
      } else {
        setError("Erro ao relizazer login contra google");
      }
    } finally {
      super.hideLoading();
      super.notifyListeners();
    }
  }
}
