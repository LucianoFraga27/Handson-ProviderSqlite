import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/app_module.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/modules/home/widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home PAge'),
      ),
      drawer: HomeDrawer(),
      body: Container()
    );
  }
}
