import 'package:paakaar/Controllers/Club/Services/QRCodeScannerController.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';

class QRCodeScannerScreen extends StatelessWidget {
  final QRCodeScannerController qrCodeScannerController = Get.put(
    QRCodeScannerController(),
  );
  final String qrResult = '';

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: FeatherIcons.camera,
        text: 'بارکد خوان',
      ),
      showShape: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width / 5,
            ),
            child: _buildQRCodeAnimation(),
          ),
          SizedBox(
            height: Get.height * .07,
          ),
          _buildQrScanButton(),
          SizedBox(
            height: 8.0,
          ),
          Icon(
            Icons.arrow_drop_up,
          ),
          AutoSizeText(
            'لمس کنید',
            maxLines: 1,
            maxFontSize: 18.0,
            minFontSize: 10.0,
            style: TextStyle(fontSize: 14.0),
          )
        ],
      ),
    );
  }

  void startScan() async {
    // NavHelper.push(context, QrCodeScannerWidget());
  }

  Widget _buildQRCodeAnimation() {
    return Container(
      height: Get.height * .4,
      width: Get.height * .4,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: Get.height * .3,
              width: Get.height * .3,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: Get.height * .03,
                      width: Get.height * .03,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                          top: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: Get.height * .03,
                      width: Get.height * .03,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                          top: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: Get.height * .03,
                      width: Get.height * .03,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                          bottom: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: Get.height * .03,
                      width: Get.height * .03,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                          bottom: BorderSide(
                            width: 2.0,
                            color: ColorUtils.yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Lottie.asset(
              'assets/animations/qrCode.json',
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrScanButton() {
    return AnimationConfiguration.synchronized(
      duration: Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 100,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () async {
              // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              //   '#ff6666',
              //   'انصراف',
              //   true,
              //   ScanMode.QR,
              // );
            },
            child: Container(
              height: Get.height * .13,
              width: Get.height * .13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorUtils.black,
                boxShadow: ViewUtils.boxShadow(),
              ),
              child: Center(
                child: Icon(
                  Icons.qr_code_scanner_outlined,
                  size: Get.height * .07,
                  color: ColorUtils.yellow,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
