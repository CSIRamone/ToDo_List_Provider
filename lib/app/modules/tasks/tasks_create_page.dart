import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/widget/calendar_button.dart';

class TasksCreatePage extends StatelessWidget {
  TasksCreateController _controller;

  TasksCreatePage({Key? key, required TasksCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: context.primaryColor,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        icon: Icon(
          Icons.save,
          color: Colors.grey,
        ),
        onPressed: () {},
        label: Text(
          'Salvar Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Criar Atividade', 
                style: context.titleStyle.copyWith(fontSize: 20),),
              ),
              SizedBox(
                height: 30,
              ),
              TodoListField(label: 'Atividade'),
              SizedBox(
                height: 20,
              ),
              CalendarButton(),
              SizedBox(
                height: 20,
              ),  
            ],
          ),
        ),
      ),
    );
  }
}
