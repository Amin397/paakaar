import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/Scores/Controller/my_score_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class ScoreModalView extends StatelessWidget {
  ScoreModalView({Key? key, this.myScoreController}) : super(key: key);
  MyScoreController? myScoreController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: Get.width,
        height: Get.height * .5,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Ionicons.close,
                    size: 20.0,
                  ),
                ),
                const Text(
                  'طرح های امتیازی',
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.close,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            ViewUtils.sizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'مجموع امتیازات شما : ',
                  style: TextStyle(
                    color: ColorUtils.textColor,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  Globals.userStream.user!.score.toString() + ' امتیاز',
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Center(
                  child: AutoSizeText(
                    'در حال حاضر طرحی وجود ندارد',
                    style: TextStyle(
                      color: ColorUtils.textColor,
                      fontSize: 12.0,
                    ),
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
