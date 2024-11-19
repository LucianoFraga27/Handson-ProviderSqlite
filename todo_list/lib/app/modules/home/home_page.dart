import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/core/ui/todo_list_icons.dart';
import 'package:todo_list/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list/app/modules/home/widgets/home_header.dart';
import 'package:todo_list/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list/app/modules/tasks/task_create_page.dart';
import 'package:todo_list/app/modules/tasks/tasks_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(microseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // https://www.youtube.com/watch?v=d0wsoY6meBY
        animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
        return ScaleTransition(
            scale: animation, alignment: Alignment.bottomRight, child: child);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return TasksModule().getPage("/task/create", context);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(child: Text("Mostrar Tarefas concluidas"))
              ],
              icon: const Icon(TodoListIcons.filter),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _goToCreateTask(context),
          backgroundColor: context.primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        drawer: HomeDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: const IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        HomeFilters(),
                        HomeWeekFilter(),
                        HomeTasks()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
