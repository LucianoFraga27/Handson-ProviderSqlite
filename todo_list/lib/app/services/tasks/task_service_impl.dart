
import 'package:todo_list/app/repositories/tasks/taks_repository.dart';
import 'package:todo_list/app/services/tasks/task_service.dart';

class TaskServiceImpl implements TaskService {
  
  final TasksRepository _tasksRepository;
  
  TaskServiceImpl ({required TasksRepository taskRepository}) : _tasksRepository = taskRepository;
  
  @override
  Future<void> save(DateTime data, String description) => _tasksRepository.save(data, description);
   
}