import '../../services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../home/home_screen.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

                      // Welcome Back Message
                      Text(
                        'Welcome Back 👋',
                        style: TextStyle(
                          fontSize: mq.width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: mq.height * 0.012),

                      // Login to your account
                      Text(
                        'Login to your account',
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
                        isPassword: true,
                      ),

                      SizedBox(height: mq.height * 0.04),

                      // Login Button
                      CustomButton(
                        text: 'Log in',
                        onTap: () async {
                          bool isSuccess = await AuthServices.logIn(
                            emailController.text,
                            passwordController.text,
                          );

                          if (isSuccess) {
                            Get.offAll(() => HomeScreen());
                          }
                        },
                      ),

                      SizedBox(height: mq.height * 0.025),

                      // Sign Up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () =>
                                Get.offAll(() => const SignupScreen()),
                            child: const Text('Sign Up'),
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
