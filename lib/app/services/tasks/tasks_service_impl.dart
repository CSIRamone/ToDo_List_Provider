import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/modules/home/widget/task.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;
  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) {
    return _tasksRepository.save(date, description);
  }

  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepository.findByPeriod(
      DateTime.now(),
      DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    return _tasksRepository.findByPeriod(
      DateTime.now().add(const Duration(days: 1)),
      DateTime.now().add(const Duration(days: 1)));
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0,0,0);
    DateTime endFilter;

  if(startFilter.weekday != DateTime.monday) {
    startFilter = startFilter.subtract(Duration(days: startFilter.weekday - 1));
  }
  endFilter = startFilter.add(Duration(days: 7));
   
    final tasks = await _tasksRepository.findByPeriod(
      startFilter,
      endFilter);

    return WeekTaskModel(
      startDate: startFilter, 
      endDate: endFilter, 
      tasks: tasks);
  }
  
  @override
  Future<void> checkOrUncheck(TaskModel task) => _tasksRepository.checkOrUncheck(task);
}
