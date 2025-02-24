import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/widget/todo_list_field.dart';
import 'package:todo_list/app/core/widget/todo_list_logo.dart';
import 'package:todo_list/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();
  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      successCallBack: (notifier, listener) {
      //  print("Sucesso ao fazer login!!!!!!!!!!!!!!!!");
      },
      everCallBack: (notifier, listener) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraint.maxHeight,
                  minWidth: constraint.maxHeight),
              child: IntrinsicHeight(
                // O IntrinsicHeight permite que o column seja de qualquer tamanho que a tela acompanhará
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Form(
                          key: _formKey,
                          child: Column(
                        children: [
                          TodoListField(
                            label: "Email",
                            controller: _emailEC,
                            focusNode: _emailFocus,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required("Email obrigatório"),
                                Validatorless.email("Email inválido"),
                              ]
                            ),
                          ),
                          const SizedBox(height: 20),
                          TodoListField(
                            label: "Senha",
                            controller: _passwordEC,
                            obscureText: true,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required("Senha obrigatória"),
                                Validatorless.min(6,"Senha deve conter ao menos 6 caracteres"),
                              ]
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    final email = _emailEC.text;
                                    if (email.isNotEmpty) {
                                      context.read<LoginController>().forgotPassword(email);
                                    } else {
                                      _emailFocus.requestFocus();
                                      Messages.of(context).showInfo("Digite um email para recuperar sua senha");
                                    }


                                  },
                                  child: const Text("Esqueceu sua senha?")),
                              ElevatedButton(
                                onPressed: () {
                                  final formValid = _formKey.currentState?.validate() ?? false;
                                  if (formValid) {
                                    final email = _emailEC.text;
                                    final password = _passwordEC.text ; 
                                    context.read<LoginController>().login( email,password );

                                  }

                                    

                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffF0F3F7),
                          border: Border(
                              top: BorderSide(
                                  width: 2, color: Colors.grey.withAlpha(50)))),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          SignInButton(Buttons.Google,
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                              text: "Continue com o Google",
                              onPressed: () {

                                context.read<LoginController>().loginGoogle();

                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Não tem conta?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/register");
                                  },
                                  child: const Text("Cadastre-se"))
                            ],
                          )
                        ],
                      ),
                    )),
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
