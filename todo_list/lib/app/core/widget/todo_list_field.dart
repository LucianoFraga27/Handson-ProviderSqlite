import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final Icon? suffixIcon;
  final bool obscureText;
  
  const TodoListField({ super.key, required this.label, this.obscureText=false, this.suffixIcon, this.suffixIconButton })
  : assert ( obscureText == true ? suffixIconButton == null : true, "Obscure Text não pode ser enviado em conjunto com suffix icon button");
  

   @override
   Widget build(BuildContext context) {
       return TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red
            )
          ),
          isDense: true,
          suffixIcon: suffixIcon ??
          (obscureText == true ? IconButton(onPressed: (){



          },icon: const Icon(TodoListIcons.eye, size: 15)) : null)
        ),
        obscureText: obscureText,
        
       );
  }
}