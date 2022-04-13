import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:paakaar/Controllers/AppIntro/AppIntroController.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class AppIntroScreen extends StatelessWidget {
  AppIntroScreen({Key? key}) : super(key: key);
  final AppIntroController controller = Get.put(
    AppIntroController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints raints) {
          if (raints.maxWidth > 480.0) {
            return GetBuilder(
              init: controller,
              builder: (context) {
                return controller.listOfScreens.isNotEmpty
                    ? Column(
                        children: [
                          ViewUtils.sizedBox(12.5),
                          Expanded(
                            child: IntroductionScreen(
                              globalBackgroundColor: Colors.white,
                              nextColor: ColorUtils.green,
                              skipColor: ColorUtils.blue,
                              pages: controller.listOfScreens.map(
                                (e) {
                                  return PageViewModel(
                                    titleWidget: Text(
                                      e.title,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        color: ColorUtils.black,
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    bodyWidget: Padding(
                                      padding: EdgeInsets.only(
                                        top: Get.height / 48,
                                      ),
                                      child: Html(
                                        data: e.text,
                                        style: {
                                          '*': Style(
                                            textAlign: TextAlign.justify,
                                            direction: TextDirection.rtl,
                                            lineHeight: LineHeight.percent(
                                              120.0,
                                            ),
                                          ),
                                        },
                                      ),
                                    ),
                                    image: Center(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          e.banner,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    decoration: const PageDecoration(
                                      boxDecoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onDone: () {
                                Get.offAndToNamed(
                                  RoutingUtils.loginRegister.name,
                                );
                              },
                              onSkip: () {
                                Get.offAndToNamed(
                                  RoutingUtils.loginRegister.name,
                                );
                              },
                              next: const Icon(Icons.navigate_next),
                              showSkipButton: true,
                              skip: const Text("رد کردن"),
                              done: const Text(
                                "ورود به اپ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: WidgetUtils.loadingWidget(),
                      );
              },
            );
          } else {
            return GetBuilder(
              init: controller,
              builder: (context) {
                return controller.listOfScreens.isNotEmpty
                    ? Column(
                        children: [
                          ViewUtils.sizedBox(15.0),
                          Expanded(
                            child: IntroductionScreen(
                              globalBackgroundColor: Colors.white,
                              nextColor: ColorUtils.green,
                              skipColor: ColorUtils.blue,
                              pages: controller.listOfScreens
                                  .map(
                                    (e) => PageViewModel(
                                      titleWidget: Text(
                                        e.title,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: const TextStyle(
                                          color: ColorUtils.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      bodyWidget: Padding(
                                        padding: EdgeInsets.only(
                                          top: Get.height * .03,
                                        ),
                                        child: Html(
                                          data: e.text,
                                          style: {
                                            '*': Style(
                                              textAlign: TextAlign.justify,
                                              direction: TextDirection.rtl,

                                              lineHeight: LineHeight.percent(
                                                120.0,
                                              ),
                                            ),
                                          },
                                        ),
                                      ),
                                      image: Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(Get.width * .06),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              e.banner,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      decoration: const PageDecoration(
                                        boxDecoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onDone: () {
                                Get.offAndToNamed(
                                  RoutingUtils.loginRegister.name,
                                );
                              },
                              onSkip: () {
                                Get.offAndToNamed(
                                  RoutingUtils.loginRegister.name,
                                );
                              },
                              next: const Icon(
                                Icons.navigate_next,
                                size: 20.0,
                              ),
                              showSkipButton: true,
                              skip: const Text(
                                "رد کردن",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              done: const Text(
                                "ورود به اپ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: WidgetUtils.loadingWidget(),
                      );
              },
            );
          }
        }),
      ),
    );
  }
}
