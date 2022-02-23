import 'dart:io';

import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChooseSourceAlert extends StatelessWidget {
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
                onTap: () => pickImage(
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
                    children: const [
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
                onTap: () => pickImage(
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
    XFile? image = await _picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 50,
    );
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'تنظیمات ابعاد عکس',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    if (croppedFile is File) {
      image = XFile(
        croppedFile.path,
      );
    }
    if (image is XFile) {
      // Globals.userStream.changeUser(
      //   Globals.userStream.user!,
      // );
      Globals.userStream.changeProfileImage(
        image: image,
      );
      Get.close(2);
    }
  }
}
