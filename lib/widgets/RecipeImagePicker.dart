import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecipeImagePicker extends StatelessWidget {
  final String title;
  final IconData icon;
  final Rx<File?> selectedImage;

  RecipeImagePicker({
    required this.title,
    required this.icon,
    required this.selectedImage,
  });

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sen',
              fontSize: Get.height * 0.02,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          Obx(() => selectedImage.value == null
              ? Container(
                  height: Get.height * 0.2,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white10,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: Get.height * 0.08,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    selectedImage.value!,
                    height: Get.height * 0.2,
                    width: Get.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                )),
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.camera),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
                label: Text(
                  "Camera",
                  style: TextStyle(
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w400,
                      fontSize: Get.height * 0.015,
                      color: Colors.black),
                ),
              ),
              SizedBox(width: Get.width * 0.05),
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.gallery),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.black,
                ),
                label: Text(
                  "Gallery",
                  style: TextStyle(
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w400,
                      fontSize: Get.height * 0.015,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
