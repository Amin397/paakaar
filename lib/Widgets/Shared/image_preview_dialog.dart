import 'dart:io';

import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';

class ImagePreviewDialog extends StatefulWidget {
  final CustomFileModel file;

  ImagePreviewDialog({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<ImagePreviewDialog> createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
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
                    Text(
                      widget.file.name,
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: (widget.file.file is File)
                        ? Image.file(
                            widget.file.file!,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.file.url!,
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
