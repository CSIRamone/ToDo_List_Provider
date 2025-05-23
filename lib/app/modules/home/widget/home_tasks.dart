import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widget/task.dart';

class HomeTasks extends StatelessWidget {

  const HomeTasks({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Selector<HomeController, String>(
              selector: (context, controller) => controller.filterSelected.label, 
              builder: (context, label, child) {
                return Text('TASK\'S $label',
                  style: context.titleStyle,
                );
              },
              ),
            Column(
              children: context
              .select<HomeController, List<TaskModel>>(
              (controller) => controller.filteredTasks)
                .map((task) => Task(taskModel: task,))
                .toList(),   
            ),
          ],
        ),
        );
  }
}