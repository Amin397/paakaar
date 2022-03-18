import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

import 'Controller/ad_add_controller.dart';

class AdAddScreen extends StatelessWidget {
  AdAddScreen({Key? key}) : super(key: key);
  final AdAddController controller = Get.put(AdAddController());

  @override
  Widget build(BuildContext context) {
    double factor = 1920 / (Get.width - 48);
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
                ViewUtils.sizedBox(25),
                Obx(
                  () => controller.isFieldsLoaded.isTrue
                      ? WidgetUtils.selectOptions(
                          controller: controller,
                          title: "انتخاب زمینه کاری",
                          items: controller.listOfFields,
                          isActive: (elem) => elem.isSelected.value,
                          displayFormat: displayField,
                          makeActive: controller.makeFieldActive,
                        )
                      : WidgetUtils.loadingWidget(),
                ),
                ViewUtils.sizedBox(25),
                Obx(
                  () => controller.isStatesLoaded.isTrue
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: WidgetUtils.selectOptions(
                                title: "انتخاب استان",
                                controller: controller,
                                items: controller.listOfStates,
                                isActive: (elem) => elem.isSelected,
                                displayFormat: displayStates,
                                makeActive: controller.makeStateActive,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: GetBuilder(
                                init: controller,
                                builder: (ctx) => WidgetUtils.selectOptions(
                                  title: "انتخاب شهر",
                                  controller: controller,
                                  enabled: controller.listOfStates
                                      .any((element) => element.isSelected),
                                  errorMessage:
                                      "لطفا ابتدا استان را انتخاب کنید",
                                  items: controller.listOfStates
                                          .any((element) => element.isSelected)
                                      ? controller.listOfStates
                                          .singleWhere(
                                              (element) => element.isSelected)
                                          .listOfCities
                                      : [],
                                  isActive: (elem) => elem.isSelected,
                                  displayFormat: displayCity,
                                  makeActive: controller.makeCityActive,
                                ),
                              ),
                            ),
                          ],
                        )
                      : WidgetUtils.loadingWidget(),
                ),
                ViewUtils.sizedBox(25),
                Row(
                  children: const [
                    Text(
                      'عنوان آگهی',
                    ),
                  ],
                ),
                ViewUtils.sizedBox(75),
                AnimatedContainer(
                  constraints: BoxConstraints(
                      maxHeight: Get.height * .1
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  duration: const Duration(milliseconds: 270),
                  child: TextField(
                    controller: controller.titleTextController,
                    maxLines: 10,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
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
                // WidgetUtils.textField(
                //   controller: controller.titleTextController,
                // ),
                // ViewUtils.sizedBox(),
                // Row(
                //   children: [
                //     Text(
                //       'لینک آگهی',
                //     ),
                //   ],
                // ),
                // ViewUtils.sizedBox(75),
                // Container(
                //   height: Get.height / 22,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: WidgetUtils.textField(
                //           controller: controller.linkTextController,
                //           keyboardType: TextInputType.url,
                //         ),
                //       ),
                //       Flexible(
                //         flex: 2,
                //         child: Center(
                //           child: Text(
                //             "//:",
                //           ),
                //         ),
                //       ),
                //       Flexible(
                //         flex: 3,
                //         child: Container(
                //           child: Center(
                //             child: Text(
                //               "https",
                //             ),
                //           ),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10.0),
                //             color: ColorUtils.textFieldBackground,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ViewUtils.sizedBox(25),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تصویر کاور',
                  ),
                ),
                ViewUtils.sizedBox(75),
                GetBuilder(
                  init: controller,
                  builder: (_) => DottedBorder(

                    dashPattern: const [10, 10],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10.0),
                    strokeCap: StrokeCap.round,
                    color: (controller.fileImage is XFile)
                        ? Colors.transparent
                        : ColorUtils.textColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                        onTap: () {
                          controller.unFocus();
                          controller.showModalBottomSheet();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: (controller.fileImage is XFile)
                                ? SizedBox(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.file(
                                        File(controller.fileImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : AutoSizeText(
                                    'افزودن عکس برای آگهی\n\n (اختیاری)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorUtils.textColor,
                                    ),
                                  ),
                          ),
                          height: 1080 / factor,
                          width: 1920 / factor,
                        ),
                      ),
                    ),
                  ),
                ),
                ViewUtils.sizedBox(25),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'توضیحات',
                  ),
                ),
                ViewUtils.sizedBox(75),
                TextField(
                  maxLines: 5,
                  controller: controller.descTextController,
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
                ViewUtils.sizedBox(),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'قیمت',
                  ),
                ),
                ViewUtils.sizedBox(75),
                SizedBox(
                  height: Get.height / 22,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 36,
                        child: WidgetUtils.textField(
                          controller: controller.priceTextController,
                          price: true,
                        ),
                      ),
                      Flexible(
                        child: Container(),
                        flex: 1,
                      ),
                      Flexible(
                        flex: 12,
                        child: Container(
                          child: const Center(
                            child: Text(
                              "تومان",
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: ColorUtils.textFieldBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ViewUtils.sizedBox(25),

                InkWell(
                  onTap: () {
                    controller.unFocus();
                    controller.saveAd();
                  },
                  child: Container(
                    height: Get.height * .05,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorUtils.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Center(
                      child: Text("ثبت آگهی" , style: TextStyle(
                        color: Colors.white,

                      ),),
                    ),
                  ),
                ),
                // WidgetUtils.button(
                //   outline: ,
                //   text: ,
                //
                // ),
                ViewUtils.sizedBox(12.5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String displayField(p1) {
    return p1.name;
  }

  String displayStates(p1) {
    return p1.name;
  }

  String displayCity(p1) {
    return p1.name;
  }
}
