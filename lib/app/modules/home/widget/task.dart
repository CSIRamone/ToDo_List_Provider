import 'package:flutter/material.dart';

class Task extends StatelessWidget {

  const Task({ Key? key }) : super(key: key);

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
              value: true, 
              onChanged: (value){},
              ),
              title: Text('Descrição da TASK',
              style: TextStyle(
                decoration: true ? TextDecoration.lineThrough : TextDecoration.none,
              ),
              ),
              subtitle: Text('25/04/2025', 
              style: TextStyle(
                decoration: true ? TextDecoration.lineThrough : TextDecoration.none,
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