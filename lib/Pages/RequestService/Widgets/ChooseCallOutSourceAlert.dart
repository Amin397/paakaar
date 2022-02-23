import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseCallOutSourceAlert extends StatelessWidget {
  final controller;

  ChooseCallOutSourceAlert({this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: Get.width,
        height: Get.height * .16,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () => this.pickImage(
                  ImageSource.gallery,
                ),
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "گالری",
                        style: TextStyle(
                          color: ColorUtils.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Get.width * .05,
            ),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () => this.pickImage(
                  ImageSource.camera,
                ),
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "دوربین",
                        style: TextStyle(
                          color: ColorUtils.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 50,
    );
    if (image is XFile) {
      Get.back();
      controller!.setPicture(image: image);
      // Globals.userStream.user!.avatarFile = image;
      // Globals.userStream.changeUser(
      //   Globals.userStream.user!,
      // );
      // Get.close(2);
    }
  }
}
