import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final nameVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(color: context.primaryColor.withAlpha(70)),
          child: Row(
            children: [
              Selector<AuthProviderTODOLIST, String>(
                  selector: (context, authProvider) {
                return authProvider.user?.photoURL ??
                    "https://media.istockphoto.com/id/1337144146/pt/vetorial/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=_XeYoSJQIN7GrE08cUQDJCo3U7yvoEp5OKpbhQzpmC0=";
              }, builder: (_, value, __) {
                return CircleAvatar(
                  backgroundImage: NetworkImage(value),
                  radius: 30,
                );
              }),
              Expanded(
                child: Selector<AuthProviderTODOLIST, String>(
                  selector: (context, authProvider) {
                    String name =
                        authProvider.user?.displayName ?? "Não informado";
                    return name;
                  },
                  builder: (_, value, __) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        style: context.textTheme.titleLarge,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () => {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Alterar Nome"),
                    content: TextField(
                      onChanged: (value) {
                        nameVN.value = value;
                      },
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            if (nameVN.value.isEmpty)  {
                              Messages.of(context)
                                  .showError("Nome Obrigatório");
                            } else {
                              Loader.show(context);
                              await context.read<UserService>().updateDisplayName(nameVN.value);
                              Loader.hide();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Alterar")),
                    ],
                  );
                })
          },
          title: const Text("Alterar nome"),
        ),
        ListTile(
          onTap: () => context.read<AuthProviderTODOLIST>().logout(),
          title: const Text("Sair"),
        ),
      ]),
    );
  }
}
