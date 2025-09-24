import 'dart:io';

import 'package:anichat/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return password.length >= 6;
  }

  // Log In
  static Future<void> logIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showError("Login Failed", "Please fill in all required fields");
      return;
    }

    if (!isValidEmail(email)) {
      showError("Invalid Email", "Please enter a valid email address");
      return;
    }

    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Optionally check if email is verified
      if (!credential.user!.emailVerified) {
        showError(
          "Email Not Verified",
          "Please verify your email before logging in.",
        );
        await auth.signOut();
        return;
      }

      showSuccess("Login Successful", "Welcome back!");
    } on FirebaseAuthException catch (e) {
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
    } catch (e) {
      showError("Error", "Something went wrong. Please try again.");
    }
  }

  // Sign Up
  static Future<void> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showError("Signup Failed", "Please fill in all required fields");
      return;
    }

    if (!isValidEmail(email)) {
      showError("Invalid Email", "Please enter a valid email address");
      return;
    }

    if (!isValidPassword(password)) {
      showError("Weak Password", "Password must be at least 6 characters long");
      return;
    }

    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Send email verification
      await credential.user?.sendEmailVerification();

      showSuccess(
        "Account Created",
        Platform.isAndroid || Platform.isIOS
            ? "Check your inbox for a verification link."
            : "Account created. Please verify your email.",
      );

      await auth.signOut();
    } on FirebaseAuthException catch (e) {
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
    } catch (e) {
      showError("Error", "Something went wrong. Please try again.");
    }
  }

  // Sign Out
  static Future<void> signOut() async {
    Get.dialog(
      Center(child: CircularProgressIndicator.adaptive()),
      barrierDismissible: false,
    );

    try {
      await auth.signOut();
      Get.back();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.back();
      showError("Sign Out Failed", e.toString());
    }
  }

  // Get Current User
  static User? getCurrentUser() {
    return auth.currentUser;
  }

  // Check if user is logged in and email verified
  static bool isUserLoggedIn() {
    final user = auth.currentUser;
    return user != null && user.emailVerified;
  }
}
