import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:paakaar/Controllers/ParticipateForCallOut/participate_for_call_out_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class ParticipateForCallOutScreen extends StatelessWidget {
  final ParticipateForCallOutController controller = Get.put(
    ParticipateForCallOutController(),
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
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
              child: Text(
                "شما در حال ارسال پیشنهاد برای فراخوان ${controller.callOut.name} ثبت شده توسط ${controller.callOut.individual?.fullName ?? ''} هستید!",
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  height: 1.8,
                  color: ColorUtils.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
          const Text(
            "قیمت پیشنهادی",
            style: TextStyle(
              height: 1.8,
              fontSize: 16.0,
              color: ColorUtils.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ViewUtils.sizedBox(),
          GetBuilder(
              init: controller,
              builder: (context) {
                return Row(
                  children: [
                    WidgetUtils.selectOptions(
                      title: "نوع قیمت",
                      controller: controller,
                      items: controller.listOfPriceTypes,
                      isActive: controller.isActive,
                      displayFormat: displayFormat,
                      makeActive: controller.makeActive,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Get.width / 1.7,
                      child: WidgetUtils.textField(
                        price: true,
                        controller: controller.priceController,
                        enabled: !controller.listOfPriceTypes
                            .singleWhere((element) => element.id == 5)
                            .isSelected,
                        // enabled: true,
                        toman: true,
                      ),
                    ),
                  ],
                );
              }),
          ViewUtils.sizedBox(25),
          DottedBorder(
            padding: EdgeInsets.zero,
            color: ColorUtils.mainRed,
            child: Container(
              height: 1.0,
            ),
          ),
          ViewUtils.sizedBox(),
          const Text(
            "متن پیشنهاد",
            style: TextStyle(
              height: 1.8,
              fontSize: 16.0,
              color: ColorUtils.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ViewUtils.sizedBox(),
          TextField(
            controller: controller.descTextController,
            maxLines: 5,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: ColorUtils.black,
                  width: 0.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: ColorUtils.mainRed,
                  width: 0.5,
                ),
              ),
            ),
          ),
          ViewUtils.sizedBox(25),
          WidgetUtils.button(
            text: "ارسال پیشنهاد و نمایش پروفایل به مشتری",
            onTap: () {
              if (controller.listOfPriceTypes
                      .singleWhere((element) => element.isSelected)
                      .id ==
                  5) {
                controller.unFocus();
                controller.sendProposal();
              } else {
                if (controller.priceController.text.isEmpty) {
                  ViewUtils.showErrorDialog(
                    'فیلد قیمت اجباری است',
                  );
                }else{
                  controller.unFocus();
                  controller.sendProposal();
                }
              }
            },
          ),
          ViewUtils.sizedBox(25),
        ],
      ),
    );
  }

  displayFormat(p1) {
    return p1.name;
  }
}
