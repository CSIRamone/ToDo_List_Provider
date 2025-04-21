import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/notifier/todolist_default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

// A classe LoginPage é um widget sem estado (StatelessWidget).
// Isso significa que ele não armazena ou altera dados internamente.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    TodolistDefaultListenerNotifier(
      changeNotifier: context.read<LoginController>(),
    ).listener(
      context: context,
      everCallback: (notifier, listenerIntance) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
      successCallback: (notifier, listenerInstace) {
        print('Login bem sucedido');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // O método build é responsável por construir a interface do usuário.
    // Ele retorna um widget que será exibido na tela.
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        //usado para obter as dimensões do widget pai
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              // usado para definir restrições adicionais para o widget filho no caso usamos para ter o minimo o maximo
              constraints: BoxConstraints(
                minHeight: constraints
                    .maxHeight, // define a altura minima do widget filho
                minWidth: constraints
                    .maxWidth, // define a largura minima do widget filho
              ),
              child: IntrinsicHeight(
                //
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
                        key: _formKey,
                        child: Column(
                          children: [
                            TodoListField(
                              label: 'E-mail',
                              controller: _emailEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ]),
                              focusNode: _emailFocus,
                            ),
                            SizedBox(height: 20),
                            TodoListField(
                              label: 'Senha',
                              obscureText: true,
                              controller: _passwordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.min(6, 'Senha muito curta'),
                              ]),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (_emailEC.text.isNotEmpty) {
                                      context
                                          .read<LoginController>()
                                          .forgotPassword(_emailEC.text);
                                    } else {
                                      _emailFocus.requestFocus();
                                      Messages.of(context).showError(
                                          'Por favor, insira seu e-mail.');
                                    }
                                  },
                                  child: Text('Esqueceu sua senha?'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final formValid =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (formValid) {
                                      final email = _emailEC.text;
                                      final password = _passwordEC.text;
                                      context
                                          .read<LoginController>()
                                          .login(email, password);
                                    }
                                  },
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
                              SignInButton(Buttons.Google, onPressed: () {
                                context.read<LoginController>().googleLogin();
                                // Chama o método googleLogin do controlador de login
                                // para iniciar o processo de login com o Google.
                                // O controlador deve ser responsável por lidar com a autenticação do Google.
                                // Isso pode incluir a exibição de uma tela de carregamento,
                              },
                                  text: 'Continue com o Google',
                                  padding: const EdgeInsets.all(5),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Não tem uma conta?'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/register');
                                      // Navega para a página de registro quando o botão é pressionado.
                                    },
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
