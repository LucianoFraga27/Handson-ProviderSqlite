import 'package:flutter/material.dart';
import 'package:todo_list/app/core/widget/todo_list_logo.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox (
                  constraints: BoxConstraints(
                    minHeight: constraint.maxHeight,
                    minWidth: constraint.maxHeight
                  ),
                  child: const IntrinsicHeight( // O IntrinsicHeight permite que o column seja de qualquer tamanho que a tela acompanhará 
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         SizedBox(height: 10),
                         TodoListLogo()
                      ],
                    ),
                  ),
                ),
              );
            },
           ),
       );
  }
}