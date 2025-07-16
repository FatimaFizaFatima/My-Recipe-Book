import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/screens/displayrecipe.dart';
import 'package:food_recipe/screens/favouriteScreen.dart';
import 'package:food_recipe/screens/profileScreen.dart';
import 'package:food_recipe/screens/userHomeScreen.dart';
import 'package:food_recipe/screens/user_recipe.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      init: NavController(),
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
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
              ),
              controller.screens[controller.selectedIndex],
            ],
          ),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, "Home", 0, controller),
                _buildNavItem(Icons.add, "Add Recipes", 1, controller),
                _buildNavItem(Icons.book, "Your Recipes", 2, controller),
                _buildNavItem(Icons.favorite, "Favourite", 3, controller),
                _buildNavItem(Icons.person, "Profile", 4, controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildNavItem(
    IconData icon, String label, int index, NavController controller) {
  return GestureDetector(
    onTap: () => controller.changeTab(index),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: controller.selectedIndex == index
              ? Colors.orangeAccent
              : Colors.white,
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: controller.selectedIndex == index
                ? Colors.orangeAccent
                : Colors.white,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 15),
      ],
    ),
  );
}

class NavController extends GetxController {
  int selectedIndex = 0;

  final List<Widget> screens = [
    UserHomeScreen(),
    AddRecipe(),
    ShowRecipe(),
    Favouritescreen(),
    UserProfileScreen(),
  ];

  void changeTab(int index) {
    selectedIndex = index;
    update();
  }
}
