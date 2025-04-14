
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_page.dart';

// A classe AuthModule é responsável por configurar as dependências e rotas relacionadas à autenticação.
// Ela estende TodoListModule, que provavelmente é uma classe base para organizar módulos no aplicativo.
class AuthModule extends TodoListModule {
// Construtor da classe AuthModule.
  AuthModule()
      : super(
// Configuração das dependências (bindings) do módulo.
          bindings: [
// Registra o LoginController como um ChangeNotifierProvider.
            // Isso permite que o LoginController seja acessado pelos widgets filhos
            // e notifique-os sobre mudanças no estado.
            ChangeNotifierProvider(
              create: (context) => LoginController(),
            ),
            ChangeNotifierProvider(
              create: (context) => RegisterController(userService: context.read()),
            ),
          ],

          // Configuração das rotas do módulo.
          routers: {
// Define a rota '/login' e associa à LoginPage.
            // Quando a rota '/login' for acessada, a LoginPage será exibida.
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
        );
  }