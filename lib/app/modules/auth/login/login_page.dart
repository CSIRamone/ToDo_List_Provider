import 'package:flutter/material.dart';

// A classe LoginPage é um widget sem estado (StatelessWidget).
// Isso significa que ele não armazena ou altera dados internamente.
class LoginPage extends StatelessWidget {
  
  const LoginPage({ super.key });

  @override
  Widget build(BuildContext context) {
    // O método build é responsável por construir a interface do usuário.
    // Ele retorna um widget que será exibido na tela.
    return Scaffold(
            appBar: AppBar(title: const Text('Login'),),
      body: Container(),
    );
  }
}