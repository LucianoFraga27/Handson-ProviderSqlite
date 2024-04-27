import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Splash Page"),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/login");
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}