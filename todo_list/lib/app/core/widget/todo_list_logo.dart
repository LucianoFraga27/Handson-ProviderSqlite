import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart'; // importa a classe e usa o context.

class TodoListLogo extends StatelessWidget {

  const TodoListLogo({ super.key });

   @override
   Widget build(BuildContext context) {
       return Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png", height: 200),
          Text("Todo List")
        ],
       ) ;
       
  }
}