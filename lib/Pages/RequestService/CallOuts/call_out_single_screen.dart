import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Services/CallOuts/CallOutSingleController.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class CallOutSingleScreen extends StatelessWidget {
  final CallOutSingleController controller = Get.put(
    CallOutSingleController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: controller.scaffoldKey,
        ),
        key: controller.scaffoldKey,
        drawer: CustomDrawerWidget(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ViewUtils.sizedBox(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'عنوان فراخوان',
                    style: TextStyle(
                      color: ColorUtils.myRed,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                ViewUtils.sizedBox(),
                Text(
                  controller.callOut.name,
                  style: const TextStyle(
                    color: ColorUtils.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ViewUtils.sizedBox(75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildField(
                      controller.callOut.field!,
                    ),
                    buildField(
                      controller.callOut.category!,
                    ),
                    buildField(
                      controller.callOut.speciality!,
                    ),
                  ],
                ),
                ViewUtils.sizedBox(75),
                buildBanner(),
                ViewUtils.sizedBox(),
                (controller.callOut.iAmAccepted)?
                buildUser():
                Row(
                  children: [
                    Text(
                      'فراخوان دهنده',
                      style: TextStyle(
                        color: ColorUtils.textColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: ColorUtils.mainRed,
                        ),
                      ),
                    ),
                    Text(
                      controller.callOut.individual?.fullName ?? '',
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(),
                Row(
                  children: [
                    Text(
                      'تخصص فراخوان',
                      style: TextStyle(
                        color: ColorUtils.textColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: ColorUtils.mainRed,
                        ),
                      ),
                    ),
                    Text(
                      controller.callOut.speciality?.name ?? '',
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(),
                Row(
                  children: [
                    Text(
                      'محل انجام کار',
                      style: TextStyle(
                        color: ColorUtils.textColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: ColorUtils.mainRed,
                        ),
                      ),
                    ),
                    Text(
                      controller.callOut.state.name +
                          ' - ' +
                          controller.callOut.city.name,
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(),
                Container(
                  width: Get.width,
                  height: Get.height * .05,
                  child: Row(
                    children: [
                      Text(
                        'محدوده جغرافیایی',
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: Get.width * .02,),
                      Expanded(
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              controller.callOut.district,
                              maxFontSize: 16.0,
                              maxLines: 2,
                              minFontSize: 12.0,
                              style: const TextStyle(
                                color: ColorUtils.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ViewUtils.sizedBox(),
                Row(
                  children: [
                    Text(
                      'زمان انجام کار تا',
                      style: TextStyle(
                        color: ColorUtils.textColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: ColorUtils.mainRed,
                        ),
                      ),
                    ),
                    Text(
                      controller.callOut.day,
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ViewUtils.sizedBox(),
                Row(
                  children: [
                    Text(
                      'توضیحات',
                      style: TextStyle(
                        color: ColorUtils.textColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: ColorUtils.mainRed,
                        ),
                      ),
                    ),
                    ViewUtils.sizedBox(),
                  ],
                ),
                Container(
                  width: Get.width,

                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 4.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    controller.callOut.desc,
                    style: TextStyle(
                      color: ColorUtils.textColor,
                    ),
                  ),
                ),
                ViewUtils.sizedBox(),
                // (controller.callOut.listOfPublicFilters!.isNotEmpty)?Row(
                //   children: [
                //     Text(
                //       'جزئیات',
                //       style: TextStyle(
                //         color: ColorUtils.textColor,
                //         fontSize: 14.0,
                //         fontWeight: FontWeight.normal,
                //       ),
                //     ),
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //         child: Divider(
                //           color: ColorUtils.mainRed,
                //         ),
                //       ),
                //     ),
                //     ViewUtils.sizedBox(),
                //   ],
                //
                // ):Container(),
                ...controller.callOut.listOfPublicFilters!.map(
                      (e) => Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(
                                  color: ColorUtils.textColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Divider(
                                    color: ColorUtils.mainRed,
                                  ),
                                ),
                              ),
                              Text(
                                e.values
                                    .singleWhere(
                                        (element) => element.isSelected.isTrue)
                                    .name,
                                style: const TextStyle(
                                  color: ColorUtils.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ViewUtils.sizedBox(),
                        ],
                      ),
                    ),
                ...controller.callOut.listOfOptions!.map(
                      (e) => Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(
                                  color: ColorUtils.textColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Divider(
                                    color: ColorUtils.mainRed,
                                  ),
                                ),
                              ),
                              Text(
                                e.values
                                    .singleWhere(
                                        (element) => element.isSelected.isTrue)
                                    .name,
                                style: const TextStyle(
                                  color: ColorUtils.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ViewUtils.sizedBox(),
                        ],
                      ),
                    ),
                ViewUtils.sizedBox(),
                DottedBorder(
                  padding: EdgeInsets.zero,
                  color: ColorUtils.mainRed,
                  child: Container(
                    height: 1.0,
                  ),
                ),
                ViewUtils.sizedBox(),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: ViewUtils.boxShadow(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "تعداد پیشنهاد ارسال شده: ",
                          style: TextStyle(
                            color: ColorUtils.textColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          controller.callOut.proposeCount.toString(),
                          style: TextStyle(
                            color: ColorUtils.mainRed,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ViewUtils.sizedBox(),
                // DottedBorder(
                //   padding: EdgeInsets.zero,
                //   color: ColorUtils.mainRed,
                //   child: Container(
                //     height: 1.0,
                //   ),
                // ),
                ViewUtils.sizedBox(),
                controller.seeProfile
                    ? Container()
                    : WidgetUtils.button(
                        text: controller.callOut.individual?.id !=
                                Globals.userStream.user?.id
                            ? controller.callOut.proposeCount < 5
                                ?  controller.callOut.isAccepted
                                        ?(controller.callOut.iAmAccepted)?"پیشنهاد ارسالی شما برای این فراخوان تایید شده است!": "این فراخوان به شخص دیگری واگذار شده است!"
                                        : controller.callOut.hasProposed
                                            ? "شما قبلا پیشنهاد خود را ارسال کرده اید!"
                                            : "پیشنهاد انجام کار"
                                : 'این فراخوان سقف پیشنهادات خود را دریافت کرده است'
                            : "این فراخوان توسط شما ثبت شده است!",
                        enabled: !controller.callOut.hasProposed &&
                            controller.callOut.proposeCount < 5 &&
                            controller.callOut.individual?.id !=
                                Globals.userStream.user?.id && !controller.callOut.isAccepted,
                        onTap: () {
                          Get.toNamed(
                            RoutingUtils.participateForCallOut.name,
                            arguments: {
                              'callOut': controller.callOut,
                            },
                          );
                        },
                      ),
                ViewUtils.sizedBox(25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ExpertSinglePageScreen(
              expert: controller.callOut.individual!,
              fromChat: false,
            ),
          );
        },
        child: Container(
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
                if (controller.callOut.individual!.avatar is String)
                  ClipRRect(
                    child: Image.network(
                      controller.callOut.individual!.avatar!,
                      width: Get.width / 8,
                      fit: BoxFit.fill,
                      height: Get.width / 8,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                if (controller.callOut.individual!.avatar == null)
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
                      controller.callOut.individual!.fullName,
                      style: const TextStyle(
                        color: ColorUtils.black,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      controller.callOut.individual!.specialities!.isNotEmpty
                          ? controller
                              .callOut
                              .individual!
                              .specialities!
                              .map((e) => e.name)
                              .join('٬ ')
                          : '',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: ColorUtils.textColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_right,
                  color: ColorUtils.green,
                  size: Get.width / 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(FieldModel last) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ViewUtils.boxShadow(),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              last.name,
              style: const TextStyle(
                color: ColorUtils.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBanner() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ViewUtils.boxShadow(
          blurRadius: 12.0,
          spreadRadius: 5.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          controller.callOut.cover,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildDateAndLastCat() {
    return Container(
      width: (Get.width / 1) - (ViewUtils.scaffoldPadding.horizontal * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildField(
            controller.callOut.speciality!,
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: ViewUtils.boxShadow(),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Ionicons.calendar_outline,
                    size: 18.0,
                    color: ColorUtils.textColor,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  controller.callOut.expireDate,
                  style: const TextStyle(
                    color: ColorUtils.black,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
