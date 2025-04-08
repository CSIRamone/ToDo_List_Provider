import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

// A classe LoginPage é um widget sem estado (StatelessWidget).
// Isso significa que ele não armazena ou altera dados internamente.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // O método build é responsável por construir a interface do usuário.
    // Ele retorna um widget que será exibido na tela.
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder( //usado para obter as dimensões do widget pai
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox( // usado para definir restrições adicionais para o widget filho no caso usamos para ter o minimo o maximo
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,// define a altura minima do widget filho
                minWidth: constraints.maxWidth, // define a largura minima do widget filho
              ),
              child: IntrinsicHeight(//
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(),
                            SizedBox(height: 20),
                            TextFormField(),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Esqueceu sua senha?'),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 20),
                                  ),
                                  child: Text('Login'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF0F3F7),
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey.withAlpha(50),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              SignInButton(
                                Buttons.Google,
                                onPressed: () {},
                                text: 'Continue com o Google',
                                padding: const EdgeInsets.all(5),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                )
                              ),
                              Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                Text('Não tem uma conta?'),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Cadastre-se'),
                                ),
                               ], 
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
