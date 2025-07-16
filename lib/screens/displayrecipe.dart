import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_recipe/screens/recipeDetailedScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShowRecipe extends StatefulWidget {
  const ShowRecipe({super.key});

  @override
  State<ShowRecipe> createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipe> {
  final box = GetStorage();

  void deleteRecipe(int index) {
    List recipes = box.read<List>('recipes') ?? [];
    String name = recipes[index]['name'];
    Get.defaultDialog(
      title: "Delete Recipe?",
      content: Text("Are you sure you want to delete \"$name\"?",
          style: TextStyle(
            fontFamily: 'Sen',
          )),
      confirm: ElevatedButton(
        onPressed: () {
          recipes.removeAt(index);
          box.write('recipes', recipes);
          setState(() {});
          Get.back();
          Get.snackbar("Deleted", "$name was removed.",
              backgroundColor: Colors.red, colorText: Colors.white);
        },
        child: Text("Yes", style: TextStyle(fontFamily: 'Sen')),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel", style: TextStyle(fontFamily: 'Sen')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List recipes = box.read<List>('recipes') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Recipes",
          style: TextStyle(
              fontFamily: 'Sen',
              fontSize: Get.height * 0.025,
              color: Colors.white,
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
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
        child: recipes.isEmpty
            ? Center(
                child: Text(
                  "No recipes found!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sen',
                      fontSize: Get.height * 0.02),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  var recipe = recipes[index];
                  String? imagePath = recipe['imagePath'];
                  return GestureDetector(
                    onTap: () =>
                        Get.to(() => RecipeDetailScreen(recipe: recipe)),
                    child: Card(
                      key: ValueKey(recipe['name']),
                      color: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading:
                            imagePath != null && File(imagePath).existsSync()
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(imagePath),
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.white54),
                                  ),
                        title: Text(
                          recipe['name'],
                          style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: Get.height * 0.015,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteRecipe(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
