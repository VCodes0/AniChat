import 'package:anichat/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final lastSignIn = user.metadata.lastSignInTime;
    final formattedLastLogin = lastSignIn != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(lastSignIn)
        : 'N/A';

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return Scaffold(
      // Log Out Button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CupertinoColors.systemRed,
        foregroundColor: CupertinoColors.white,
        onPressed: () async {
          await AuthServices.signOut();
        },
        label: Text("Log Out"),
        icon: Icon(Icons.logout),
      ),

      // AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.email ?? 'N/A'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),

      // UI
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? screenWidth * 0.15 : 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image
                CircleAvatar(
                  radius: isTablet ? 90 : 70,
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : null,
                  backgroundColor: CupertinoColors.activeBlue,
                  child: user.photoURL == null
                      ? Text(
                          user.email != null && user.email!.isNotEmpty
                              ? user.email![0].toUpperCase()
                              : "?",
                          style: TextStyle(
                            fontSize: isTablet ? 50 : 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                SizedBox(height: screenHeight * 0.04),
                // Email Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(user.email ?? "No Email"),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Last Login Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Last Sign-In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(formattedLastLogin),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
