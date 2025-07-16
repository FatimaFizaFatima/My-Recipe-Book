import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_recipe/screens/recipeDetailedScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Favouritescreen extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    List allRecipes = box.read<List>('recipes') ?? [];
    List favRecipes =
        allRecipes.where((recipe) => recipe['isFavorite'] == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites",
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
        child: favRecipes.isEmpty
            ? Center(
                child: Text(
                  "No favorites yet!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sen',
                      fontSize: Get.height * 0.02),
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: favRecipes.length,
                itemBuilder: (context, index) {
                  var recipe = favRecipes[index];
                  String? imagePath = recipe['imagePath'];

                  return GestureDetector(
                    onTap: () =>
                        Get.to(() => RecipeDetailScreen(recipe: recipe)),
                    child: Card(
                      color: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Get.height * 0.15,
                            width: double.infinity,
                            child: imagePath != null &&
                                    File(imagePath).existsSync()
                                ? Image.file(
                                    File(imagePath),
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.grey[800],
                                    child: Center(
                                      child: Icon(Icons.image_not_supported,
                                          color: Colors.white54, size: 40),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe['name'],
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: Get.height * 0.015,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
