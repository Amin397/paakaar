import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paakaar/Controllers/Club/Services/MainInsuranceController.dart';
import 'package:paakaar/Models/Club/Insruance/InsuranceModels.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';

class MainInsuranceScreen extends StatelessWidget {
  final MainInsuranceController mainInsuranceController = Get.put(
    MainInsuranceController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: FeatherIcons.userCheck,
        text: 'بیمه',
      ),
      body: this.buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: this.buildGridView(),
        ),
        ViewUtils.sizedBox(25),
      ],
    );
  }

  Widget buildGridView() {
    return AnimationLimiter(
      child: ListView.builder(
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 2,
        //   mainAxisSpacing: 10.0,
        //   crossAxisSpacing: 10.0,
        // ),
        itemCount: this.mainInsuranceController.listOfItems.length,
        itemBuilder: this.buildInsuranceType,
      ),
    );
  }

  Widget buildInsuranceType(BuildContext context, int index) {
    InsuranceClass insuranceClass =
        this.mainInsuranceController.listOfItems[index];
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          insuranceClass.data.name,
        );
      },
      child: AnimationConfiguration.staggeredList(
        position: index,
        duration: Duration(milliseconds: 500),
        child: SlideAnimation(
          horizontalOffset: 250.0,
          child: FadeInAnimation(
            child: Container(
              width: Get.width,
              height: Get.width / 5,
              margin: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/${insuranceClass.icon}.svg",
                      width: Get.width / 8,
                      height: Get.width / 8,
                      color: ColorUtils.yellow,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          insuranceClass.title,
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 15.0,
                          ),
                        ),
                        if (insuranceClass.hasFlag) ...[
                          ViewUtils.sizedBox(100),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: ColorUtils.orange.withOpacity(0.1),
                              border: Border.all(
                                color: ColorUtils.orange,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                insuranceClass.flag!,
                                style: TextStyle(
                                  color: ColorUtils.orange.shade900,
                                  fontSize: 9.0,
                                ),
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_right,
                      color: ColorUtils.yellow,
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorUtils.black.withOpacity(0.5),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
