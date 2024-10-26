import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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
              message:
                  "Esse email foi cadastrado pelo Google. Faça login com o Google");
        }
      } else {
        throw AuthException(message: e.message ?? "Erro ao cadastrar usuário");
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e,s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? "Erro ao realizar Login");
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'wrong-password' || e.code == 'user-not-found' || e.code == 'invalid-credential') { 
        throw AuthException(message: 'Login ou senha inválidos'); }

      throw AuthException(message: e.message ?? "Erro ao realizar Login");
    }
  }
}
