import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/todolist_default_change_notifier.dart';
import 'package:todo_list_provider/app/repositories/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

// A classe LoginController é responsável por gerenciar o estado relacionado à página de login.
// Ela estende ChangeNotifier, o que permite notificar os widgets ouvintes sobre mudanças no estado.
class LoginController extends TodolistDefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);
      if (user != null) {
        // Handle successful login (e.g., navigate to another screen)
        success();
      } else {
        // Handle login error (e.g., show error message)
        setError('Login failed');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage =
          'Um email foi enviado para $email com instruções para redefinir sua senha';
    } catch (e) {
      if (e is AuthException) {
        setError(e.message);
      } else {
        setError('Erro ao resetar a senha');
      }
    } finally {
      hideLoading();
      notifyListeners();  
    }
  }
}
  // Atualmente, a classe está vazia, mas pode ser usada para adicionar lógica de autenticação,
  // validação de formulário, ou qualquer outra funcionalidade relacionada ao login.

  // Exemplo de uso futuro:
  // - Adicionar métodos para realizar login.
  // - Gerenciar o estado de carregamento (ex.: mostrar um indicador de progresso).
  // - Notificar os widgets ouvintes quando o estado mudar.