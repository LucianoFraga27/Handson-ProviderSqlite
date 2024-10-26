import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final Icon? suffixIcon;
  final bool obscureText;

  final ValueNotifier<bool> obscureTextVM;

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  TodoListField(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.suffixIcon,
      this.suffixIconButton,
      this.controller,
      this.validator,
      this.focusNode
      })
      : assert(obscureText == true ? suffixIconButton == null : true,
            "Obscure Text não pode ser enviado em conjunto com suffix icon button"),
        obscureTextVM = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVM,
      builder: (_, obscureTextVALUE, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.red)),
              isDense: true,
              suffixIcon: suffixIcon ??
                  (obscureText == true
                      ? IconButton(
                          onPressed: () {
                            obscureTextVM.value = !obscureTextVALUE;
                          },
                          icon: Icon( !obscureTextVALUE ? TodoListIcons.eye_slash : TodoListIcons.eye, size: 15))
                      : null)),
          obscureText: obscureTextVALUE,  
        );
      },
    );
  }
}
