import 'package:auto_size_text/auto_size_text.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';

class RateUserDialog extends StatelessWidget {
  final UserModel user;
  final TextEditingController commentController = TextEditingController();
  double rating = 3.0;

  RateUserDialog({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: LayoutBuilder(
        builder: (BuildContext context , BoxConstraints constraints){
          if(constraints.maxWidth > 300.0){
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: Get.width / 1.1,
                  height: Get.height / 1.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildBody(),
                  ),
                ),
              ),
            );
          }else{
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: Get.width * .9,
                  height: Get.height * .6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildBody(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildUser(),
        ),
        ViewUtils.sizedBox(),
        buildRatingBar(),
        // ViewUtils.sizedBox(),
        Row(
          children: const [
            Text(
              'توضیحات',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        ViewUtils.sizedBox(80),
        Expanded(
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: TextField(
                      controller: commentController,
                      maxLines: 20,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: ColorUtils.black.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: ColorUtils.orange,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                ViewUtils.sizedBox(80),
                WidgetUtils.button(
                  text: "ثبت بازخورد",
                  onTap: () {
                    Get.back(
                      result: {
                        'rate': rating,
                        'comment': commentController.text,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildUser() {
    return LayoutBuilder(
      builder: (BuildContext context , BoxConstraints constraints){
        if(Get.width > 300.0){
          return Container(
            height: Get.height / 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: ViewUtils.boxShadow(),
            ),
            width: Get.width / 1,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (user.avatar is String)
                    ClipRRect(
                      child: Image.network(
                        user.avatar!,
                        width: Get.width / 8,
                        fit: BoxFit.fill,
                        height: Get.width / 8,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  if (user.avatar == null)
                    Icon(
                      Ionicons.person_outline,
                      size: Get.width / 8,
                      color: ColorUtils.mainRed,
                    ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          color: ColorUtils.black,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        user.specialities!.isNotEmpty
                            ? user.specialities!.map((e) => e.name).join('٬ ')
                            : '',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: ColorUtils.textColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Icon(
                  //   Icons.arrow_right,
                  //   color: ColorUtils.green,
                  //   size: Get.width / 12,
                  // ),
                ],
              ),
            ),
          );
        }else{
          return Container(
            height: Get.height * .1,
            // width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: ViewUtils.boxShadow(),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  if (user.avatar is String)
                    ClipRRect(
                      child: Image.network(
                        user.avatar!,
                        width: Get.width / 8,
                        fit: BoxFit.fill,
                        height: Get.width / 8,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  if (user.avatar == null)
                    Icon(
                      Ionicons.person_outline,
                      size: Get.width / 8,
                      color: ColorUtils.mainRed,
                    ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // width: double.maxFinite,
                        child: AutoSizeText(
                          user.fullName,
                          maxLines: 1,
                          maxFontSize: 18.0,
                          minFontSize: 14.0,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        child: AutoSizeText(
                          user.specialities!.isNotEmpty
                              ? user.specialities!.map((e) => e.name).join('٬ ')
                              : '',
                          maxFontSize: 12.0,
                          minFontSize: 8.0,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: ColorUtils.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Icon(
                  //   Icons.arrow_right,
                  //   color: ColorUtils.green,
                  //   size: Get.width / 12,
                  // ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildRatingBar() {
    return LayoutBuilder(
      builder: (BuildContext context , BoxConstraints constraints){
        if(constraints.maxWidth > 480.0){
          return RatingBar.builder(
            initialRating: 0.0,
            minRating: 1,
            direction: Axis.horizontal,
            textDirection: TextDirection.ltr,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            glowColor: Colors.white,
            unratedColor: ColorUtils.textColor.withOpacity(0.2),
            itemBuilder: (context, _) => const Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating1) {
              print(rating1);
              rating = rating1;
            },
          );
        }else{
          return RatingBar.builder(
            initialRating: 0.0,
            minRating: 1,
            direction: Axis.horizontal,
            textDirection: TextDirection.ltr,
            allowHalfRating: true,
            itemSize: 20.0,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            glowColor: Colors.white,
            unratedColor: ColorUtils.textColor.withOpacity(0.2),
            itemBuilder: (context, _) => const Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating1) {
              rating = rating1;
            },
          );
        }
      },
    );
  }
}
