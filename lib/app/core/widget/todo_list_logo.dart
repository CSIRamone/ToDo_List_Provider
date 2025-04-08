import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/list-hand-drawn-black-color-modern-calligraphy-phrase_218179-1684.jpg.avif',
          height: 200,
        ),
        Text('Todo List', style: context.textTheme.headlineLarge),
      ],
    );
  }
}
