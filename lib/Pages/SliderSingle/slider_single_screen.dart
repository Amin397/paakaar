import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/MainPage/UpSlider.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderSingleScreen extends StatelessWidget {
  final UpSliderModel slider;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SliderSingleScreen({
    Key? key,
    required this.slider,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                slider.upSliderName,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: ColorUtils.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (slider.field is FieldModel) ...[
            ViewUtils.sizedBox(25),
            buildInfoRow(
              first: "زمینه",
              second: slider.field?.name ?? '',
            ),
          ],
          ViewUtils.sizedBox(12.5),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * .05,
              ),
              width: Get.width,
              height: double.maxFinite,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  slider.upSliderText,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
          ViewUtils.sizedBox(),
          if (slider.upSliderLink.isNotEmpty)
            WidgetUtils.button(
              text: "مشاهده لینک",
              onTap: () async {
                bool canGo = await GetConfirmationDialog.show(
                  text:
                      "شما قرار است به صفحه ای خارج از اپلیکیشن تیتراژ هدایت شوید",
                );
                if (canGo == true) {
                  print(slider.upSliderLink);
                  launch(
                    slider.upSliderLink,
                  );
                }
              },
            ),
          ViewUtils.sizedBox(),
        ],
      ),
    );
  }

  Widget buildInfoRow({
    required String first,
    required String second,
  }) {
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
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
      height: Get.width / 1.7,
      width: Get.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          slider.upSliderImage,
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
