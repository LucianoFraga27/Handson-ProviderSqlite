import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/app_widget.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SqliteConnectionFactory(),
        lazy: false, // lazy false significa que desejamos que o usuario crie suas migrations assim que executado
        )
      ],
      child: const AppWidget()
    );
  }
}