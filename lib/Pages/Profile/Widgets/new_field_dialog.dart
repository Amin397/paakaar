import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class NewFieldDialog extends StatelessWidget {
  NewFieldDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.2,
          height: Get.height / 3.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
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
                  color: ColorUtils.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ViewUtils.sizedBox(),
              Container(
                width: Get.width / 1.4,
                child: Center(
                  child: AutoSizeText(
                    "شما فقط یک زمینه کاری و از هر زمینه کاری تا دو تخصص را میتوانید انتخاب کنید\n با انتخاب زمینه کاری جدید تخصص های قبلی حذف خواهند شد",
                    maxLines: 4,
                    style: TextStyle(
                      color: ColorUtils.textColor,
                      height: 1.5,
                      fontSize: 14.0,
                    ),
                    minFontSize: 1.0,
                  ),
                ),
              ),
              Spacer(),
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
                    SizedBox(
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
