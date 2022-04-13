import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paakaar/Controllers/UpgradePlan/upgrade_plan_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/membership_model.dart';
import 'package:paakaar/Pages/MembershipInfoScreen/membership_info_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class UpgradePlanScreen extends StatelessWidget {
  UpgradePlanScreen({Key? key}) : super(key: key);
  final UpgradePlanController controller = Get.put(
    UpgradePlanController(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Globals.userStream.user?.isExpired == false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: Globals.userStream.user?.isExpired == false
              ? WidgetUtils.appBar(
                  innerPage: true,
                  key: controller.scaffoldKey,
                )
              : null,
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ViewUtils.sizedBox(12),
                SvgPicture.asset(
                  ImageUtils.medalIcon,
                  width: Get.width / 4,
                ),
                ViewUtils.sizedBox(),
                const Text(
                  "خرید اشتراک",
                  style: TextStyle(
                    color: ColorUtils.black,
                    fontSize: 21.0,
                  ),
                ),
                ViewUtils.sizedBox(25),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "اشتراک کنونی: ",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 14.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: ColorUtils.mainRed.shade200,
                              thickness: 0.2,
                            ),
                          ),
                        ),
                        Text(
                          Globals.userStream.user!.role!.membershipName!,
                          style: TextStyle(
                            color: ColorUtils.mainRed,
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    ViewUtils.sizedBox(),
                    if (Globals.userStream.user?.role?.isSpecial == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "از",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            Globals.userStream.user!.membershipStart!,
                            style: TextStyle(
                              color: ColorUtils.mainRed,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "تا",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            Globals.userStream.user!.membershipExpire!,
                            style: TextStyle(
                              color: ColorUtils.mainRed,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                ViewUtils.sizedBox(25),
                SizedBox(
                  height: Get.height / 3,
                  child: Obx(
                    () => controller.isMemberShipsLoaded.isTrue
                        ? AnimationLimiter(
                            child: ListView.builder(
                              itemBuilder: buildMembership,
                              itemCount: controller.listOfMemberShips.length,
                            ),
                          )
                        : Center(
                            child: WidgetUtils.loadingWidget(),
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    height: Get.height / 21,
                    width: Get.width,
                    child: Row(
                      children: [
                        Container(
                          width: Get.width * .2,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.0),),
                          child: const Center(
                            child: AutoSizeText(
                              'انصراف',
                              maxFontSize: 14.0,
                              minFontSize: 10.0,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Obx(
                          () => Expanded(
                            child: GestureDetector(
                              onTap: () => controller.buyPlan(),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 175),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                // decoration: MyNeumorphicDecoration(
                                //   borderRadius: BorderRadius.circular(10.0),
                                //   color: ColorUtils.black,
                                // ),
                                decoration: BoxDecoration(
                                  color:
                                      controller.isMemberShipsLoaded.isTrue &&
                                              controller.listOfMemberShips.any(
                                                  (element) =>
                                                      element.isSelected.isTrue)
                                          ? ColorUtils.green.shade600
                                          : ColorUtils.green.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      'خرید',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: controller.isMemberShipsLoaded
                                                    .isTrue &&
                                                controller.listOfMemberShips
                                                    .any((element) => element
                                                        .isSelected.isTrue)
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.8),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                // curveType: enabled ? activeCurveType : CurveType.flat,
                                // bevel: enabled ? enabledBevel : 5.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ViewUtils.sizedBox(20),
                SvgPicture.asset(
                  ImageUtils.medalIcon,
                  width: Get.width / 4,
                ),
                ViewUtils.sizedBox(),
                const Text(
                  "خرید اشتراک",
                  style: TextStyle(
                    color: ColorUtils.black,
                    fontSize: 18.0,
                  ),
                ),
                ViewUtils.sizedBox(20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "اشتراک کنونی: ",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 12.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: ColorUtils.mainRed.shade200,
                              thickness: 0.2,
                            ),
                          ),
                        ),
                        Text(
                          Globals.userStream.user!.role!.membershipName!,
                          style: TextStyle(
                            color: ColorUtils.mainRed,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    ViewUtils.sizedBox(),
                    if (Globals.userStream.user?.role?.isSpecial == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "از",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            Globals.userStream.user!.membershipStart!,
                            style: TextStyle(
                              color: ColorUtils.mainRed,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "تا",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            Globals.userStream.user!.membershipExpire!,
                            style: TextStyle(
                              color: ColorUtils.mainRed,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                ViewUtils.sizedBox(25),
                Expanded(
                  child: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Obx(
                      () => controller.isMemberShipsLoaded.isTrue
                          ? AnimationLimiter(
                              child: ListView.builder(
                                itemBuilder: buildMembership,
                                itemCount: controller.listOfMemberShips.length,
                              ),
                            )
                          : Center(
                              child: WidgetUtils.loadingWidget(),
                            ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    height: Get.height / 21,
                    width: Get.width,
                    child: Row(
                      children: [
                        Container(
                          width: Get.width * .2,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Center(
                            child: AutoSizeText(
                              'انصراف',
                              maxFontSize: 14.0,
                              minFontSize: 10.0,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Obx(
                          () => Expanded(
                            child: GestureDetector(
                              onTap: () => controller.buyPlan(),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 175),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                // decoration: MyNeumorphicDecoration(
                                //   borderRadius: BorderRadius.circular(10.0),
                                //   color: ColorUtils.black,
                                // ),
                                decoration: BoxDecoration(
                                  color:
                                      controller.isMemberShipsLoaded.isTrue &&
                                              controller.listOfMemberShips.any(
                                                  (element) =>
                                                      element.isSelected.isTrue)
                                          ? ColorUtils.green.shade600
                                          : ColorUtils.green.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      'خرید',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: controller.isMemberShipsLoaded
                                                    .isTrue &&
                                                controller.listOfMemberShips
                                                    .any((element) => element
                                                        .isSelected.isTrue)
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.8),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                // curveType: enabled ? activeCurveType : CurveType.flat,
                                // bevel: enabled ? enabledBevel : 5.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildMembership(BuildContext context, int index) {
    MembershipModel membership = controller.listOfMemberShips[index];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: Obx(
                  () => Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.dialog(
                              MembershipInfoScreen(
                                membership: membership,
                              ),
                              barrierColor: ColorUtils.black.withOpacity(0.5),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 135),
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.info_outline,
                                color: ColorUtils.green.shade700,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: ViewUtils.boxShadow(),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: Get.height / 18,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            if (Globals.userStream.user!.buyFreeMembership == 0) {
                              for (var element
                              in controller.listOfMemberShips) {
                                element.isSelected.value = false;
                              }
                              membership.isSelected.value = true;
                            } else {
                              if(membership.membershipId == 2){
                                ViewUtils.showErrorDialog(
                                  "عضویت ${membership.membershipName} برای شما قابل انتخاب نیست٬ شما قبلا یک بار آن را انتخاب کرده اید",
                                );
                              }else{
                                for (var element
                                in controller.listOfMemberShips) {
                                  element.isSelected.value = false;
                                }
                                membership.isSelected.value = true;
                              }
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 135),
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: membership.isSelected.isTrue
                                  ? ColorUtils.mainRed
                                  : Colors.white,
                              boxShadow: ViewUtils.boxShadow(),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: Get.height / 18,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        membership.membershipName!,
                                        style: TextStyle(
                                          color: membership.isSelected.isTrue
                                              ? Colors.white
                                              : ColorUtils.textColor,
                                        ),
                                      ),
                                      Text(
                                        membership.membershipTime!,
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: membership.isSelected.isTrue
                                              ? Colors.white.withOpacity(0.7)
                                              : ColorUtils.textColor
                                                  .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  membership.membershipPrice! > 0
                                      ? Text(
                                          ViewUtils.moneyFormat(membership
                                                  .membershipPrice!
                                                  .toDouble()) +
                                              ' تومان',
                                          style: TextStyle(
                                            color: membership.isSelected.isTrue
                                                ? Colors.white
                                                : ColorUtils.textColor,
                                          ),
                                        )
                                      : Text(
                                          "رایگان",
                                          style: TextStyle(
                                            color: membership.isSelected.isTrue
                                                ? Colors.white
                                                : ColorUtils.textColor,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: Obx(
                  () => Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.dialog(
                              MembershipInfoScreen(
                                membership: membership,
                              ),
                              barrierColor: ColorUtils.black.withOpacity(0.5),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 135),
                            margin: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 2.0,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.info_outline,
                                color: ColorUtils.green.shade700,
                                size: 20.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: ViewUtils.boxShadow(),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: Get.height * .07,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            if (Globals.userStream.user!.buyFreeMembership == 0) {
                              for (var element
                              in controller.listOfMemberShips) {
                                element.isSelected.value = false;
                              }
                              membership.isSelected.value = true;
                            } else {
                              if(membership.membershipId == 2){
                                ViewUtils.showErrorDialog(
                                  "عضویت ${membership.membershipName} برای شما قابل انتخاب نیست٬ شما قبلا یک بار آن را انتخاب کرده اید",
                                );
                              }else{
                                for (var element
                                in controller.listOfMemberShips) {
                                  element.isSelected.value = false;
                                }
                                membership.isSelected.value = true;
                              }
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 135),
                            margin: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: membership.isSelected.isTrue
                                  ? ColorUtils.mainRed
                                  : Colors.white,
                              boxShadow: ViewUtils.boxShadow(),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: Get.height * .07,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * .05,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        membership.membershipName!,
                                        style: TextStyle(
                                            color: membership.isSelected.isTrue
                                                ? Colors.white
                                                : ColorUtils.textColor,
                                            fontSize: 12.0),
                                      ),
                                      Text(
                                        membership.membershipTime!,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: membership.isSelected.isTrue
                                              ? Colors.white.withOpacity(0.7)
                                              : ColorUtils.textColor
                                                  .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  membership.membershipPrice! > 0
                                      ? Text(
                                          ViewUtils.moneyFormat(membership
                                                  .membershipPrice!
                                                  .toDouble()) +
                                              ' تومان',
                                          style: TextStyle(
                                            color: membership.isSelected.isTrue
                                                ? Colors.white
                                                : ColorUtils.textColor,
                                          ),
                                        )
                                      : Text(
                                          "رایگان",
                                          style: TextStyle(
                                            color: membership.isSelected.isTrue
                                                ? Colors.white
                                                : ColorUtils.textColor,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
