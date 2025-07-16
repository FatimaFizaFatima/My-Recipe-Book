import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var user = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> saveLoginCredentials(
      String email, String password, bool rememberMe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('rememberedEmail', email);
      await prefs.setString('rememberedPassword', password);
      await prefs.setBool('rememberMeChecked', true);
    } else {
      await prefs.remove('rememberedEmail');
      await prefs.remove('rememberedPassword');
      await prefs.setBool('rememberMeChecked', false);
    }
  }

  Future<Map<String, String>> getRememberedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('rememberedEmail') ?? '';
    String password = prefs.getString('rememberedPassword') ?? '';
    return {'email': email, 'password': password};
  }

  Future<bool> getRememberMeCheckedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMeChecked') ?? false;
  }

  Future<void> login(String email, String password, bool rememberMe) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      await saveLoginCredentials(email, password, rememberMe);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Get.snackbar("Success", "Login successful!",
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login failed",
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password, String name) async {
    try {
      isLoading.value = true;

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
      user.value = _auth.currentUser;

      Get.snackbar("Success", "Signup successful!",
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Error", "The password provided is too weak.",
            backgroundColor: Colors.black87,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The account already exists for that email.",
            backgroundColor: Colors.black87,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Error", e.message ?? "Signup failed",
            backgroundColor: Colors.black87,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await _auth.signOut();
    await saveLoginCredentials('', '', false);
    Get.offAllNamed('/login');
  }

  Future<bool> shouldSkipLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMeChecked') ?? false;
    bool isLoggedIn = _auth.currentUser != null;
    return rememberMe && isLoggedIn;
  }
}
