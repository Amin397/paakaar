import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/UserDashboardController/view_proposal_controller.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';
import 'package:paakaar/Widgets/rate_user_dialog.dart';

class ViewProposalScreen extends StatelessWidget {
  final ViewProposalController controller = Get.put(
    ViewProposalController(),
  );

  ViewProposalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: controller.scaffoldKey,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: controller.scaffoldKey,
        ),
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
          const Text(
            "مشاهده پیشنهاد",
            style: TextStyle(
              color: ColorUtils.black,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
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
          Row(
            children: [
              Text(
                'تاریخ پیشنهاد',
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
                controller.proposal.date,
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
                'نوع قیمت',
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
                controller.proposal.priceType.name,
                style: const TextStyle(
                  color: ColorUtils.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (controller.proposal.priceType.id != 4) ...[
            ViewUtils.sizedBox(),
            Row(
              children: [
                Text(
                  'قیمت پیشنهادی',
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
                  ViewUtils.moneyFormat(
                    controller.proposal.price.toDouble(),
                    toman: true,
                  ),
                  style: const TextStyle(
                    color: ColorUtils.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
          ViewUtils.sizedBox(),
          DottedBorder(
            padding: EdgeInsets.zero,
            color: ColorUtils.mainRed,
            child: Container(
              height: 1.0,
            ),
          ),
          ViewUtils.sizedBox(),
          buildUser(),
          ViewUtils.sizedBox(),
          Row(
            children: [
              Text(
                'تعداد پیشنهادات این متقاضی',
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
                controller
                    .proposal
                    .individual
                    .sentProposalCount
                    .toString(),
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
                'پیشنهادات قبول شده این متقاضی',
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
                controller
                    .proposal
                    .individual
                    .acceptedProposalCount
                    .toString(),
                style: const TextStyle(
                  color: ColorUtils.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
              child: Column(
                children: [
                  Text(
                    controller.proposal.desc,
                    style: TextStyle(
                      color: ColorUtils.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          WidgetUtils.button(
            text: controller.isRating ? "ثبت بازخورد" : "قبول پیشنهاد",
            onTap: () async {
              controller.unFocus();
              if (controller.isRating) {
                Map<String, dynamic>? data = await Get.dialog(
                  RateUserDialog(
                    user: controller.proposal.individual,
                  ),
                  barrierColor: Colors.black.withOpacity(0.5),
                );
                if (data != null) {
                  controller.saveComment(data);
                }
              } else {
                bool? isConfirmed = await GetConfirmationDialog.show(
                  text: "آیا از قبول پیشنهاد این متقاضی اطمینان دارید؟",
                );
                if (isConfirmed == true) {
                  controller.acceptProposal();
                }
              }
            },
          ),
          ViewUtils.sizedBox(25),
        ],
      ),
    );
  }

  Widget buildUser() {
    return GestureDetector(
      onTap: () {
        controller.unFocus();
        Get.to(
          () => ExpertSinglePageScreen(
            expert: controller.proposal.individual,
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
              if (controller.proposal.individual.avatar is String)
                ClipRRect(
                  child: Image.network(
                    controller.proposal.individual.avatar!,
                    width: Get.width / 8,
                    fit: BoxFit.fill,
                    height: Get.width / 8,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              if (controller.proposal.individual.avatar == null)
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
                    controller.proposal.individual.fullName,
                    style: const TextStyle(
                      color: ColorUtils.black,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    controller.proposal.individual.specialities!.isNotEmpty
                        ? controller
                            .proposal
                            .individual
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
    );
  }
}
