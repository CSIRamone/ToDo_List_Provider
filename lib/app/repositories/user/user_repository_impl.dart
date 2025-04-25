import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/repositories/exception/auth_exception.dart';

import './user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'Email já cadastrado! escolha outro email');
        } else {
          throw AuthException(
              message:
                  'Voce se cadastrou no TodoList pelo Google, por favor utilize ele para entrar');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao cadastrar usuario!');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao logar usuario!');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Senha incorreta!');
      }
      throw AuthException(message: e.message ?? 'Erro ao logar usuario!');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastro realizado com o Google, utilize ele para logar!');
      } else {
        throw AuthException(message: 'Email não cadastrado!');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(
          message: e.message ?? 'Erro ao enviar email de recuperação!');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'user-not-found') {
        throw AuthException(message: 'Email não cadastrado!');
      }
      throw AuthException(
          message: e.message ?? 'Erro ao enviar email de recuperação!');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Voce se cadastrou no TodoList pelo email e senha, por favor utilize ele para entrar, se esqueceu sua senha clicar em esqueceu senha');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredencial = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

          final userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredencial);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: '''
              Login invalido voce se registrou no Todolist com os seguintes provedores:
              ${loginMethods?.join(', ')}
              ''');
      } else {
        throw AuthException(message: 'Erro ao logar usuario!');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
  
  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return await user.updateProfile(displayName: name);
    } else {
      throw AuthException(message: 'Usuario não encontrado!');
    }
     
  }
}
