import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Services/CallOuts/add_call_out_controller.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Plugins/datePicker/persian_datetime_picker.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class AddCallOutScreen extends StatelessWidget {
  AddCallOutScreen({Key? key}) : super(key: key);
  final AddCallOutController controller = Get.put(
    AddCallOutController(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.pageController.previousPage(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeIn,
        );
        return controller.pageController.page?.toInt() == 0;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () => controller.pageController.previousPage(
          //         duration: Duration(milliseconds: 120),
          //         curve: Curves.easeIn,
          //       ),
          // ),
          appBar: WidgetUtils.appBar(
            innerPage: true,
            key: controller.scaffoldKey,
          ),
          key: controller.scaffoldKey,
          drawer: CustomDrawerWidget(),
          body: Padding(
            padding: ViewUtils.scaffoldPadding,
            child: buildBody(),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        ViewUtils.sizedBox(25),
        buildLastFields(),
        ViewUtils.sizedBox(75),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Divider(
              thickness: 5,
              color: ColorUtils.mainRed.withOpacity(0.2),
            ),
            GetBuilder(
              init: controller,
              builder: (_) => AnimatedContainer(
                duration: Duration(milliseconds: 150),
                height: 5.0,
                width: Get.width / getPage(),
                decoration: BoxDecoration(
                  color: ColorUtils.mainRed,
                ),
              ),
            ),
          ],
        ),
        ViewUtils.sizedBox(75),
        Expanded(
          child: PageView.builder(
            onPageChanged: (int int) {
              controller.refresh();
            },
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            itemBuilder: buildPage,
            itemCount: 3,
          ),
        ),
        KeyboardVisibilityBuilder(
          builder: (_, bool isOpen) {
            if (!isOpen) {
              return GetBuilder(
                init: controller,
                builder: (_) => Row(
                  children: [
                    Flexible(
                      child: WidgetUtils.button(
                          enabled:
                              (controller.pageController.page?.toInt() ?? 0) >=
                                  0,
                          text: "مرحله قبل",
                          onTap: () {
                            if ((controller.pageController.page?.toInt() ??
                                    0) ==
                                0) {
                              controller.goBack();
                              controller.listOfOptions
                                  .removeWhere((element) => !element.isPublic);
                              controller.refresh();
                              // controller.getSubGroups(
                              //   delay: 0,
                              // );
                            } else {
                              controller.pageController.previousPage(
                                duration: const Duration(milliseconds: 120),
                                curve: Curves.easeIn,
                              );
                            }
                          }),
                      flex: 1,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: WidgetUtils.neuButton(
                        enabled: true,
                        text: (controller.pageController.page?.toInt() ?? 0) < 2
                            ? "مرحله بعد"
                            : "ثبت فراخوان",
                        onTap: () => controller.saveCallOut(),
                      ),
                      flex: 3,
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        ViewUtils.sizedBox(25),
      ],
    );
  }

  String displayStates(p1) {
    return p1.name;
  }

  String displayCity(p1) {
    return p1.name;
  }

  Widget buildLastFields() {
    return Container(
      height: Get.height / 24,
      child: GetBuilder(
        init: controller,
        builder: (context) {
          return AnimationLimiter(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: buildLastField,
              itemCount: controller.listOfGroups.length,
            ),
          );
        },
      ),
    );
  }

  Widget buildLastField(BuildContext context, int index) {
    FieldModel field = controller.listOfGroups[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        horizontalOffset: 150.0,
        child: FadeInAnimation(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  controller.goBack();
                  controller.listOfOptions
                      .removeWhere((element) => !element.isPublic);
                  controller.refresh();
                  // controller.getSubGroups(
                  //   delay: 0,
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Ionicons.close,
                      color: ColorUtils.mainRed,
                    ),
                    Text(
                      field.name,
                      style: TextStyle(
                        color: ColorUtils.textColor,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: ViewUtils.boxShadow(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFilters() {
    return SizedBox(
      height: Get.height / 1.9,
      child: Obx(
        () => controller.isOptionsLoaded.isTrue
            ? GetBuilder(
                init: controller,
                builder: (context) {
                  return AnimationLimiter(
                    child: ListView.builder(
                      itemCount: controller.listOfOptions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: buildOptionItem(
                                controller.listOfOptions[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildOptionItem(OptionModel option) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => controller.getOptionValues(option),
          onLongPress: () {
            option.values.forEach((element) {
              element.isSelected.value = false;
            });
            controller.update();
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: option.isSelected
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          for (var element in option.values) {
                            element.isSelected.value = false;
                          }
                          controller.update();
                        },
                        child: Icon(
                          Icons.close,
                          color: ColorUtils.mainRed,
                        ),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        option.name + ": ",
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        option.values
                            .singleWhere((element) => element.isSelected.isTrue)
                            .name,
                        style: const TextStyle(
                          color: ColorUtils.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        option.name,
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 14.0,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: ColorUtils.green,
                      ),
                    ],
                  ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ViewUtils.boxShadow(),
      ),
    );
  }

  Widget buildFirstPage() {
    return Column(
      children: [
        const Text(
          "انتخاب گزینه های مورد نظر",
          style: TextStyle(
            color: ColorUtils.black,
            fontSize: 18.0,
          ),
        ),
        ViewUtils.sizedBox(),
        buildFilters(),
      ],
    );
  }

  Widget buildSecondPage() {

    double factor = 1920 / (Get.width - 48);

    return Column(
      children: [
        const Text(
          "اطلاعات اصلی فراخوان",
          style: TextStyle(
            color: ColorUtils.black,
            fontSize: 18.0,
          ),
        ),
        ViewUtils.sizedBox(25),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'عنوان فراخوان',
          ),
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
            maxLength: 30,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintMaxLines: 1,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.orange.withOpacity(0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color:  Colors.grey.withOpacity(0.2),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color:Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ),
        ViewUtils.sizedBox(),
        Row(
          children: [
            const Text(
              'شماره تماس: ',
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: WidgetUtils.textField(
                keyboardType: TextInputType.phone,
                controller: controller.phoneTextController,
                formatter: [
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
            ),
          ],
        ),
        // ViewUtils.sizedBox(),
        // Row(
        //   children: [
        //     Text(
        //       'لینک فراخوان: ',
        //     ),
        //     SizedBox(
        //       width: 8.0,
        //     ),
        //     Expanded(
        //       child: Container(
        //         height: Get.height / 22,
        //         child: Row(
        //           children: [
        //             Flexible(
        //               flex: 12,
        //               child: GetBuilder(
        //                 builder: (_) => WidgetUtils.textField(
        //                   onChanged: (String str) {
        //                     controller.refresh();
        //                   },
        //                   controller: controller.linkTextController,
        //                   keyboardType: TextInputType.url,
        //                   valid: Uri.parse("https://" +
        //                               controller.linkTextController.text)
        //                           .host
        //                           .contains('.') &&
        //                       '.'
        //                               .allMatches(Uri.parse("https://" +
        //                                       controller
        //                                           .linkTextController.text)
        //                                   .host)
        //                               .length ==
        //                           1,
        //                 ),
        //                 init: controller,
        //               ),
        //             ),
        //             Flexible(
        //               flex: 2,
        //               child: Center(
        //                 child: Text(
        //                   "//:",
        //                 ),
        //               ),
        //             ),
        //             Flexible(
        //               flex: 3,
        //               child: Container(
        //                 child: Center(
        //                   child: Text(
        //                     "https",
        //                   ),
        //                 ),
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10.0),
        //                   color: ColorUtils.textFieldBackground,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        ViewUtils.sizedBox(25),
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
                            'افزودن عکس برای ثبت فراخوان \n\n (اختیاری)',
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
      ],
    );
  }

  Widget buildPage(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = buildFirstPage();
        break;
      case 1:
        page = buildSecondPage();
        break;
      default:
        page = buildThirdPage(context: context);
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: page,
      ),
    );
  }

  num getPage() {
    if (controller.pageController.hasClients) {
      switch (controller.pageController.page?.toInt() ?? 0) {
        case 0:
          return 3;
        case 1:
          return 2;
        default:
          return 1;
      }
    }
    return 4;
  }

  Widget buildThirdPage({required BuildContext context}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "زمان انجام کار",
            style: TextStyle(
              color: ColorUtils.black,
              fontSize: 18.0,
            ),
          ),
          ViewUtils.sizedBox(),
          GetBuilder(
            init: controller,
            builder: (_) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildDay(
                        title: "امروز",
                        id: 0,
                        context: context,
                      ),
                      buildDay(
                        context: context,
                        title: "فردا",
                        id: 1,
                      ),
                    ],
                  ),
                  ViewUtils.sizedBox(75),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildDay(
                        context: context,
                        title: "پس فردا",
                        id: 2,
                      ),
                      buildDay(
                        context: context,
                        title: controller.dayId == 3
                            ? controller.selectedDay
                            : "انتخاب روز",
                        id: 3,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          ViewUtils.sizedBox(25),
          const Text(
            "محدوده انجام کار",
            style: TextStyle(
              color: ColorUtils.black,
              fontSize: 18.0,
            ),
          ),
          ViewUtils.sizedBox(),
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
                            title: "همه ی شهر ها",
                            controller: controller,
                            enabled: controller.listOfStates
                                .any((element) => element.isSelected),
                            errorMessage: "لطفا ابتدا استان را انتخاب کنید",
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
          ViewUtils.sizedBox(),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'محدوده',
            ),
          ),
          ViewUtils.sizedBox(75),
          WidgetUtils.textField(
            controller: controller.districtTextController,
          ),
          ViewUtils.sizedBox(),
          DottedBorder(
            padding: EdgeInsets.zero,
            color: ColorUtils.mainRed,
            child: Container(
              height: 1.0,
            ),
          ),
          ViewUtils.sizedBox(50),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'توضیحات',
            ),
          ),
          ViewUtils.sizedBox(75),
          TextField(
            controller: controller.descTextController,
            maxLines: 5,
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
        ],
      ),
    );
  }

  Widget buildDay({
    required int id,
    required String title,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () async {
        if (id == 3) {
          Jalali? picked = await showPersianDatePicker(
            errorFormatText: 'اعداد را به زبان لاتین وارد کنید',
            initialDate: Jalali(
              int.parse(
                controller.selectedDay.split('/').first,
              ),
              int.parse(
                controller.selectedDay.split('/')[1],
              ),
              int.parse(
                controller.selectedDay.split('/')[2],
              ),
            ),

            firstDate: Jalali.now(),
            lastDate: Jalali.now().add(years: 1),
            context: context,
          );
          if (picked != null) {
            controller.selectedDay = picked.jDate();
            controller.dayId = id;
            controller.update();
          }
        } else {
          controller.dayId = id;
          controller.update();
        }
      },
      child: AnimatedContainer(
        width: Get.width / 3,
        height: Get.height / 25,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: id == controller.dayId ? ColorUtils.mainRed : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: ColorUtils.mainRed,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: Center(
            child: AutoSizeText(
              title,
              style: TextStyle(
                color: id == controller.dayId ? Colors.white : ColorUtils.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
