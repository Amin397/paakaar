import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paakaar/Pages/ConnectUs/Controller/connect_us_controller.dart';
import 'package:paakaar/Pages/ConnectUs/Model/connect_us_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectUsScreen extends StatelessWidget {
  ConnectUsScreen({Key? key}) : super(key: key);
  final ConnectUsController? connectUsController =
      Get.put(ConnectUsController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                right: Get.width * .02,
              ),
              width: Get.width,
              height: Get.height * .05,
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: ColorUtils.myRed,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const AutoSizeText(
                        'تلفن تماس:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      padding: EdgeInsets.only(
                        left: Get.width * .05,
                      ),
                      child: GetBuilder(
                        init: connectUsController,
                        builder: (ctx) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                launch('tel:${connectUsController!.model!.telephone}');
                              },
                              child: AutoSizeText(
                                (connectUsController!.model is ConnectusModel)
                                    ? connectUsController!.model!.telephone!
                                    : '',
                                style: TextStyle(
                                  color: ColorUtils.mainRed,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                right: Get.width * .02,
              ),
              width: Get.width,
              height: Get.height * .05,
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: ColorUtils.myRed,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const AutoSizeText(
                        'ایمیل:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: Get.width * .05,
                      ),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: GetBuilder(
                        init: connectUsController,
                        builder: (ctx) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                launch('mailto:${connectUsController!.model!.email}?subject=paakaar');
                              },
                              child: AutoSizeText(
                                (connectUsController!.model is ConnectusModel)
                                    ? connectUsController!.model!.email!
                                    : '',
                                style: TextStyle(
                                  color: ColorUtils.mainRed,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                right: Get.width * .02,
              ),
              width: Get.width,
              height: Get.height * .05,
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.alternate_email,
                        color: ColorUtils.myRed,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const AutoSizeText(
                        'وبسایت:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      padding: EdgeInsets.only(
                        left: Get.width * .05,
                      ),
                      child: GetBuilder(
                        init: connectUsController,
                        builder: (ctx) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                launch(connectUsController!.model!.website!.replaceAll('https', 'http'));
                              },
                              child: AutoSizeText(
                                (connectUsController!.model is ConnectusModel)
                                    ? connectUsController!.model!.website!
                                    : '',
                                style: TextStyle(
                                  color: ColorUtils.mainRed,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              padding: EdgeInsets.only(
                right: Get.width * .02,
              ),
              height: Get.height * .05,
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.send,
                        color: ColorUtils.myRed,
                        size: 20.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const AutoSizeText(
                        'تلگرام:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: GetBuilder(
                        init: connectUsController,
                        builder: (ctx) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                launch(connectUsController!.model!.telegram!);
                              },
                              child: AutoSizeText(
                                (connectUsController!.model is ConnectusModel)
                                    ? connectUsController!.model!.telegram!
                                    : '',
                                style: TextStyle(
                                  color: ColorUtils.mainRed,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      padding: EdgeInsets.only(
                        left: Get.width * .05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height * .05,
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        height: double.maxFinite,
                        width: Get.width * .1,
                        padding: const EdgeInsets.all(8.0),
                        child: const Image(
                          image: AssetImage(
                            'assets/whatsapp.png',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const AutoSizeText(
                        'واتساپ:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: GetBuilder(
                        init: connectUsController,
                        builder: (ctx) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                launch('https://whatsapp.com/'+connectUsController!.model!.whatsapp.toString());
                              },
                              child: AutoSizeText(
                                (connectUsController!.model is ConnectusModel)
                                    ? connectUsController!.model!.whatsapp!
                                    : '',
                                style: TextStyle(
                                  color: ColorUtils.mainRed,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      padding: EdgeInsets.only(
                        left: Get.width * .05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height * .05,
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        height: double.maxFinite,
                        width: Get.width * .1,
                        padding: const EdgeInsets.all(8.0),
                        child: const Image(
                          image: AssetImage(
                            'assets/instagram-logo.png',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      const AutoSizeText(
                        'اینستاگرام:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: GetBuilder(
                        init: connectUsController,
                        builder: (ctx) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                launch(connectUsController!.model!.instagram.toString());
                              },
                              child: AutoSizeText(
                                (connectUsController!.model is ConnectusModel)
                                    ? connectUsController!.model!.instagram!
                                    : '',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: ColorUtils.mainRed,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      padding: EdgeInsets.only(
                        left: Get.width * .05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
