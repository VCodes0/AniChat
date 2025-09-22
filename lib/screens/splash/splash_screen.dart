import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    // This ensures the navigation runs only once, after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const LoginScreen());
      });
    });

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/animation/msg.json",
          width: mq.width,
          height: mq.height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
