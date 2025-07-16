import 'package:flutter/material.dart';
import 'package:food_recipe/auth_controller.dart';
import 'package:food_recipe/utils/utils.dart';
import 'package:get/get.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final Rx<Color> loginButtonColor = Colors.transparent.obs;
  final RxBool isRememberMeChecked = false.obs;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadRememberedCredentials() async {
    final credentials = await authController.getRememberedCredentials();
    final rememberMeState = await authController.getRememberMeCheckedState();

    if (rememberMeState && credentials['email']!.isNotEmpty) {
      emailController.text = credentials['email']!;
      passwordController.text = credentials['password']!;
      isRememberMeChecked.value = true;
    } else {
      isRememberMeChecked.value = false;
    }
  }

  bool hasSpecialCharacter(String password) {
    return RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  bool hasNumber(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  bool validateFields() {
    bool isValid = true;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      emailError.value = "Email is required";
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
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
    } else {
      passwordError.value = "";
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper();

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
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: Get.height * 0.2),
                child: const Icon(
                  Icons.restaurant,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.01),
                child: Center(
                  child: Text(
                    "Login to the Recipe App",
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: Get.height * 0.03,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.05),

              // Email Field
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.07,
                    bottom: Get.height * 0.01,
                  ),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: Get.height * 0.02,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              uiHelper.EmailTextField(
                title: "example@gmail.com",
                icon: Icons.email,
                controller: emailController,
                onChanged: (value) {
                  // Clear error when user types
                  if (emailError.isNotEmpty) validateFields();
                },
              ),
              Obx(() => Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.12),
                    child: Text(
                      emailError.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.012,
                      ),
                    ),
                  )),
              SizedBox(height: Get.height * 0.02),

              // Password Field
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.07,
                    bottom: Get.height * 0.01,
                  ),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: Get.height * 0.02,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              uiHelper.PasswordTextField(
                title: "* * * * * *",
                icon: Icons.lock,
                controller: passwordController,
                onChanged: (value) {
                  if (passwordError.isNotEmpty) validateFields();
                },
              ),
              Obx(() => Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.12),
                    child: Text(
                      passwordError.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.012,
                      ),
                    ),
                  )),

              uiHelper.BuildRememberMeAndForgot(
                  isRememberMeChecked: isRememberMeChecked,
                  onForgotPasswordTap: () {}),
              SizedBox(height: Get.height * 0.03),

              // Login Button
              uiHelper.DisplayButton(
                title: "Login",
                onPressed: () async {
                  if (validateFields()) {
                    await authController.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      isRememberMeChecked.value,
                    );
                  }
                },
                buttonBgColor: loginButtonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
