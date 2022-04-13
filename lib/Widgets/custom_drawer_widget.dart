import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:paakaar/Controllers/Drawer/my_drawer_controller.dart';
import 'package:paakaar/Controllers/Profile/complete_profile_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/MembershipInfoScreen/membership_info_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawerWidget extends StatelessWidget {

  MyDrawerController drawerController = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Globals.userStream.getStream,
      builder: (context, snapshot) {
        return Drawer(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: ViewUtils.scaffoldPadding,
              child: Column(
                children: [
                  ViewUtils.sizedBox(18),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Ionicons.close_outline,
                        ),
                      ),
                    ],
                  ),
                  ViewUtils.sizedBox(),
                  buildUser(),
                  ViewUtils.sizedBox(),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: ViewUtils.boxShadow(
                              blurRadius: 12.0,
                              spreadRadius: 1.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                                // drawerController.scaffoldKey.currentState
                                //     ?.openEndDrawer();
                                Get.toNamed(
                                  RoutingUtils.userDashboard.name,
                                );
                              },
                              borderRadius: BorderRadius.circular(10.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageUtils.padLock,
                                    height: 26.0,
                                    width: 26.0,
                                    color: ColorUtils.textColor,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "داشبورد",
                                    style: TextStyle(
                                      color: ColorUtils.textColor,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_right,
                                    color: ColorUtils.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          height: Get.height / 12,
                        ),
                        // buildMenuItem(
                        //   icon: ImageUtils.padLock,
                        //   title: ,
                        //   onTap: () {
                        //     drawerController.scaffoldKey.currentState?.openEndDrawer();
                        //     Get.toNamed(
                        //       RoutingUtils.userDashboard.name,
                        //     );
                        //   },
                        // ),


                        ViewUtils.sizedBox(),
                        // if (Globals.userStream.user!.role!.membershipId == 1)
                          buildMenuItem(
                            icon: Ionicons.bar_chart,
                            title: "تهیه اشتراک",
                            onTap: () {
                              // drawerController.scaffoldKey.currentState
                              //     ?.openEndDrawer();
                              Get.toNamed(
                                RoutingUtils.upgradePlan.name,
                              );
                            },
                          ),
                        // if (Globals.userStream.user!.role!.membershipId != 1)
                        //   buildMenuItem(
                        //     icon: Ionicons.checkmark_done_outline,
                        //     title: "تکمیل پروفایل",
                        //     onTap: () {
                        //       drawerController.scaffoldKey.currentState
                        //           ?.openEndDrawer();
                        //       Get.toNamed(
                        //         RoutingUtils.completeProfile.name,
                        //       );
                        //     },
                        //   ),
                        ViewUtils.sizedBox(),
                        if (Globals.userStream.user!.role!.membershipId !=
                            1) ...[
                          buildMenuItem(
                            icon: Ionicons.add,
                            title: "ثبت آگهی",
                            onTap: () {
                              // drawerController.scaffoldKey.currentState
                              //     ?.openEndDrawer();
                              drawerController.getCanAddAdd();
                            },
                          ),
                        ],
                          ViewUtils.sizedBox(),
                        buildMenuItem(
                          icon: Ionicons.flag_outline,
                          title: "ثبت فراخوان",
                          onTap: () {
                            // drawerController.scaffoldKey.currentState
                            //     ?.openEndDrawer();
                            // Get.toNamed(
                            //   RoutingUtils.adAdd.name,
                            // );
                            drawerController.getCanAddCall();
                          },
                        ),
                        ViewUtils.sizedBox(),
                        buildMenuItem(
                          icon: Ionicons.bookmark_outline,
                          title: "نشان شده ها",
                          onTap: () {
                            // drawerController.scaffoldKey.currentState
                            //     ?.openEndDrawer();
                            Get.toNamed(
                              RoutingUtils.myBookmarks.name,
                              arguments: {},
                            );
                          },
                        ),
                        ViewUtils.sizedBox(),
                        buildMenuItem(
                          icon: Ionicons.people_outline,
                          title: "درباره تیتراژ",
                          onTap: () {
                            // drawerController.scaffoldKey.currentState
                            //     ?.openEndDrawer();
                            launch(
                              'https://paakaar.com/about',
                            );
                          },
                        ),
                        ViewUtils.sizedBox(),
                        buildMenuItem(
                          icon: Ionicons.headset_outline,
                          title: "پشتیبانی",
                          onTap: () {
                            // drawerController.scaffoldKey.currentState
                            //     ?.openEndDrawer();

                            Get.toNamed(RoutingUtils.support.name,
                                arguments: {});
                            // launch(
                            //   'https://titraj.negaapps.ir/support',
                            // );
                          },
                        ),
                        ViewUtils.sizedBox(),
                        buildMenuItem(
                          icon: Ionicons.enter_outline,
                          title: "ورود به سایت تیتراژ",
                          onTap: () {
                            // drawerController.scaffoldKey.currentState
                            //     ?.openEndDrawer();
                            launch(
                              'https://paakaar.com/',
                            );
                          },
                        ),
                        ViewUtils.sizedBox(),
                        buildMenuItem(
                          icon: Ionicons.share_social_outline,
                          title: "شبکه های اجتماعی تیتراژ",
                          onTap: () {
                            // drawerController.scaffoldKey.currentState
                            //     ?.openEndDrawer();
                            launch(
                              'https://www.instagram.com/accounts/login/?next=/paakaar/',
                            );
                          },
                        ),
                        ViewUtils.sizedBox(),
                        buildMenuItem(
                          onTap: () {
                            GetConfirmationDialog.show(
                              text:
                                  "شما در حال خارج شدن از حساب کاربری خود هستید",
                              title: "خروج از برنامه",
                            ).then(
                              (value) async {
                                if (value == true) {
                                  final box = GetStorage();
                                  await box.remove('userId');
                                  await box.remove('firstEnter');
                                  await box.remove('firstLogin');
                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
                                    exit(0);
                                  });
                                } else {
                                  // Get.back();
                                }
                              },
                            );
                          },
                          icon: Ionicons.exit_outline,
                          title: "خروج از حساب کاربری",
                        ),

                        ViewUtils.sizedBox(),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: (){
                              showDeveloperAlert();
                            },
                            child: const Text(
                              '2.4.9',
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                        ViewUtils.sizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildUser() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 480.0) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(Get.context!);
              Get.delete<CompleteProfileController>();
              Get.toNamed(
                RoutingUtils.completeProfile.name,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                NeumorphicContainer(
                  height: Get.height / 10,
                  decoration: MyNeumorphicDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  curveType: CurveType.concave,
                  width: Get.width / 1.5,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (Globals.userStream.user?.avatar is String)
                          StreamBuilder(
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return ClipRRect(
                                child: Image.network(
                                  Globals.userStream.user!.avatar!,
                                  width: Get.width / 8,
                                  fit: BoxFit.fill,
                                  height: Get.width / 8,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              );
                            },
                            stream: Globals.userStream.getStream,
                          ),
                        if (Globals.userStream.user?.avatar == null)
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
                          children: const [
                            Text(
                              // Globals.userStream.user!.fullName,
                              'تکمیل پروفایل',
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontSize: 18.0,
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
                Positioned(
                  top: -15,
                  right: -5,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.dialog(
                        MembershipInfoScreen(
                          membership: Globals.userStream.user!.role!,
                        ),
                        barrierColor: ColorUtils.black.withOpacity(0.5),
                      );
                    },
                    child: Container(
                      height: Get.height / 24,
                      width: Get.height / 24,
                      decoration: BoxDecoration(
                        color: ColorUtils.orange.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorUtils.orange,
                        ),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          Globals.userStream.user!.role!.membershipName,
                          maxLines: 1,
                          minFontSize: 1.0,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 9.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              Navigator.pop(Get.context!);
              Get.delete<CompleteProfileController>();
              Get.toNamed(
                RoutingUtils.completeProfile.name,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                NeumorphicContainer(
                  height: Get.height * .1,
                  decoration: MyNeumorphicDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  curveType: CurveType.concave,
                  width: Get.width / 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (Globals.userStream.user?.avatar is String)
                        ClipRRect(
                          child: Image.network(
                            Globals.userStream.user!.avatar!,
                            width: Get.width / 8,
                            fit: BoxFit.fill,
                            height: Get.width / 8,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      if (Globals.userStream.user?.avatar == null)
                        Icon(
                          Ionicons.person_outline,
                          size: Get.width * .01,
                          color: ColorUtils.mainRed,
                        ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              // Globals.userStream.user!.fullName,
                              'تکمیل پروفایل',
                              maxLines: 2,
                              maxFontSize: 20.0,
                              minFontSize: 14.0,
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: ColorUtils.green,
                        size: Get.width / 12,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -15,
                  right: -5,
                  child: GestureDetector(
                    onTap: () => Get.dialog(
                      MembershipInfoScreen(
                        membership: Globals.userStream.user!.role!,
                      ),
                      barrierColor: ColorUtils.black.withOpacity(0.5),
                    ),
                    child: Container(
                      height: Get.height / 24,
                      width: Get.height / 24,
                      decoration: BoxDecoration(
                        color: ColorUtils.orange.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorUtils.orange,
                        ),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          Globals.userStream.user!.role!.membershipName,
                          maxLines: 1,
                          minFontSize: 1.0,
                          style: const TextStyle(
                            color: ColorUtils.black,
                            fontSize: 9.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String title,
    Null Function()? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ViewUtils.boxShadow(
          blurRadius: 12.0,
          spreadRadius: 1.0,
        ),
      ),
      margin: const EdgeInsets.only(left: 8.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Get.back();
            if (onTap != null) onTap();
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: ColorUtils.mainRed.shade200,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                title,
                style: TextStyle(
                  color: ColorUtils.textColor,
                  fontSize: 15.0,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_right,
                color: ColorUtils.green,
              ),
            ],
          ),
        ),
      ),
      height: Get.height / 12,
    );
  }

  void showDeveloperAlert() {
    if (Globals.developerTeam.tapCount < 10) {
      Globals.developerTeam.addCount();
    } else {
      Globals.developerTeam.resetCount();
      showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => Container(
          color: Colors.white,
          height: Get.height * .3,
          width: Get.width,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'تیم برنامه نویسی پروژه',
                style: TextStyle(
                  color: ColorUtils.textColor,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Expanded(
                child: SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  height: double
                                      .maxFinite,
                                  width: double
                                      .maxFinite,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Nexolas',
                                      ),
                                      SizedBox(
                                        height:
                                        Get.height *
                                            .02,
                                      ),
                                      Lottie.asset(
                                        'assets/animations/developer.json',
                                        height:
                                        Get.width *
                                            .15,
                                        width:
                                        Get.width *
                                            .15,
                                      ),
                                      IconButton(
                                        onPressed:
                                            () async{
                                          launch(
                                            'https://instagram.com/navid_nexolas?utm_medium=copy_link',
                                          );
                                        },
                                        icon: Icon(
                                          Icons.link,
                                          color: ColorUtils
                                              .myRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  height: double
                                      .maxFinite,
                                  width: double
                                      .maxFinite,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Angry Flutter',
                                      ),
                                      SizedBox(
                                        height:
                                        Get.height *
                                            .02,
                                      ),
                                      Lottie.asset(
                                        'assets/animations/developer.json',
                                        height:
                                        Get.width *
                                            .15,
                                        width:
                                        Get.width *
                                            .15,
                                      ),
                                      IconButton(
                                        onPressed:
                                            () async{
                                          launch(
                                            'https://instagram.com/angry.flutter?utm_medium=copy_link',
                                          );
                                        },
                                        icon: Icon(
                                          Icons.link,
                                          color: ColorUtils
                                              .myRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  height: double
                                      .maxFinite,
                                  width: double
                                      .maxFinite,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Parsa.Best',
                                      ),
                                      SizedBox(
                                        height:
                                        Get.height *
                                            .02,
                                      ),
                                      Lottie.asset(
                                        'assets/animations/developer.json',
                                        height:
                                        Get.width *
                                            .15,
                                        width:
                                        Get.width *
                                            .15,
                                      ),
                                      IconButton(
                                        onPressed:
                                            ()async {
                                          launch(
                                            'https://instagram.com/parsa._.barati?utm_medium=copy_link',
                                          );
                                        },
                                        icon: Icon(
                                          Icons.link,
                                          color: ColorUtils
                                              .myRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Text(
                        'Negarineh Team',
                        style: TextStyle(
                            color:
                            ColorUtils.textColor,
                            fontSize: 12.0),
                      ),
                      // Expanded(
                      //   child: Container(
                      //     height: double.maxFinite,
                      //     width: double.maxFinite,
                      //     child: const Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child:
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
