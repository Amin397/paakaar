import 'package:auto_size_text/auto_size_text.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Models/Calls/ad_model.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdInfoScreen extends StatelessWidget {
  final AdModel ad;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AdInfoScreen({
    Key? key,
    required this.ad,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: scaffoldKey,
        ),
        key: scaffoldKey,
        drawer: CustomDrawerWidget(),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Center(
      child: Column(
        children: [
          ViewUtils.sizedBox(),
          buildBanner(),
          ViewUtils.sizedBox(),
          SizedBox(
            width: Get.width,
            height: Get.height * .1,
            child: Column(
              children: [
                Align(
                  child: Text(
                    ViewUtils.moneyFormat(
                      ad.price.toDouble(),
                    ) +
                        " تومان",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: ColorUtils.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Expanded(
                  child: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: AutoSizeText(
                        ad.title,
                        minFontSize: 12.0,
                        maxFontSize: 18.0,
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: ColorUtils.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ViewUtils.sizedBox(25),
          buildInfoRow(
            first: "زمینه",
            second: ad.field.name,
          ),
          ViewUtils.sizedBox(50),
          buildInfoRow(
            first: "استان",
            second: ad.state.name,
          ),
          ViewUtils.sizedBox(50),
          buildInfoRow(
            first: "شهر",
            second: ad.city.name,
          ),
          ViewUtils.sizedBox(50),
          buildInfoRow(
            first: "توضیحات",
            second: '',
          ),
          ViewUtils.sizedBox(80),
          Expanded(
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Align(
                alignment: Alignment.topRight,
                child: AutoSizeText(
                  ad.desc,
                  maxLines: 6,
                  maxFontSize: 18.0,
                  minFontSize: 10.0,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildInfoRow(
                    first: "آگهی دهنده",
                    second: '',
                  ),
                  buildUser(),
                ],
              ),
            ),
          ),
          ViewUtils.sizedBox(),
        ],
      ),
    );
  }

  Widget buildUser() {
    print(ad.individualPic);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 300.0) {
          return GestureDetector(
            onTap: () {
              Get.to(
                    () => ExpertSinglePageScreen(
                  expertId: ad.individualId.toString(),
                      fromChat: false,
                ),
              );
            },
            child: Container(
              height: Get.height * .08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: ViewUtils.boxShadow(),
              ),
              width: Get.width ,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (ad.individualPic is String)
                      ClipRRect(
                        child: Image.network(
                          ad.individualPic,
                          width: Get.width / 8,
                          fit: BoxFit.fill,
                          height: Get.width / 8,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    if (ad.individualPic == null)
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
                          ad.name,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 18.0,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 8.0,
                        // ),
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
          );
        } else {
          return GestureDetector(
            onTap: () {
              Get.to(
                    () => ExpertSinglePageScreen(
                  expertId: ad.individualId.toString(),
                      fromChat: false,
                ),
              );
            },
            child: Container(
              // height: Get.height * .15,
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
                    if (ad.individualPic is String)
                      ClipRRect(
                        child: Image.network(
                          ad.individualPic,
                          width: Get.width / 8,
                          fit: BoxFit.fill,
                          height: Get.width / 8,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    if (ad.individualPic == null)
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
                          ad.name,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // Text(
                        //   controller.chat.user.specialities!.isNotEmpty
                        //       ? controller.chat.user.specialities!
                        //       .map((e) => e.name)
                        //       .join('٬ ')
                        //       : '',
                        //   style: TextStyle(
                        //     fontSize: 11.0,
                        //     color: ColorUtils.textColor,
                        //   ),
                        // ),
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
          );
        }
      },
    );
  }

  Widget buildInfoRow({required String first, required String second}) {
    return Row(
      children: [
        Text(
          first,
          style: TextStyle(
            color: ColorUtils.textColor,
            fontSize: 14.0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: ColorUtils.mainRed.shade200,
              thickness: 0.2,
            ),
          ),
        ),
        Text(
          second,
          style: TextStyle(
            color: ColorUtils.mainRed.shade900,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget buildBanner() {
    return Container(
      width: Get.width / 1,
      height: Get.height / 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          ad.cover,
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
