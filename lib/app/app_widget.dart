import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';

// A classe AppWidget é o ponto de entrada principal do aplicativo.
// Ela é um StatefulWidget porque precisa gerenciar o estado do sqliteAdmConnection.
class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  // Instância de SqliteAdmConnection, que provavelmente gerencia a conexão com o banco de dados SQLite.
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    // Adiciona sqliteAdmConnection como um observador do ciclo de vida do aplicativo.
    // Isso permite que ele execute ações específicas quando o estado do aplicativo mudar.
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    // Remove sqliteAdmConnection como observador quando o widget for descartado.
    // Isso é importante para evitar vazamentos de memória.
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp é o widget principal que configura o tema, rotas e outras configurações do aplicativo.
    return MaterialApp(
      // Define o título do aplicativo.
      title: 'Todo List Provider',

      // Define a rota inicial do aplicativo como '/login'.
      initialRoute: '/login',

      // Define as rotas do aplicativo. Aqui, as rotas são obtidas do AuthModule.
      routes: {
        ...AuthModule().routers, // Usa o operador spread para adicionar as rotas definidas no AuthModule.
      },

      // Define a página inicial como SplashPage. Essa página geralmente é usada para exibir uma tela de carregamento inicial.
      home: SplashPage(),
    );
  }
}