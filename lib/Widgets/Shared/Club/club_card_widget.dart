import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

class ClubCardWidget extends StatelessWidget {
  const ClubCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ColorUtils.black,
            ColorUtils.black,
          ],
        ),
      ),
      height: Get.height / 3,
      child: Column(
        children: [
          ViewUtils.sizedBox(
            18,
          ),
          AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 750),
            child: SlideAnimation(
              horizontalOffset: Get.width / 1.5,
              child: FadeInAnimation(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              Globals.userStream.user!.level!.image!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Get.height / 50),
                      child: Center(
                        child: AutoSizeText(
                          Globals.userStream.user?.cardNumber is String
                              ? Globals.userStream.user?.cardNumber
                              : '---- ---- ---- ----',
                          minFontSize: 2.0,
                          style: const TextStyle(
                            letterSpacing: 4,
                            fontSize: 19.0,
                            color: ColorUtils.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width / 4,
                      margin: EdgeInsets.only(top: Get.height / 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorUtils.black,
                      ),
                      child: Center(
                        child: AutoSizeText(
                          Globals.userStream.user!.fullName,
                          minFontSize: 2.0,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      height: 25,
                    ),
                    Row(
                      children: [
                        Container(
                          width: Get.width / 2.2,
                          margin: EdgeInsets.only(
                            top: Get.height / 4.8,
                            right: 4.0,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            color: ColorUtils.yellow,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  // SizedBox(width: size.width * .01,),
                                  Icon(
                                    Ionicons.wallet_outline,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  AutoSizeText(
                                    'نگاکوین: ',
                                    minFontSize: 2.0,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: Get.width / 6,
                                    ),
                                    child: AutoSizeText(
                                      ViewUtils.moneyFormat(
                                        Globals.userStream.user!.credit
                                            .toDouble(),
                                      ),
                                      minFontSize: 2.0,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3.0,
                                  ),
                                  const AutoSizeText(
                                    'تومان',
                                    minFontSize: 2.0,
                                    style: TextStyle(
                                      fontSize: 9.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                            ],
                          ),
                          height: Get.height / 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
