import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';

class CalendarButton extends StatelessWidget {

  const CalendarButton({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Container(
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
            Text('SELECIONE UMA DATA', style: context.titleStyle,),
            SizedBox(width: 10,),
          //  Icon(Icons.arrow_forward_ios, color: Colors.grey,),
          ],
        ),
       );
  }
}