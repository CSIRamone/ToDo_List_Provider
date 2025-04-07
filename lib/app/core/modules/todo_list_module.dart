import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

// A classe abstrata TodoListModule serve como uma base para organizar módulos no aplicativo.
// Ela encapsula a configuração de rotas e dependências (bindings) de forma reutilizável.
abstract class TodoListModule {
  // Mapa privado que armazena as rotas do módulo.
  final Map<String, WidgetBuilder> _routers;

  // Lista de bindings (dependências) que serão injetadas no módulo.
  // Cada binding é um SingleChildWidget, geralmente usado com o pacote Provider.
  final List<SingleChildWidget>? _bindings;

  // Construtor da classe TodoListModule.
  // Recebe as dependências (bindings) e as rotas (routers) como parâmetros.
  TodoListModule({
    List<SingleChildWidget>? bindings, // Lista opcional de dependências.
    required Map<String, WidgetBuilder> routers, // Mapa obrigatório de rotas.
  })  : _bindings = bindings, // Inicializa os bindings.
        _routers = routers; // Inicializa as rotas.

  // Getter para acessar as rotas do módulo.
  // Ele transforma cada rota em uma entrada que retorna um TodoListPage.
  Map<String, WidgetBuilder> get routers {
    return _routers.map((key, pageBuilder) => MapEntry(
          key, // Chave da rota (ex.: '/login').
          (_) => TodoListPage(
                bindings: _bindings, // Injeta as dependências no TodoListPage.
                page: pageBuilder, // Define a página associada à rota.
              ),
        ));
  }
}