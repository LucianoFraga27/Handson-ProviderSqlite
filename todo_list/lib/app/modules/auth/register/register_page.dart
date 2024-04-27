import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Todo List", style: TextStyle(fontSize: 10, color: context.primaryColor)),
            Text("Cadastro", style: TextStyle(fontSize: 14, color: context.primaryColor))
          ],
        ),
        automaticallyImplyLeading:
            false, // isso remove o botão de voltar da app bar por padrão
        leading: IconButton(
          icon: ClipOval(
            child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: context.primaryColor,
                )),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(),
    );
  }
}
