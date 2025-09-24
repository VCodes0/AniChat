import 'package:anichat/screens/signup/signup_screen.dart';
import 'package:anichat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: AuthServices.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                "assets/animation/msg.json",
                width: mq.width,
                height: mq.height,
                fit: BoxFit.contain,
              ),
            );
          }

          Future.delayed(const Duration(seconds: 2), () {
            if (snapshot.hasData) {
              Get.offAll(() => const HomeScreen());
            } else {
              Get.offAll(() => const SignupScreen());
            }
          });

          return Center(
            child: Lottie.asset(
              "assets/animation/msg.json",
              width: mq.width,
              height: mq.height,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
