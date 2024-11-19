import 'package:provider/provider.dart';
import 'package:todo_list/app/core/modules/todo_list_module.dart';
import 'package:todo_list/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list/app/modules/tasks/task_create_page.dart';
import 'package:todo_list/app/repositories/tasks/taks_repository.dart';
import 'package:todo_list/app/repositories/tasks/taks_repository_impl.dart';
import 'package:todo_list/app/services/tasks/task_service.dart';
import 'package:todo_list/app/services/tasks/task_service_impl.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(bindings: [
          Provider<TasksRepository>(
              create: (context) =>
                  TasksRepositoryImpl(sqlLiteConnection: context.read())),
          Provider<TaskService>(
              create: (context) =>
                  TaskServiceImpl(taskRepository: context.read())),
          ChangeNotifierProvider(
              create: (context) =>
                  TaskCreateController(taskService: context.read()))
        ], routers: {
          '/task/create': (context) =>
              TaskCreatePage(controller: context.read())
        });
}
