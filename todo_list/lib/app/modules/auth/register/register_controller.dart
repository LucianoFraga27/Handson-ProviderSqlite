import 'package:todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  void registerUser(String email, String password) async {
    try {
      super.showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        super.success();
      } else {
        super.setError("Erro ao registrar usuário");
      }
    } on AuthException catch (e) {
      super.setError(e.message);
    } finally {
      super.hideLoading();
      notifyListeners();
    }
  }
}
