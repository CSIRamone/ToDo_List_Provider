import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/todo_list_auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

   HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<TodoListAuthProvider, String>(
                  selector: (context, todolistauthProvider) {
                    return todolistauthProvider.user?.photoURL ?? 
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ3rqiw_BrW9-ZuHfPOQ4oVCbwBMebUh_WTdKqhbtxmfIq1IK7_a5UjLc&s';
                  },
                    builder: (_, value, __) {
                    return CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(value),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Selector<TodoListAuthProvider, String>(
                  builder: (_, value, __) {
                    return Text(
                      value,
                      style: context.textTheme.titleMedium,
                    );
                  },
                  selector: (context, authProvider) {
                    return authProvider.user?.displayName ?? 'Não informado';
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Alterar nome de usuário'),
            leading: const Icon(Icons.person),
            onTap: () {
              // Navegar para a tela de alteração de nome de usuário
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Alterar nome do Usuário'),
                      content: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                        onChanged: (value) => nameVN.value = value,
                      ),
                      actions: [
                   
                        TextButton(onPressed: () {
                          // Fechar o diálogo
                          Navigator.of(context).pop();
                        }, child: Text('Cancelar', style: TextStyle(color: Colors.red),)),
                             TextButton(
                          onPressed: () async {
                            final nameValue = nameVN.value;
                            // Atualizar o nome do usuário
                            if(nameValue.isEmpty){
                              Messages.of(context).showError('Nome não pode ser vazio');
                            }else{
                              await context.read<UserService>().updateDisplayName(nameValue);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Alterar'),
                        ),
                      ],
                      
                    );
                  });
            },
          ),
          ListTile(
            title: const Text('Sair'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              // Chamar o método de logout do TodoListAuthProvider
              context.read<TodoListAuthProvider>().logout();
            },
          ),
        ],
      ),
    );
  }
}
