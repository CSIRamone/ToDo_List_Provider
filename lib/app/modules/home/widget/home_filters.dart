import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';
import 'package:todo_list_provider/app/modules/home/widget/todo_card.filter.dart';

class HomeFilters extends StatefulWidget {

  const HomeFilters({ Key? key }) : super(key: key);

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
   @override
   Widget build(BuildContext context) {
       return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FILTROS', style: context.titleStyle,
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              
          ],),
        ),
        ],

       );
  }
}