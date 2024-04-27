import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/core/widget/todo_list_field.dart';
import 'package:todo_list/app/core/widget/todo_list_logo.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Todo List",
                style: TextStyle(fontSize: 10, color: context.primaryColor)),
            Text("Cadastro",
                style: TextStyle(fontSize: 14, color: context.primaryColor))
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
      body:  ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: const FittedBox(
                fit: BoxFit.fitHeight,
                child: TodoListLogo(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Form(
                key: _formKey,
                  child: Column(
                children: [
                  TodoListField(
                    label: "Email",
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required("Email obrigatório"),
                      Validatorless.email("Email inválido"),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: "Senha",
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required("Senha obrigatória"),
                      Validatorless.min(
                          6, "Senha deve ter pelo menos 6 caracteres")
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: "Confirmar Senha",
                    obscureText: true,
                    controller: _confirmPasswordEC,
                    validator: Validatorless.multiple([
                      Validatorless.compare(
                          _passwordEC, "As senhas não coincidem")
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final _formValid = _formKey.currentState?.validate();
                        
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
     
    );
  }
}
