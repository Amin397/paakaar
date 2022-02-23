import 'dart:ui';

import 'package:paakaar/Controllers/Club/SinglePageController.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Widgets/customClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SinglePageScreen extends StatelessWidget {
  final SinglePageController singlePageController = Get.put(
    SinglePageController(),
  );

  final Widget iconSetForAppBar;
  final Widget body;
  final Stream<bool>? shapeStream;
  final bool showShape;
  final Color? backgroundColor;
  final Widget? fab;
  SinglePageScreen({
    Key? key,
    required this.iconSetForAppBar,
    required this.body,
    this.shapeStream,
    this.showShape = true,
    this.fab,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: this.backgroundColor ?? Colors.white,
          ),
          if (showShape)
            Container(
              height: Get.height / 6,
              child: AnimationConfiguration.synchronized(
                duration: Duration(milliseconds: 350),
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: SecondAnimatedThing(
                      stream: this.shapeStream,
                    ),
                  ),
                ),
              ),
            ),
          // Positioned(
          //   top: Get.height / 5,
          //   left: -Get.width / 1.2,
          //   child: Transform.rotate(
          //     angle: 3,
          //     child: BezierContainer(),
          //   ),
          // ),
          Scaffold(
            floatingActionButton: this.fab,
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: Get.height / 7,
                      color: ColorUtils.black,
                    ),
                    AnimationConfiguration.synchronized(
                      duration: Duration(milliseconds: 375),
                      child: SlideAnimation(
                        horizontalOffset: -Get.width / 2,
                        child: FadeInAnimation(
                          child: this.iconSetForAppBar,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.width / 6,
                ),
                Expanded(
                  child: Padding(
                    padding: ViewUtils.scaffoldPadding,
                    child: this.body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
