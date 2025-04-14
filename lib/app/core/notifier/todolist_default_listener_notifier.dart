import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/todolist_default_change_notifier.dart';

import '../ui/messages.dart';

class TodolistDefaultListenerNotifier {
  final TodolistDefaultChangeNotifier changeNotifier;

  TodolistDefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    EverVoidCallback? everCallback,
    ErrorVoidCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {
      if (everCallback != null) {
        everCallback(changeNotifier, this);
      }
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if(errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        // Show error message
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      }

      if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    TodolistDefaultChangeNotifier notifier,
    TodolistDefaultListenerNotifier listenerIntance);

typedef ErrorVoidCallback = void Function(
    TodolistDefaultChangeNotifier notifier,
    TodolistDefaultListenerNotifier listenerIntance);

typedef EverVoidCallback = void Function(
    TodolistDefaultChangeNotifier notifier,
    TodolistDefaultListenerNotifier listenerIntance);
