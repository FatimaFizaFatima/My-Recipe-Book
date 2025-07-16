import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiHelper {
  Rx<Color> createButtonColor() {
    return Colors.transparent.obs;
  }

  RxBool isObscure = true.obs;
  final RxBool isRememberMeChecked = false.obs;
  Widget DisplayButton({
    required String title,
    required VoidCallback onPressed,
    required Rx<Color> buttonBgColor,
  }) {
    return SizedBox(
      width: Get.width * 0.9,
      height: Get.height * 0.06,
      child: Obx(
        () => OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: buttonBgColor.value,
          ),
          onPressed: () {
            buttonBgColor.value = Colors.blue;
            onPressed();
          },
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: Get.height * 0.02,
              fontWeight: FontWeight.w400,
              fontFamily: 'Sen',
            ),
          ),
        ),
      ),
    );
  }

  Widget EmailTextField({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    Function(String)? onChanged,
  }) {
    return SizedBox(
      width: Get.width * 0.9,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: title,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Sen',
              fontSize: Get.height * 0.015),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        cursorColor: Colors.white,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sen',
            fontSize: Get.height * 0.02),
      ),
    );
  }

  Widget NameTextField({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
  }) {
    return SizedBox(
      width: Get.width * 0.9,
      child: TextField(
        controller: controller, // ASSIGN: Pass the controller to TextField
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: title,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Sen',
              fontSize: Get.height * 0.015),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        cursorColor: Colors.white,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sen',
            fontSize: Get.height * 0.02),
      ),
    );
  }

  Widget PasswordTextField({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    Function(String)? onChanged,
  }) {
    return Obx(() => SizedBox(
          width: Get.width * 0.9,
          child: TextField(
            obscureText: isObscure.value,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: title,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sen',
                  fontSize: Get.height * 0.015),
              prefixIcon: Icon(
                icon,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure.value ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  isObscure.value = !isObscure.value;
                },
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            cursorColor: Colors.white,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Sen',
                fontSize: Get.height * 0.02),
          ),
        ));
  }

  Widget BuildRememberMeAndForgot({
    required RxBool isRememberMeChecked,
    required VoidCallback onForgotPasswordTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Row(
                children: [
                  Checkbox(
                    value: isRememberMeChecked.value,
                    onChanged: (newValue) {
                      isRememberMeChecked.value = newValue!;
                    },
                    activeColor: Colors.blue,
                  ),
                  Text(
                    "Remember Me",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Sen',
                        fontSize: Get.height * 0.015),
                  ),
                ],
              )),
          GestureDetector(
            onTap: onForgotPasswordTap, // Use the passed callback
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                  color: const Color.fromARGB(255, 84, 121, 243),
                  fontFamily: 'Sen',
                  fontSize: Get.height * 0.015),
            ),
          ),
        ],
      ),
    );
  }

  Widget RecipeTextField({
    required String title,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipe Name",
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: Get.height * 0.018,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.local_dining, color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: "e.g. Spaghetti Carbonara",
              hintStyle: TextStyle(color: Colors.grey[500]),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            cursorColor: Colors.white,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Sen',
                fontSize: Get.height * 0.015),
          ),
        ],
      ),
    );
  }

  Widget RecipeDescriptionTextField({
    required String title,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.01),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sen',
              fontSize: Get.height * 0.018,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.9,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Sen',
                fontSize: Get.height * 0.015,
              ),
              prefixIcon: Icon(icon, color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            cursorColor: Colors.white,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sen',
              fontSize: Get.height * 0.015,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
