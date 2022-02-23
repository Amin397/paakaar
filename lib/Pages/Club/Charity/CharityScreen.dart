import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:paakaar/Models/Club/Services/CharityIconModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';

// ignore: must_be_immutable
class CharityScreen extends StatefulWidget {
  @override
  _CharityScreenState createState() => _CharityScreenState();
}

class _CharityScreenState extends State<CharityScreen> {
  List<CharityIconModel> listOfIcons = [
    CharityIconModel(
      name: "موسسه خیریه کهریزک",
    ),
    CharityIconModel(
      name: "سازمان جمعیت حلال احمر",
    ),
    CharityIconModel(
      name: "موسسه خیریه محک",
    ),
    CharityIconModel(
      name: "ستاد مردمی دیه",
    ),
    CharityIconModel(
      name: "انجمن حمایت از بیماران مبتلا به لوپوس",
    ),
    CharityIconModel(
      name: "انجمن حمایت از بیماران پروانه ای",
    ),
    CharityIconModel(
      name: "بنیاد نیکوکاری دست های مهربان",
    ),
    CharityIconModel(
      name: "موسسه خیریه مهرانه",
    ),
    CharityIconModel(
      name: "انجمن حامی",
    ),
    CharityIconModel(
      name: "کمیته امداد امام خمینی",
    ),
    CharityIconModel(
      name: "سازمان بهزیستی",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: FeatherIcons.heart,
        text: "نیکوکاری",
      ),
      body: AnimationLimiter(
        child: ListView.separated(
          separatorBuilder: this.buildSeparator,
          itemCount: this.listOfIcons.length,
          itemBuilder: this.itemBuilder,
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    CharityIconModel serviceIconModel = this.listOfIcons[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 375),
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            height: Get.height / 15,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                // onTap: () => serviceIconModel.function(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          serviceIconModel.icon,
                          color: ColorUtils.yellow,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          serviceIconModel.name,
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Divider(
        color: ColorUtils.yellow,
      ),
    );
  }
}
