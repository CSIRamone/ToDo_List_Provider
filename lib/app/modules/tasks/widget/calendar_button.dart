import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';

class CalendarButton extends StatelessWidget {

  final dateFormat = DateFormat('dd/MM/yyyy');

  CalendarButton({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return InkWell(
        onTap: () async {
          var lastDate = DateTime.now();
          lastDate = lastDate.add(Duration(days: 30 * 365));
          final DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1970),
            lastDate: lastDate,
          );
          context.read<TasksCreateController>().selectedDate = selectedDate;

        },
        borderRadius: BorderRadius.circular(25),
         child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_today, color: Colors.grey,),
              SizedBox(width: 10,),
              Selector<TasksCreateController, DateTime?>(
                selector: (context, controller) => controller.selectedDate,
                builder: (context, selectedDate, child) {
                  if (selectedDate != null) {
                    return Text(
                      dateFormat.format(selectedDate),
                      style: context.titleStyle,
                    );
                  }else {
                    return Text(
                      'SELECIONE UMA DATA',
                      style: context.titleStyle,
                    );
                  }
                }),

              //Text('SELECIONE UMA DATA', style: context.titleStyle,),
              SizedBox(width: 10,),
            //  Icon(Icons.arrow_forward_ios, color: Colors.grey,),
            ],
          ),
         ),
       );
  }
}