import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frefresh/frefresh.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share/share.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/Chat/chat_screen.dart';
import 'package:paakaar/Pages/MainPage/Widgets/call_outs_widget.dart';
import 'package:paakaar/Pages/MainPage/Widgets/fields_widget.dart';
import 'package:paakaar/Pages/MainPage/Widgets/top_slider_widget.dart';
import 'package:paakaar/Pages/MainPage/Widgets/tv_widget.dart';
import 'package:paakaar/Pages/Profile/complete_profile_screen.dart';
import 'package:paakaar/Pages/UserDashboardScreen/user_dashboard_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_bottom_navigation_bar.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';
import 'package:paakaar/Widgets/get_fields_and_groups_dialog.dart';

import '../../main.dart';
import '../Notification/View/notification_modal_screen.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(
    DashboardController(),
  );

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? canBack;
        if (controller.currentPage.value > 1) {
          controller.currentPage.value = 1;
          // controller.refresh();
        } else {
          canBack = await GetConfirmationDialog.show(
            text: "?????? ???? ?????? ???????? ?????? ???? ???????????????? ???????????? ??????????",
          );
        }
        if (canBack == true) {
          exit(0);
          // controller.showTutorial();
          // return true;
        }
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorUtils.mainRed.shade900,
            actions: [
              ...[
                IconButton(
                  onPressed: () {
                    Share.share('https://paakaar.com/App/paakaar.apk');
                  },
                  icon: const Icon(
                    Ionicons.share_social_outline,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                      Get.toNamed(
                        RoutingUtils.myBookmarks.name,
                        arguments: {},
                      );
                  },
                  icon: const Icon(
                    Ionicons.bookmark_outline,
                    color: Colors.white,
                  ),
                ),
              ],
              Stack(
                children: [
                  Center(
                    child: IconButton(
                      onPressed: ()async {

                          var box = GetStorage();
                          // Get.toNamed(
                          //   RoutingUtils.userDashboard.name,
                          // );
                          var modal = await showModalBottomSheet(
                            context: Get.context!,
                            backgroundColor: Colors.transparent,
                            builder: (context) => NotificationModalScreen(),
                          );
                          Globals.notification.deleteAllNotification();
                          box.write('notif', Globals.notification.notificationNumber);
                          box.write('notifList', null);
                      },
                      icon: const Icon(
                        FeatherIcons.bell,
                        color: Colors.white,
                      ),
                    ),
                  ),
                    Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: StreamBuilder(
                          stream: Globals.notification.getStream,
                          builder: (BuildContext context, i) {
                            return Center(
                              child: Text(
                                (Globals.notification.notificationNumber).toString(),
                                style: TextStyle(
                                  color: ColorUtils.red.shade900,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ],
            centerTitle: true,
            title: const Center(
              child: Text(
                "????????????????????????????",
                style: TextStyle(
                  letterSpacing: 5.0,
                  color: Colors.white,
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                  // if (key?.currentState?.isDrawerOpen != true) {
                  //   key?.currentState?.openDrawer();
                // Scaffold.of(context).openDrawer();
                scaffoldKey.currentState!.openDrawer();
                  // } else {
                  //   key?.currentState?.openEndDrawer();
                  // }

              },
              icon: const Icon(
                FeatherIcons.menu,
                color: Colors.white,
              ),
            ),
          ),
          key: scaffoldKey,
          drawer: CustomDrawerWidget(),
          floatingActionButton: KeyboardVisibilityBuilder(
            builder: (_, bool isVisible) {
              if (!isVisible) {
                return FloatingActionButton(
                  onPressed: () {
                    controller.showModal();
                    // Get.toNamed(
                    //   ClubRoutingUtils.clubDashboard.name,
                    // );
                  },
                  backgroundColor: Colors.white,
                  elevation: 5.0,
                  focusElevation: 5.0,
                  hoverElevation: 5.0,
                  highlightElevation: 5.0,
                  child: Center(
                    child: Icon(
                      Ionicons.storefront_outline,
                      color: ColorUtils.mainRed,
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: Colors.white,
          bottomNavigationBar: CustomBottomNavigationBar(
            dashboardController: controller,
          ),
          body: Obx(
            () => getPage(),
          ),
        ),
      ),
    );
  }

  Widget buildServiceRequestButton() {
    return Flexible(
      flex: 1,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints raints) {
          if (raints.maxWidth > 480.0) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (controller.isFieldsLoaded.isTrue &&
                      controller.listOfFields
                          .any((element) => element.isSelected.isTrue)) {
                    // Get.toNamed(RoutingUtils.requestService.name, arguments: {
                    //   'field': controller.listOfFields.singleWhere(
                    //         (element) => element.isSelected.isTrue,
                    //   ),
                    //   'type': 1,
                    // });
                    Get.toNamed(RoutingUtils.getFieldAndGroupDialog.name,
                        arguments: {
                          'field': controller.listOfFields.singleWhere(
                            (element) => element.isSelected.isTrue,
                          ),
                          'type': 1,
                        });
                  } else {
                    ViewUtils.showErrorDialog(
                      "???????? ?????????? ???? ?????????? ???????? ???? ???????????? ????????",
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Center(
                            child: AutoSizeText(
                              controller.isFieldsLoaded.isTrue
                                  ? "?????????? " +
                                      controller.listOfFields
                                          .singleWhere((element) =>
                                              element.isSelected.isTrue)
                                          .name
                                  : '',
                              maxLines: 2,
                              maxFontSize: 16.0,
                              minFontSize: 10.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorUtils.mainRed,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Image(
                        height: Get.width * .08,
                        width: Get.width * .08,
                        image: const AssetImage(
                          ImageUtils.selectIconPath,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: ViewUtils.boxShadow(
                      spreadRadius: 2.0,
                      blurRadius: 12.0,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (controller.isFieldsLoaded.isTrue &&
                      controller.listOfFields
                          .any((element) => element.isSelected.isTrue)) {
                    // Get.toNamed(RoutingUtils.requestService.name, arguments: {
                    //   'field': controller.listOfFields.singleWhere(
                    //         (element) => element.isSelected.isTrue,
                    //   ),
                    //   'type': 1,
                    // });

                    Get.toNamed(RoutingUtils.getFieldAndGroupDialog.name,
                        arguments: {
                          'field': controller.listOfFields.singleWhere(
                            (element) => element.isSelected.isTrue,
                          ),
                          'type': 1,
                        });
                  } else {
                    ViewUtils.showErrorDialog(
                      "???????? ?????????? ???? ?????????? ???????? ???? ???????????? ????????",
                    );
                  }
                },
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Center(
                            child: AutoSizeText(
                              controller.isFieldsLoaded.isTrue
                                  ? "?????????? " +
                                      controller.listOfFields
                                          .singleWhere((element) =>
                                              element.isSelected.isTrue)
                                          .name
                                  : '',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              maxFontSize: 16.0,
                              minFontSize: 10.0,
                              style: TextStyle(
                                color: ColorUtils.mainRed,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Image(
                        height: Get.width * .07,
                        width: Get.width * .07,
                        image: const AssetImage(
                          ImageUtils.selectIconPath,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(.8),
                        width: 1,
                      )
                      // boxShadow: ViewUtils.boxShadow(
                      //   spreadRadius: 2.0,
                      //   blurRadius: 12.0,
                      // ),
                      ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildCallOutButton() {
    return Flexible(
      flex: 1,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints raints) {
          if (raints.maxWidth > 300.0) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (Globals.userStream.user?.role?.viewCalls == false) {
                    ViewUtils.showErrorDialog(
                      "?????????? ???????????? ?????????????? ???? ???????? ???????????? ${Globals.userStream.user?.role?.membershipName} ???????? ????????",
                    );
                    return;
                  }
                  if (controller.isFieldsLoaded.isTrue &&
                      controller.listOfFields
                          .any((element) => element.isSelected.isTrue)) {
                    // Get.toNamed(RoutingUtils.requestService.name, arguments: {
                    //   'field': controller.listOfFields.singleWhere(
                    //         (element) => element.isSelected.isTrue,
                    //   ),
                    //   'type': 1,
                    // });
                    Get.toNamed(RoutingUtils.requestService.name, arguments: {
                      'field': controller.listOfFields.singleWhere(
                        (element) => element.isSelected.isTrue,
                      ),
                      'type': 2,
                    });
                  } else {
                    ViewUtils.showErrorDialog(
                      "???????? ?????????? ???? ?????????? ???????? ???? ???????????? ????????",
                    );
                  }
                },
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        height: Get.width * .08,
                        width: Get.width * .08,
                        image: const AssetImage(
                          ImageUtils.campaignIconPath,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Center(
                            child: AutoSizeText(
                              controller.isFieldsLoaded.isTrue
                                  ? "?????????????? "
                                  // controller.listOfFields
                                  //     .singleWhere((element) =>
                                  //         element.isSelected.isTrue)
                                  //     .name
                                  : '',
                              maxLines: 2,
                              maxFontSize: 16.0,
                              minFontSize: 10.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorUtils.mainRed,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(.8),
                        width: 1,
                      )
                      // boxShadow: ViewUtils.boxShadow(
                      //   spreadRadius: 2.0,
                      //   blurRadius: 12.0,
                      // ),
                      ),
                ),
              ),
            );
          } else {
            return Obx(
              () => Directionality(
                textDirection: TextDirection.ltr,
                child: GestureDetector(
                  onTap: () {
                    if (Globals.userStream.user?.role?.viewCalls == false) {
                      ViewUtils.showErrorDialog(
                        "?????????? ???????????? ?????????????? ???? ???????? ???????????? ${Globals.userStream.user?.role?.membershipName} ???????? ????????",
                      );
                      return;
                    }
                    if (controller.isFieldsLoaded.isTrue &&
                        controller.listOfFields
                            .any((element) => element.isSelected.isTrue)) {
                      // Get.toNamed(RoutingUtils.requestService.name, arguments: {
                      //   'field': controller.listOfFields.singleWhere(
                      //         (element) => element.isSelected.isTrue,
                      //   ),
                      //   'type': 1,
                      // });
                      Get.toNamed(RoutingUtils.requestService.name, arguments: {
                        'field': controller.listOfFields.singleWhere(
                          (element) => element.isSelected.isTrue,
                        ),
                        'type': 2,
                      });
                    } else {
                      ViewUtils.showErrorDialog(
                        "???????? ?????????? ???? ?????????? ???????? ???? ???????????? ????????",
                      );
                    }
                  },
                  child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: Center(
                              child: AutoSizeText(
                                controller.isFieldsLoaded.isTrue
                                    ? "?????????????? "
                                    // controller.listOfFields
                                    //     .singleWhere((element) =>
                                    //         element.isSelected.isTrue)
                                    //     .name
                                    : '',
                                maxLines: 2,
                                maxFontSize: 16.0,
                                minFontSize: 10.0,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorUtils.mainRed,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Image(
                          height: Get.width * .07,
                          width: Get.width * .07,
                          image: const AssetImage(
                            ImageUtils.campaignIconPath,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(.8),
                          width: 1,
                        )
                        // boxShadow: ViewUtils.boxShadow(
                        //   spreadRadius: 2.0,
                        //   blurRadius: 12.0,
                        // ),
                        ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget getPage() {
    switch (controller.currentPage.value) {
      case 1:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints raints) {
            if (Get.width > 400.0) {
              return Padding(
                padding: ViewUtils.scaffoldPadding,
                child: FRefresh(
                  headerHeight: Get.height / 8,
                  header: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Center(
                      child: WidgetUtils.loadingWidget(),
                    ),
                  ),
                  controller: controller.refreshController,
                  onRefresh: () async {
                    await controller.allInits();
                    controller.refreshController.finishRefresh();
                  },
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ViewUtils.sizedBox(),
                        TopSliderWidget(
                          controller,
                        ),
                        // ViewUtils.sizedBox(),
                        SizedBox(height: Get.height * .02,),
                        FieldsWidget(
                          dashboardController: controller,
                        ),
                        ViewUtils.sizedBox(),
                        SizedBox(
                          width: Get.width,
                          height: Get.height * .08,
                          child: Row(
                            children: [
                              buildServiceRequestButton(),
                              const SizedBox(
                                width: 8.0,
                              ),
                              buildCallOutButton(),
                            ],
                          ),
                        ),
                        ViewUtils.sizedBox(),
                        Obx(
                          () => controller.isCallOutsLoaded.isTrue
                              ? Column(
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     const Text(
                                    //       "???????? ????",
                                    //     ),
                                    //
                                    //   ],
                                    // ),
                                    StreamBuilder(
                                      stream: Globals.userStream.getStream,
                                      builder: (context, snapshot) {
                                        return (Globals.userStream.user?.role
                                                    ?.viewAds ==
                                                true)
                                            ? CallOutsWidget(
                                                dashboardController: controller,
                                              )
                                            : SizedBox(
                                                height: Get.height / 8,
                                                child: Center(
                                                  child: WidgetUtils.button(
                                                    onTap: () => Get.toNamed(
                                                      RoutingUtils
                                                          .upgradePlan.name,
                                                    ),
                                                    text:
                                                        "?????????? ?????????? ?????? ???????????? ???????? ????",
                                                  ),
                                                ),
                                              );
                                      },
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                        ViewUtils.sizedBox(),
                        TvWidget(
                          dashboardController: controller,
                        ),
                        ViewUtils.sizedBox(25),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: ViewUtils.scaffoldPadding,
                child: FRefresh(
                  headerHeight: Get.height * .1,
                  header: Container(
                    margin: const EdgeInsets.all(6.0),
                    child: Center(
                      child: WidgetUtils.loadingWidget(),
                    ),
                  ),
                  controller: controller.refreshController,
                  onRefresh: () async {
                    await controller.allInits();
                    controller.refreshController.finishRefresh();
                  },
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ViewUtils.sizedBox(),
                        TopSliderWidget(
                          controller,
                        ),
                        SizedBox(height: Get.height * .02,),
                        FieldsWidget(
                          dashboardController: controller,
                        ),
                        ViewUtils.sizedBox(),
                        SizedBox(
                          width: Get.width,
                          height: Get.height * .08,
                          child: Row(
                            children: [
                              buildServiceRequestButton(),
                              const SizedBox(
                                width: 8.0,
                              ),
                              buildCallOutButton(),
                            ],
                          ),
                        ),
                        ViewUtils.sizedBox(),
                        Obx(
                          () => controller.isCallOutsLoaded.isTrue
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    StreamBuilder(
                                      stream: Globals.userStream.getStream,
                                      builder: (context, snapshot) {
                                        return Globals.userStream.user?.role
                                                    ?.viewAds ==
                                                true
                                            ? CallOutsWidget(
                                                dashboardController: controller,
                                              )
                                            : SizedBox(
                                                height: Get.height / 8,
                                                child: Center(
                                                  child: WidgetUtils.button(
                                                    onTap: () => Get.toNamed(
                                                      RoutingUtils
                                                          .upgradePlan.name,
                                                    ),
                                                    text:
                                                        "?????????? ?????????? ?????? ???????????? ???????? ????",
                                                  ),
                                                ),
                                              );
                                      },
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                        ViewUtils.sizedBox(),
                        TvWidget(
                          dashboardController: controller,
                        ),
                        ViewUtils.sizedBox(25),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      case 3:
        return UserDashboardScreen(
          isDirect: false,
        );
      case 4:
        return ChatScreen(
          isDirect: false,
        );
      case 2:
        {
          return CompleteProfileScreen(
            isDirect: false,
          );
        }
      default:
        {
          return Container();
        }
    }
  }
}
