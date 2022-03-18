import 'package:paakaar/Controllers/Profile/complete_profile_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ShowEditImageModal extends StatelessWidget {
  final CompleteProfileController? controller;
  ShowEditImageModal({this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: Get.height * .15,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.0),
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  controller!.showSourceAlert();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
                  height: double.maxFinite,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'ویرایش عکس',
                        maxFontSize: 18.0,
                        maxLines: 1,
                        minFontSize: 14.0,
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 16.0,
                        ),
                      ),
                      const Icon(
                        Icons.edit,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  bool canDelete = await GetConfirmationDialog.show(
                    text: "حذف عکس غیر قابل بازگشت می باشد",
                  );
                  if (canDelete) {
                    Globals.userStream.user!.avatarFile = '';
                    Globals.userStream.user!.avatar = null;
                    Globals.userStream.changeUser(
                      Globals.userStream.user!,
                    );
                  }
                  Get.close(1);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
                  height: double.maxFinite,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'حذف عکس',
                        maxFontSize: 18.0,
                        maxLines: 1,
                        minFontSize: 14.0,
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 16.0,
                        ),
                      ),
                      Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
