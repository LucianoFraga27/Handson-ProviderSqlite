import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class TodoCardFilter extends StatefulWidget {
  const TodoCardFilter({super.key});

  @override
  State<TodoCardFilter> createState() => _TodoCardFilterState();
}

class _TodoCardFilterState extends State<TodoCardFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      constraints: _boxConstraints(),
      decoration: _boxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("10 TASKS", style: context.titleStyle.copyWith(
            fontSize: 10,
            color: Colors.white
          ),),
          const Text("HOJE", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            
          ),),
          LinearProgressIndicator(
            backgroundColor: context.primaryColorLight,
            value: 0.4,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
        color: context.primaryColor,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(30));
  }

  BoxConstraints _boxConstraints() {
    return const BoxConstraints(
      minHeight: 120,
      maxWidth: 150,
    );
  }
}
