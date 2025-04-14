import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/repositories/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        // Handle successful registration (e.g., navigate to another screen)
        success = true;
      } else {
        // Handle registration error (e.g., show error message)
        error = 'Registration failed';
      }
      notifyListeners();
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
