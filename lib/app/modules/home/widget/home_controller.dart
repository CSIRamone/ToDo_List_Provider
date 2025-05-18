import 'package:todo_list_provider/app/core/notifier/todolist_default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks.model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class HomeController extends TodolistDefaultChangeNotifier {
  final TasksService _tasksService;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  var filterSelected = TaskFilterEnum.today;

  TotalTasksModel? todayTasksModel;
  TotalTasksModel? tomorrowTasksModel;
  TotalTasksModel? weekTasksModel;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateWeek;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTasksModel = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );
    tomorrowTasksModel = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );
    weekTasksModel = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();

    List<TaskModel> tasks = [];

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekTasks = await _tasksService.getWeek();
        initialDateWeek = weekTasks.startDate;
        tasks = weekTasks.tasks;
        break;
    }
    allTasks = tasks;
    filteredTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByDay(selectedDay!);
      } else if (initialDateWeek != null) {
        filterByDay(initialDateWeek!);
      }
    } else {
      selectedDay = null;
    }

    if (!showFinishingTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
   }
    hideLoading();
    notifyListeners();
    
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) {
      return task.datetime.day == date.day;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await loadTotalTasks();
    await findTasks(filter: filterSelected);
    notifyListeners();
  }

  Future<void> checkOrUncheck(TaskModel task) async {
   try {
    showLoadingAndResetState();
    notifyListeners();

    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUncheck(taskUpdate);
  } catch (e) {
    print('Erro em checkOrUncheck: $e');
  } finally {
    hideLoading();
    await refreshPage();
  }
   
  }

  void showOrHideFinishingTasks() {
    showFinishingTasks = !showFinishingTasks;
   
    refreshPage();

  }
  
}
