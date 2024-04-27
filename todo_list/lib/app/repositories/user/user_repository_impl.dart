import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      var userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == "email-already-in-user") {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains("password")) {
          throw AuthException(
              message: "Email já cadastrado, por favor escolha outro email");
        } else {
          throw AuthException(
              message: "Esse email foi cadastrado pelo Google. Faça login com o Google");
        }
      } else {
         throw AuthException(message: e.message ?? "Erro ao cadastrar usuário");
      }
    }
  }
}
