import 'package:todo_list_provider/app/core/notifier/todolist_default_change_notifier.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class TasksCreateController extends TodolistDefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TasksCreateController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    showLoadingAndResetState();
    notifyListeners();

    try {
      if (_selectedDate != null) {
        await _tasksService.save(
          _selectedDate!,
          description,
        );
        success();
      } else {
        setError('Data não selecionada');
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao salvar tarefa');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
