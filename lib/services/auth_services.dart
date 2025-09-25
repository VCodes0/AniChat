import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/login/login_screen.dart';

class AuthServices {
  // Firebase Authentication instance
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Email validation
  static bool isValidEmail(String email) {
    return GetUtils.isEmail(email);
  }

  // Password validation
  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  // Log In
  static Future<bool> logIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showError("Login Failed", "Please fill in all required fields");
      return false;
    }

    if (!isValidEmail(email)) {
      showError("Invalid Email", "Please enter a valid email address");
      return false;
    }

    Get.dialog(
      Center(child: CircularProgressIndicator.adaptive()),
      barrierDismissible: false,
    );

    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      Get.back();
      showSuccess("Login Successful", "Welcome back!");
      return true;
    } on FirebaseAuthException catch (e) {
      Get.back();
      String message = "";

      switch (e.code) {
        case 'user-not-found':
          message = "No user found with this email.";
          break;
        case 'wrong-password':
          message = "Incorrect password.";
          break;
        case 'invalid-email':
          message = "Invalid email format.";
          break;
        case 'user-disabled':
          message = "This account has been disabled.";
          break;
        default:
          message = "Login failed. ${e.message}";
      }

      showError("Login Error", message);
      return false;
    } catch (e) {
      showError("Error", "Something went wrong. Please try again.");
      return false;
    }
  }

  // Sign Up
  static Future<bool> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showError("Signup Failed", "Please fill in all required fields");
      return false;
    }

    if (!isValidEmail(email)) {
      showError("Invalid Email", "Please enter a valid email address");
      return false;
    }

    if (!isValidPassword(password)) {
      showError("Weak Password", "Password must be at least 8 characters long");
      return false;
    }

    Get.dialog(
      Center(child: CircularProgressIndicator.adaptive()),
      barrierDismissible: false,
    );

    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      Get.back;
      showSuccess("Account Created Successful", "Welcome to AniChat!");
      return true;
    } on FirebaseAuthException catch (e) {
      Get.back();
      String message = "";

      switch (e.code) {
        case 'email-already-in-use':
          message = "This email is already registered.";
          break;
        case 'invalid-email':
          message = "Invalid email format.";
          break;
        case 'weak-password':
          message = "Password is too weak.";
          break;
        default:
          message = "Signup failed. ${e.message}";
      }
      showError("Signup Error", message);
      return false;
    } catch (e) {
      Get.back();
      showError("Error", "Something went wrong. Please try again.");
      return false;
    }
  }

  // Sign Out
  static Future<bool> signOut() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator.adaptive()),
      barrierDismissible: false,
    );

    try {
      await auth.signOut();
      Get.back();
      Get.offAll(() => LoginScreen());
      return true;
    } catch (e) {
      Get.back();
      showError("Sign Out Failed", e.toString());
      return false;
    }
  }
}
