import 'package:flutter/services.dart';
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
      if(e.code == 'wrong-password'){
        throw AuthException(message: 'Senha incorreta!');
      }
      throw AuthException(message: e.message ?? 'Erro ao logar usuario!');
    }
  }
  
  @override
  Future<void> forgotPassword(String email) async { 
    try {
    final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email); 
    if (loginMethods.contains('password')) {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } else if(loginMethods.contains('google')){
      throw AuthException(message: 'Cadastro realizado com o Google, utilize ele para logar!');
    } else {
      throw AuthException(message: 'Email não cadastrado!');
    }
  } on PlatformException catch (e, s) {
    print(e);
    print(s);
    throw AuthException(message: e.message ?? 'Erro ao enviar email de recuperação!');
  } on FirebaseAuthException catch (e, s) {
    print(e);
    print(s);
    if (e.code == 'user-not-found') {
      throw AuthException(message: 'Email não cadastrado!');
    }
    throw AuthException(message: e.message ?? 'Erro ao enviar email de recuperação!');
  }
  }
}

