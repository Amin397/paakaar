import 'dart:io';

import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';

class ImagePreviewProfileDialog extends StatefulWidget {
  final String path;

  ImagePreviewProfileDialog({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  State<ImagePreviewProfileDialog> createState() => _ImagePreviewProfileDialogState();
}

class _ImagePreviewProfileDialogState extends State<ImagePreviewProfileDialog> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.05,
          height: Get.height / 1.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 12.0,
              spreadRadius: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.close(1),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: ColorUtils.black,
                        ),
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                            widget.path,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
