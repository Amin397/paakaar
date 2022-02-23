import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paakaar/Controllers/login_register_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class LoginRegisterScreen extends StatelessWidget {
  LoginRegisterScreen({Key? key}) : super(key: key);
  final LoginRegisterController controller = Get.put(
    LoginRegisterController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorUtils.mainRed,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints raints) {
            if (raints.maxWidth > 480.0) {
              return Center(
                child: Padding(
                  padding: ViewUtils.scaffoldPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height / 6,
                        ),
                        SizedBox(
                          width: Get.width * .4,
                          height: Get.width * .4,
                          child: const Image(
                            image: AssetImage(
                              ImageUtils.logo,
                            ),
                          ),
                        ),
                        const Text(
                          "ورود / ثبت نام",
                          style: TextStyle(
                            fontSize: 21.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: Get.height / 18,
                        ),
                        SizedBox(
                          height: Get.height / 12,
                        ),
                        mobileInput(),
                        SizedBox(
                          height: Get.height / 48,
                        ),
                        Obx(() {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 150),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return SizeTransition(
                                sizeFactor: animation,
                                child: child,
                              );
                            },
                            child: controller.isLogin.value == true
                                ? Center(
                                    child: Column(
                                      children: [
                                        passwordInput(),
                                        SizedBox(
                                          height: controller.size.height / 96,
                                        ),
                                        SizedBox(
                                          width: controller.size.width * .8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              AnimatedSwitcher(
                                                duration:
                                                    const Duration(seconds: 1),
                                                child: controller
                                                        .getFingerprint.isTrue
                                                    ? GestureDetector(
                                                        child: const Text(
                                                          "ورود با اثر انگشت",
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            color:
                                                                Colors.blue,
                                                          ),
                                                        ),
                                                        onTap: () => controller
                                                            .fingerprint(),
                                                      )
                                                    : Container(),
                                              ),
                                              GestureDetector(
                                                child: const Text(
                                                  "رمز عبور خود را فرموش کرده ام",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                onTap: () => controller
                                                    .forgotPassword(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: controller.size.height / 48,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          );
                        }),
                        Obx(
                          () => AnimatedSwitcher(
                            duration: const Duration(milliseconds: 150),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return SizeTransition(
                                sizeFactor: animation,
                                child: child,
                              );
                            },
                            child: controller.isRegister.value == true ||
                                    controller.isForgot.value == true
                                ? Center(
                                    child: Column(
                                      children: [
                                        codeInput(),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        Obx(
                          () => controller.isRegister.value
                              ? GetBuilder(
                                  init: controller,
                                  builder: (context) => Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Checkbox(
                                        activeColor: ColorUtils.green,
                                        value: controller.acceptTerms,
                                        onChanged: controller.onTermsChanged,
                                      ),
                                      Text(
                                        "قوانین و مقررات",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: ColorUtils.blue,
                                        ),
                                      ),
                                      const Text(
                                        " تیتراژ را میپذیرم!",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                        ViewUtils.sizedBox(),
                        Obx(
                          () => button(),
                        ),
                        SizedBox(
                          height: Get.height / 4,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: Padding(
                    padding: ViewUtils.scaffoldPadding,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * .05,
                          ),

                          Container(
                            width: Get.width * .4,
                            height: Get.width * .4,
                            child: const Image(
                              image: AssetImage(
                                ImageUtils.logo,
                              ),
                            ),
                          ),
                          // Image.asset(
                          //
                          //   width: Get.width * .4,
                          //   height: Get.width * .4,
                          //   color: ColorUtils.mainRed,
                          // ),
                          SizedBox(
                            height: Get.height * .06,
                          ),
                          const Text(
                            "ورود / ثبت نام",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * .02,
                          ),
                          mobileInput(),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          Obx(() {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return SizeTransition(
                                  sizeFactor: animation,
                                  child: child,
                                );
                              },
                              child: controller.isLogin.value == true
                                  ? Center(
                                      child: Column(
                                        children: [
                                          passwordInput(),
                                          SizedBox(
                                            height: Get.height * .06,
                                          ),
                                          Container(
                                            width: controller.size.width * .8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AnimatedSwitcher(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  child: controller
                                                          .getFingerprint.isTrue
                                                      ? GestureDetector(
                                                          child: const Text(
                                                            "ورود با اثر انگشت",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          onTap: () => controller
                                                              .fingerprint(),
                                                        )
                                                      : Container(),
                                                ),
                                                GestureDetector(
                                                  child: const Text(
                                                    "رمز عبور خود را فرموش کرده ام",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  onTap: () => controller
                                                      .forgotPassword(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * .03,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            );
                          }),
                          Obx(
                            () => AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return SizeTransition(
                                  sizeFactor: animation,
                                  child: child,
                                );
                              },
                              child: controller.isRegister.value == true ||
                                      controller.isForgot.value == true
                                  ? Center(
                                      child: Column(
                                        children: [
                                          codeInput(),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ),
                          ),
                          Obx(
                            () => controller.isRegister.value
                                ? GetBuilder(
                                    init: controller,
                                    builder: (context) => Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Checkbox(
                                          activeColor: ColorUtils.green,
                                          value: controller.acceptTerms,
                                          onChanged: controller.onTermsChanged,
                                        ),
                                        Text(
                                          "قوانین و مقررات",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: ColorUtils.blue,
                                          ),
                                        ),
                                        Text(
                                          " تیتراژ را میپذیرم!",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ),
                          ViewUtils.sizedBox(),
                          Obx(
                            () => button(),
                          ),
                          SizedBox(
                            height: Get.height / 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget mobileInput() {
    return Obx(
      () => controller.isLogin.value == true ||
              controller.isRegister.value == true ||
              controller.isForgot.value == true
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints raints) {
              if (raints.maxWidth > 480.0) {
                return GestureDetector(
                  onTap: () {
                    controller.isLogin.value = false;
                    controller.isRegister.value = false;
                    controller.isForgot.value = false;
                    controller.passwordController.clear();
                    controller.codeController.clear();
                    controller.mobileFocusNode.requestFocus();
                  },
                  child: Container(
                    height: Get.height / 21,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorUtils.black.withOpacity(0.2),
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorUtils.mainRed.withOpacity(0.7),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.edit,
                              size: 17.0,
                              color: ColorUtils.mainRed.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Text(
                          controller.mobileController.value.text,
                          style: TextStyle(
                            color: ColorUtils.black,
                            letterSpacing: 1.9,
                            fontSize: 15.0,
                          ),
                        ),
                        Container(
                          width: Get.width * .08,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    controller.isLogin.value = false;
                    controller.isRegister.value = false;
                    controller.isForgot.value = false;
                    controller.passwordController.clear();
                    controller.codeController.clear();
                    controller.mobileFocusNode.requestFocus();
                  },
                  child: Container(
                    height: Get.height / 21,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorUtils.black.withOpacity(0.2),
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 17.0,
                            color: ColorUtils.mainRed.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          controller.mobileController.value.text,
                          style: TextStyle(
                            color: ColorUtils.black,
                            letterSpacing: 1.9,
                            fontSize: 15.0,
                          ),
                        ),
                        Container(
                          width: Get.width * .08,
                        ),
                      ],
                    ),
                  ),
                );
              }
            })
          : WidgetUtils.neuTextField(
              focusNode: controller.mobileFocusNode,
              controller: controller.mobileController.value,
              onChange: controller.onChange,
              textAlign: TextAlign.center,
              enabled: true,
              formatter: [
                LengthLimitingTextInputFormatter(11),
              ],
              keyboardType: TextInputType.phone,
              title: "شماره موبایل",
            ),
    );
  }

  Widget passwordInput() {
    return WidgetUtils.neuTextField(
      focusNode: controller.passwordNode,
      controller: controller.passwordController,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.visiblePassword,
      title: "رمز عبور",
    );
  }

  Widget codeInput() {
    return WidgetUtils.neuTextField(
      focusNode: controller.codeFocusNode,
      controller: controller.codeController,
      textAlign: TextAlign.center,
      formatter: [
        LengthLimitingTextInputFormatter(5),
      ],
      onChange: (String string) {
        if (string.length > 4) {
          // controller.submit();
        }
      },
      keyboardType: TextInputType.number,
      title: "کد تایید ارسالی را وارد کنید",
    );
  }

  Widget button() {
    return controller.isLogin.value
        ? WidgetUtils.neuButton(
            textColor: Colors.white,
            enabled: controller.mobileController.value.text.length == 11,
            text: controller.isLogin.value ? "ورود" : "مرحله بعد",
            onTap: () => controller.submit(),
          )
        : controller.isRegister.value || controller.isForgot.value
            ? WidgetUtils.neuButton(
                textColor: Colors.white,
                enabled: controller.mobileController.value.text.length == 11,
                text: controller.isLogin.value ? "ورود" : "مرحله بعد",
                onTap: () => controller.submit(),
              )
            : Container();
  }
}
