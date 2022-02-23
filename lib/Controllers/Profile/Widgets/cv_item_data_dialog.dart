import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Plugins/FilePreview.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:flutter/material.dart';

import '../complete_profile_controller.dart';

class CvItemDataDialog extends StatelessWidget {
  final CustomFileModel file;
  final TextEditingController nameTextController = TextEditingController();
  final CompleteProfileController? controller;
  CvItemDataDialog({
    Key? key,
    required this.file,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.1,
          height: Get.height * .45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: ColorUtils.black,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Text(
                      "عنوان نمونه کار",
                      style: TextStyle(
                        color: ColorUtils.black,
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(),
                AnimatedContainer(
                  constraints: BoxConstraints(
                      maxHeight: Get.height * .1
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  duration: const Duration(milliseconds: 270),
                  child: TextField(
                    controller: nameTextController,
                    maxLines: 10,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintMaxLines: 1,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.orange.withOpacity(0.5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color:  Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color:Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                ),
                // WidgetUtils.textField(
                //   controller: nameTextController,
                //
                // ),
                ViewUtils.sizedBox(),
                Expanded(
                  child: FilePreview(
                    file: file,
                  ),
                ),
                ViewUtils.sizedBox(),
                WidgetUtils.button(
                  onTap: () {
                    file.name = nameTextController.text;
                    Get.back();
                    controller!.uploadFile(file: file);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
