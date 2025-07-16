import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Map recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final box = GetStorage();
  late List recipes;
  late int recipeIndex;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    recipes = box.read<List>('recipes') ?? [];
    recipeIndex = recipes.indexWhere((r) => r['name'] == widget.recipe['name']);
    isFavorite =
        recipeIndex != -1 ? recipes[recipeIndex]['isFavorite'] ?? false : false;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (recipeIndex != -1) {
        recipes[recipeIndex]['isFavorite'] = isFavorite;
        box.write('recipes', recipes);
      }
    });

    Get.snackbar(
      isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
      widget.recipe['name'],
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.recipe['name'] ?? 'Unnamed';
    final String description =
        widget.recipe['description'] ?? 'No description available';
    final String? imagePath = widget.recipe['imagePath'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: Get.height * 0.02,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 67, 67),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : Colors.white,
            ),
            onPressed: toggleFavorite,
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.95),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.03, vertical: Get.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: imagePath != null && File(imagePath).existsSync()
                      ? FadeInImage(
                          placeholder:
                              AssetImage('assets/images/placeholder.jpg'),
                          image: FileImage(File(imagePath)),
                          height: Get.height * 0.4,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : Container(
                          height: Get.height * 0.3,
                          width: double.infinity,
                          color: Colors.white10,
                          child: Icon(Icons.image_not_supported,
                              size: 80, color: Colors.white30),
                        ),
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: Get.height * 0.025,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * 0.025),
                Container(
                  padding: EdgeInsets.all(Get.height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: Get.height * 0.018,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
