import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Profile/complete_profile_controller.dart';
import 'package:paakaar/Models/Auth/social_media_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class SetAddressForSocialMedia extends StatelessWidget {
  final CompleteProfileController controller;
  final SocialMediaModel socialMedia;
  SetAddressForSocialMedia({
    Key? key,
    required this.controller,
    required this.socialMedia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.1,
          height: Get.height / 4,
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
                      child: Icon(
                        Ionicons.close,
                        color: ColorUtils.mainRed,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "معرفی آدرس ${this.socialMedia.name}",
                      style: TextStyle(
                        color: ColorUtils.black,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: ColorUtils.mainRed,
                          thickness: 0.1,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        socialMedia.icon,
                        width: Get.width / 16,
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(18),
                WidgetUtils.textField(
                  title: "آدرس شبکه اجتماعی",
                  controller: this.controller.addressTextController,
                ),
                const Spacer(),
                WidgetUtils.neuButton(
                  text: "ثبت",
                  enabled: true,
                  onTap: () => controller.saveSocialMediaAddress(
                        controller.addressTextController.text,
                        socialMedia,
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
