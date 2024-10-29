import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      if (e.code == "email-already-in-use") {
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
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? "Erro ao realizar Login");
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'wrong-password' ||
          e.code == 'user-not-found' ||
          e.code == 'invalid-credential') {
        throw AuthException(message: 'Login ou senha inválidos');
      }

      throw AuthException(message: e.message ?? "Erro ao realizar Login");
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains("password")) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains("google")) {
        throw AuthException(
            message:
                "Cadastro Realizado com o Google não pode ser resetado a senha");
      } else {
        throw AuthException(message: "Email não encontrado");
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(
          message: e.message ?? "Erro ao realizar resetar senha");
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignin = GoogleSignIn();
      final googleUser = await googleSignin.signIn();

      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains("password")) {
          throw AuthException(
              message:
                  "Você utilizou o e-mail para cadastro no todoList, caso tenha esquecido sua senha, clique em 'Esqueci a minha senha'");
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredencial = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredencial =
              await _firebaseAuth.signInWithCredential(firebaseCredencial);
          return userCredencial.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                "Login inválido, você se registrou com os seguintes provedores: ${loginMethods?.join(",")}");
      } else {
        throw AuthException(
            message:
                "Erro ao realizar login");
      }


    }
  }
  
  @override
  Future<void> googleLogout() async{
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
