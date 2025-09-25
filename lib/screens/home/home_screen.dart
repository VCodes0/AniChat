import 'package:anichat/screens/profile/profile_screen.dart';
import 'package:anichat/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthServices.auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("AniChat"),
        leading: IconButton(
          color: CupertinoColors.black,
          icon: Icon(CupertinoIcons.person),
          onPressed: () {
            if (user != null) {
              Get.to(() => ProfileScreen(user: user));
            } else {
              Get.snackbar("Error", "User not logged in");
            }
          },
        ),
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
