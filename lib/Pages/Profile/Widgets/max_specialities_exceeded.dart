import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class MaxSpecialitiesExceeded extends StatelessWidget {
  const MaxSpecialitiesExceeded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.2,
          height:Get.width > 300?Get.height * .4: Get.height / 3.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Get.back(
                        result: false,
                      ),
                      child: const Icon(
                        Ionicons.close_outline,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "لطفا توجه کنید!",
                style: TextStyle(
                  color: ColorUtils.mainRed,
                  fontSize: 15.0,
                ),
              ),
              ViewUtils.sizedBox(),
              Container(
                width: Get.width / 1.4,
                child: Center(
                  child: AutoSizeText(
                    "شما حداکثر تخصص های قابل انتخاب (۲ عدد) را انتخاب کرده اید٬ با تغییر این موارد تخصصص های فعلی حذف خواهند شد.",
                    maxLines: 3,
                    style: TextStyle(
                      color: ColorUtils.textColor,
                      height: 1.5,
                    ),
                    minFontSize: 1.0,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: Get.width / 1.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: WidgetUtils.button(
                        text: "انصراف",
                        outline: true,
                        onTap: () => Get.back(
                          result: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: WidgetUtils.button(
                        text: "متوجه شدم!",
                        onTap: () => Get.back(
                          result: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ViewUtils.sizedBox(75),
            ],
          ),
        ),
      ),
    );
  }
}
