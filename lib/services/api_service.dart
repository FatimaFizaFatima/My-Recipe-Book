import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecipeController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> breakfastRecipes = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> lunchRecipes = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> dinnerRecipes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchRecipes();
    super.onInit();
  }

  Future<Map<String, dynamic>?> fetchRecipeDetail(String id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null && data['meals'].length > 0) {
          return data['meals'][0];
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch recipe details");
    }
    return null;
  }

  Future<void> fetchRecipes() async {
    try {
      isLoading(true);

      final breakfastRes = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=Breakfast'));
      final lunchRes = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=Chicken'));
      final dinnerRes = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef'));

      if (breakfastRes.statusCode == 200) {
        breakfastRecipes.value = List<Map<String, dynamic>>.from(
            json.decode(breakfastRes.body)['meals']);
      }

      if (lunchRes.statusCode == 200) {
        lunchRecipes.value = List<Map<String, dynamic>>.from(
            json.decode(lunchRes.body)['meals']);
      }

      if (dinnerRes.statusCode == 200) {
        dinnerRecipes.value = List<Map<String, dynamic>>.from(
            json.decode(dinnerRes.body)['meals']);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load recipes");
    } finally {
      isLoading(false);
    }
  }
}
