import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel taskModel;
  final dateFormat = DateFormat('dd/MM/yyyy');

   // Constructor

  Task({ super.key, required this.taskModel });

   @override
   Widget build(BuildContext context) {
       return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: IntrinsicHeight(
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Checkbox(
              value: taskModel.finished, 
              onChanged: (value) => context.read<HomeController>().checkOrUncheck(taskModel),
              ),
              title: Text(
                taskModel.description,
              style: TextStyle(
                decoration: taskModel.finished ? TextDecoration.lineThrough : TextDecoration.none,
              ),
              ),
              subtitle: Text(
                dateFormat.format(taskModel.datetime), 
              style: TextStyle(
                decoration: taskModel.finished ? TextDecoration.lineThrough : TextDecoration.none,
              ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  width: 1,
                ),
              ),
          ),
        ),
       );
  }
}