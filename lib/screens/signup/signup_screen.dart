import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/google_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/divider.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: mq.height * 0.05),

                      // Title
                      Text(
                        'Create Account 😁️',
                        style: TextStyle(
                          fontSize: mq.width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: mq.height * 0.012),

                      // Subtitle
                      Text(
                        'Create Account and Join AniChat',
                        style: TextStyle(
                          fontSize: mq.width * 0.04,
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: mq.height * 0.05),

                      // Email
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        hintText: 'username@gmail.com',
                        labelText: 'Email',
                        prefixIcon: CupertinoIcons.mail,
                      ),

                      SizedBox(height: mq.height * 0.025),

                      // Password
                      CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        hintText: 'Password@123',
                        labelText: 'Password',
                        prefixIcon: CupertinoIcons.lock,
                      ),

                      SizedBox(height: mq.height * 0.04),

                      // Create Account Button
                      CustomButton(text: 'Create Account'),

                      SizedBox(height: mq.height * 0.025),

                      // Divider
                      OrDivider(),

                      SizedBox(height: mq.height * 0.025),

                      // Google Sign In Button
                      GoogleButton(),

                      SizedBox(height: mq.height * 0.05),

                      // Already have account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () =>
                                Get.offAll(() => const LoginScreen()),
                            child: const Text('Log in'),
                          ),
                        ],
                      ),

                      SizedBox(height: mq.height * 0.02),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
