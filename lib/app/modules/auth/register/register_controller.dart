import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/todolist_default_change_notifier.dart';
import 'package:todo_list_provider/app/repositories/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends TodolistDefaultChangeNotifier {
  final UserService _userService;
 

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        // Handle successful registration (e.g., navigate to another screen)
        success();
      } else {
        // Handle registration error (e.g., show error message)
       setError('Registration failed');
      }
      notifyListeners();
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
