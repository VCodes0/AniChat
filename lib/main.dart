import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AniChat());
}

class AniChat extends StatelessWidget {
  const AniChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AniChat',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,

      // Light Theme
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 21,
            letterSpacing: 1,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blueAccent,
        ),
      ),

      // Dark Theme (can customize further if needed)
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),

      home: const SplashScreen(),
    );
  }
}
