import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list/app/services/tasks/task_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  TaskService _taskService;
  DateTime? _selectedDate;

  TaskCreateController({required TaskService taskService})
      : _taskService = taskService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  void save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _taskService.save(_selectedDate!, description);
        success();
      } else {
        setError("Data da Tarefa não selecionada");
      }
    } on Exception catch (e) {
      print(e);
      setError("Erro ao cadastrar Tarefa");
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
