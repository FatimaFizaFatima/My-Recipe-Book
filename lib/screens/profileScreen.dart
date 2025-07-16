import 'package:flutter/material.dart';
import 'package:food_recipe/auth_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Ensure this is imported

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // CORRECT: Use Get.find() here as AuthController is put globally
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: Get.height * 0.025,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121212),
              Color(0xFF1E1E1E),
            ],
          ),
        ),
        child: Obx(() {
          final user = authController.user.value;

          if (authController.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          if (user == null) {
            return Center(
              child: Text(
                'No user logged in. Please log in to view your profile.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Get.height * 0.02,
                  fontFamily: 'Sen',
                ),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(Get.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.03),
                CircleAvatar(
                  radius: Get.width * 0.18,
                  backgroundColor: Colors.blueGrey[800],
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : null,
                  child: user.photoURL == null
                      ? Icon(
                          Icons.person,
                          size: Get.width * 0.15,
                          color: Colors.white,
                        )
                      : null,
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  user.displayName ?? 'No name provided',
                  style: TextStyle(
                    fontSize: Get.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Sen',
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  user.email ?? 'No email provided',
                  style: TextStyle(
                    fontSize: Get.height * 0.018,
                    color: Colors.white70,
                    fontFamily: 'Sen',
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                SizedBox(
                  width: Get.width * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Logout',
                        titleStyle: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Sen',
                          fontSize: Get.height * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                        middleText: 'Are you sure you want to log out?',
                        middleTextStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Sen',
                          fontSize: Get.height * 0.018,
                        ),
                        textConfirm: 'Yes',
                        textCancel: 'No',
                        confirmTextColor: Colors.white,
                        cancelTextColor: Colors.black87,
                        buttonColor: Colors.red,
                        onConfirm: () async {
                          await authController.logout();
                          Get.back();
                        },
                        radius: 15,
                      );
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: Get.height * 0.02,
                        fontFamily: 'Sen',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
