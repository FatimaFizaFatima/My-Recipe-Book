// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipe/auth_controller.dart';
import 'package:food_recipe/screens/home.dart';
import 'package:food_recipe/screens/onboardScreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log('Is user logged in: $isLoggedIn');

    if (isLoggedIn) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => const Onboardscreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.9)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welocome To Recipe App",
                style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: Get.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Center(
                child: Icon(
              Icons.restaurant_menu_outlined,
              color: Colors.white,
            ))
          ],
        ),
      ),
    );
  }
}
