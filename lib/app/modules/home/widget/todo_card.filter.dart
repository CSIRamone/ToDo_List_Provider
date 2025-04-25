import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';

class TodoCardFilter extends StatelessWidget {

  const TodoCardFilter({ super.key });

   @override
   Widget build(BuildContext context) {
       return Container(
        constraints: BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.primaryColor,
          border: Border.all(  
            width: 1,
            color: Colors.grey.withOpacity(0.8), 
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('10 TASKS', style: context.titleStyle.copyWith(
                fontSize: 10,
                color: Colors.white,
              ),
              ),
              Text('HOJE', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
              LinearProgressIndicator(
                backgroundColor: context.primaryColorLight,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 5, 
                value: 0.4,
              ),
            ],
          ),
        );
  }
}