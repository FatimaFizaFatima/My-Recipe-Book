import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe/utils/utils.dart';
import 'package:food_recipe/widgets/RecipeImagePicker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController recipeDescController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Color> addRecipeButtonColor = Colors.transparent.obs;
  final box = GetStorage();

  final List<String> categories = ["Breakfast", "Lunch", "Dinner", "Snacks"];
  String selectedCategory = "Breakfast";

  void saveRecipe() {
    String name = recipeNameController.text.trim();
    String description = recipeDescController.text.trim();
    String? imagePath = selectedImage.value?.path;

    if (name.isNotEmpty && description.isNotEmpty && imagePath != null) {
      List recipes = box.read<List>('recipes') ?? [];

      bool exists = recipes.any((recipe) => recipe['name'] == name);
      if (!exists) {
        recipes.add({
          "name": name,
          "description": description,
          "imagePath": imagePath,
          "createdAt": DateTime.now().toIso8601String(),
          "category": selectedCategory,
          "isFavorite": false,
        });

        box.write('recipes', recipes);
        Get.snackbar("Success", "Recipe added successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);

        recipeNameController.clear();
        recipeDescController.clear();
        selectedImage.value = null;
      } else {
        Get.snackbar("Error", "Recipe already exists",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error", "Please fill all fields and select an image",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiHelper = UiHelper();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant, color: Colors.white, size: 26),
            SizedBox(width: 8),
            Text(
              "Add Your Recipe",
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  "Get inspired and create your own",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                uiHelper.RecipeTextField(
                  title: "Recipe Name",
                  icon: Icons.local_dining,
                  controller: recipeNameController,
                ),
                SizedBox(height: 24),
                uiHelper.RecipeDescriptionTextField(
                  title: "Recipe Description",
                  icon: Icons.menu_book,
                  controller: recipeDescController,
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  dropdownColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  iconEnabledColor: Colors.white,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category,
                          style: TextStyle(
                              fontFamily: 'Sen', color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                RecipeImagePicker(
                  title: 'Recipe Image',
                  icon: Icons.camera_alt_outlined,
                  selectedImage: selectedImage,
                ),
                SizedBox(height: 24),
                uiHelper.DisplayButton(
                  title: "Save Recipe",
                  onPressed: saveRecipe,
                  buttonBgColor: addRecipeButtonColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
