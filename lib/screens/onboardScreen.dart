import 'package:flutter/material.dart';
import 'package:food_recipe/screens/loginScreen.dart';
import 'package:food_recipe/screens/signupscreen.dart';
import 'package:food_recipe/utils/utils.dart';
import 'package:get/get.dart';

class Onboardscreen extends StatefulWidget {
  const Onboardscreen({super.key});

  @override
  State<Onboardscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Onboardscreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final Rx<Color> loginButtonColor = Colors.transparent.obs;
    final Rx<Color> signupButtonColor = Colors.transparent.obs;
    final uiHelper = UiHelper();
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Image.asset(
              'assets/images/food1.jpg',
              width: Get.width * 1,
              height: Get.height * 0.55,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.02),
                  child: Center(
                    child: Text(
                      'Cooking A Delicious',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.height * 0.035,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Sen'),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Food Easily',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * 0.035,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Sen'),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: Get.height * 0.03),
              child: Center(
                child: Text(
                  'Discover, create and save delicious recipes with ease, all in one app, right at your fingertips!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.height * 0.02,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sen'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.05),
              child: uiHelper.DisplayButton(
                title: 'Login',
                onPressed: () => {Get.to(() => Loginscreen())},
                buttonBgColor: loginButtonColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.01),
              child: uiHelper.DisplayButton(
                title: "Sign-up",
                onPressed: () => {Get.to(() => Signupscreen())},
                buttonBgColor: signupButtonColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
