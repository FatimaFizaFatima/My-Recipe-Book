// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_recipe/auth_controller.dart';
import 'package:food_recipe/utils/utils.dart';
import 'package:get/get.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final Rx<Color> signupButtonColor = Colors.transparent.obs;
    final uiHelper = UiHelper();
    String password = passwordController.text;

    RxString emailError = ''.obs;
    RxString passwordError = ''.obs;
    RxString retypePasswordError = ''.obs;
    final RxString nameError = ''.obs;

    bool hasSpecialCharacter(String password) {
      return RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
    }

    bool hasNumber(String password) {
      return RegExp(r'[0-9]').hasMatch(password);
    }

    bool hasUppercase(String password) {
      return RegExp(r'[A-Z]').hasMatch(password);
    }

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      retypePasswordController.dispose();
      nameController.dispose();
      super.dispose();
    }

    bool validateFields() {
      bool isValid = true;

      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final rePassword = retypePasswordController.text.trim();
      final name = nameController.text.trim();

      if (name.isEmpty) {
        nameError.value = "Name is required";
        isValid = false;
      } else {
        nameError.value = "";
      }

      if (email.isEmpty) {
        emailError.value = "Email is required";
        isValid = false;
      } else if (!GetUtils.isEmail(email)) {
        emailError.value = "Enter a valid email address";
        isValid = false;
      } else {
        emailError.value = "";
      }

      if (password.isEmpty) {
        passwordError.value = "Password is required";
        isValid = false;
      } else if (password.length < 8) {
        passwordError.value = "Password must be at least 8 characters";
        isValid = false;
      } else if (!hasSpecialCharacter(password)) {
        passwordError.value =
            "Password must contain at least 1 special character";
        isValid = false;
      } else if (!hasNumber(password)) {
        passwordError.value = "Password must contain at least 1 number";
        isValid = false;
      } else if (!hasUppercase(password)) {
        passwordError.value =
            "Password must contain at least 1 uppercase letter";
        isValid = false;
      } else {
        passwordError.value = "";
      }

      if (rePassword.isEmpty) {
        retypePasswordError.value = "Re-type password is required";
        isValid = false;
      } else if (password != rePassword) {
        retypePasswordError.value = "Passwords do not match";
        isValid = false;
      } else {
        retypePasswordError.value = "";
      }

      return isValid;
    }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: Get.height * 0.2),
                child: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.01),
                child: Center(
                  child: Text(
                    "Sign-Up to the Recipe App",
                    style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.03,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.07, bottom: Get.height * 0.01),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              uiHelper.NameTextField(
                title: "Enter Your Name",
                icon: Icons.person,
                controller: nameController,
                onChanged: (value) {
                  if (nameError.isNotEmpty) validateFields();
                },
              ),
              Obx(() => nameError.value.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(nameError.value,
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Sen',
                                fontSize: Get.height * 0.012)),
                      ),
                    )
                  : SizedBox()),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.07, bottom: Get.height * 0.01),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              uiHelper.EmailTextField(
                  title: "example@gmail.com",
                  icon: Icons.email,
                  controller: emailController),
              Obx(() => emailError.value.isNotEmpty
                  ? Text(emailError.value,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Sen',
                          fontSize: Get.height * 0.012))
                  : SizedBox()),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.07, bottom: Get.height * 0.01),
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              uiHelper.PasswordTextField(
                  title: "* * * * * *",
                  icon: Icons.lock,
                  controller: passwordController),
              Obx(() => passwordError.value.isNotEmpty
                  ? Text(passwordError.value,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Sen',
                          fontSize: Get.height * 0.012))
                  : SizedBox()),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.07, bottom: Get.height * 0.01),
                  child: Text(
                    'Re-type Password',
                    style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              uiHelper.PasswordTextField(
                  title: "* * * * * *",
                  icon: Icons.lock,
                  controller: retypePasswordController),
              Obx(() => retypePasswordError.value.isNotEmpty
                  ? Text(retypePasswordError.value,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Sen',
                          fontSize: Get.height * 0.012))
                  : SizedBox()),
              SizedBox(
                height: Get.height * 0.03,
              ),
              uiHelper.DisplayButton(
                  title: "Sign-Up",
                  onPressed: () async {
                    if (validateFields()) {
                      await authController.signup(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        nameController.text.trim(),
                      );
                    }
                  },
                  buttonBgColor: signupButtonColor),
            ],
          ),
        ),
      ),
    );
  }
}
