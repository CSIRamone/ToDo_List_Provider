import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks.model.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widget/todo_card.filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'HOJE',
                selected: context.select<HomeController, TaskFilterEnum>(
                  (value) => value.filterSelected) == TaskFilterEnum.today,
                taskFilterEnum: TaskFilterEnum.today,
                totalTasksModel: context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.todayTasksModel),
              ),
              TodoCardFilter(
                label: 'AMANHÃ',
                selected: context.select<HomeController, TaskFilterEnum>(
                  (value) => value.filterSelected) == TaskFilterEnum.tomorrow,
                taskFilterEnum: TaskFilterEnum.tomorrow,
                totalTasksModel: context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.tomorrowTasksModel),
              ),
              TodoCardFilter(
                label: 'SEMANA',
                selected: context.select<HomeController, TaskFilterEnum>(
                  (value) => value.filterSelected) == TaskFilterEnum.week,
                taskFilterEnum: TaskFilterEnum.week,
                totalTasksModel: context.select<HomeController, TotalTasksModel?>(
                  (controller) => controller.weekTasksModel),
              )
            ],
          ),
        ),
      ],
    );
  }
}
