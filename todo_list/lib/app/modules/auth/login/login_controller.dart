import 'package:flutter/material.dart';
import 'package:todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
 
  final UserService _userService;
 
  LoginController({required UserService userService})
      : _userService = userService;

  void login(String email, String password) async {
    try {
      super.showLoadingAndResetState();
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
}
