import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/todo_list_auth_provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Home Page'),),
           body: Center(
            child: TextButton(onPressed: (){
              print('Tentando acessar TodoListAuthProvider');
             final authprovider = context.read<TodoListAuthProvider>(); 
              authprovider.logout();
              print('AuthProvider acessado com sucesso');
            }, child: Text('logout')),
           ),
       );
  }
}