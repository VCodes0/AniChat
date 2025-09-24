import 'package:anichat/services/auth_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ANI CHAT"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed: () async {
              await AuthServices.signOut();
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Welcome to AniChat!",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
