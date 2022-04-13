import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Controllers/Profile/complete_profile_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/social_media_model.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Plugins/FilePreview.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/get_confirmation_dialog.dart';
import 'package:paakaar/Widgets/Shared/image_preview_dialog.dart';
import 'package:paakaar/Widgets/Shared/video_player_dialog.dart';
import 'package:paakaar/Widgets/Shared/voice_player_dialog.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

import '../../main.dart';
import '../../main.dart';
import '../../main.dart';

class CompleteProfileScreen extends StatelessWidget {
  final bool isDirect;

  final CompleteProfileController controller = Get.put(
    CompleteProfileController(),
  );
  DashboardController dashi = Get.find();

  CompleteProfileScreen({
    Key? key,
    this.isDirect = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          controller.unFocus();
          controller.showSaveAlert();
          return false;
        },
        child: Scaffold(
          appBar: isDirect
              ? WidgetUtils.appBar(
                  innerPage: true,
                  key: scaffoldKey,
                  onTap: () async {
                    controller.unFocus();
                    controller.showSaveAlert();
                  })
              : AppBar(
                  toolbarHeight: 0.0,
                ),
          drawer: CustomDrawerWidget(),
          floatingActionButton: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return !isKeyboardVisible
                  ? GetBuilder(
                      init: controller,
                      builder: (ctx) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width / 12,
                          ),
                          FloatingActionButton.extended(
                            backgroundColor: ColorUtils.orange.shade900,
                            elevation: 4.0,
                            highlightElevation: 4.0,
                            focusElevation: 4.0,
                            hoverElevation: 4.0,
                            heroTag: 'tag1',
                            onPressed: () {
                              controller.unFocus();
                              // dashi.currentPage.value = 1;
                              // Get.dialog(
                              //   CompleteProfileDialog(),
                              //   barrierColor: Colors.black.withOpacity(0.5),
                              // );
                              // return;
                              Get.toNamed(
                                RoutingUtils.upgradePlan.name,
                              );
                            },
                            foregroundColor: Colors.white,
                            icon: const Icon(
                              Icons.upgrade,
                            ),
                            label: const Text(
                              "تهیه اشتراک",
                            ),
                          ),
                          const Spacer(),
                          (controller.tabControllerIndex! > 0)
                              ? const SizedBox()
                              : FloatingActionButton.extended(
                                  backgroundColor: ColorUtils.green.shade600,
                                  elevation: 4.0,
                                  highlightElevation: 4.0,
                                  focusElevation: 4.0,
                                  heroTag: 'tag2',
                                  hoverElevation: 4.0,
                                  onPressed: () {
                                    controller.unFocus();
                                    controller.save(
                                      fabAction: true,
                                    );
                                  },
                                  foregroundColor: Colors.white,
                                  icon: const Icon(
                                    Icons.save_outlined,
                                  ),
                                  label: const Text(
                                    "ذخیره",
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Container();
            },
          ),
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
    return Center(
      child: StreamBuilder(
        stream: Globals.userStream.getStream,
        builder: (context, snapshot) {
          UserModel user = Globals.userStream.user!;
          return DefaultTabController(
            length: user.role?.membershipId != 1 ? 3 : 1,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                leading: Container(),
                elevation: 0.0,
                toolbarHeight: 2.0,
                backgroundColor: Colors.white,
                bottom: TabBar(
                  onTap: (s) {
                    controller.unFocus();
                    controller.changeTab(s);
                  },
                  indicatorColor: ColorUtils.red,
                  indicatorWeight: 3.0,
                  labelColor: ColorUtils.mainRed,
                  tabs: [
                    const Tab(
                      child: Text(
                        "اطلاعات عمومی",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    if (user.role?.membershipId != 1) ...[
                      Tab(
                        child: const Text(
                          "تخصص ها",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        key: controller.keyBottomNavigation1,
                      ),
                      Tab(
                        child: const Text(
                          "نمونه کار ها",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        key: controller.keyBottomNavigation2,
                      ),
                    ],
                  ],
                ),
              ),
              body: buildTabs(),
            ),
          );
        },
      ),
    );
  }

  Widget buildImage() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return GestureDetector(
            onTap: () {
              controller.unFocus();
              controller.showModalBottomSheet();
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 10.0,
                      ),
                      boxShadow: ViewUtils.boxShadow(
                        spreadRadius: 12.0,
                        blurRadius: 12.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: StreamBuilder(
                      stream: Globals.userStream.getStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Globals.userStream.user!.isImageLocal == true
                              ? Image.file(
                                  File(
                                    Globals.userStream.user!.avatarFile!.path,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  Globals.userStream.user!.avatar == null
                                      ? RequestsUtil.baseRequestUrl +
                                          '/src/images/Individuals/avatar.jpg'
                                      : Globals.userStream.user!.avatar!,
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: Get.width / 2.5,
                  right: Get.width / 2.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: ViewUtils.boxShadow(),
                      shape: BoxShape.circle,
                    ),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(
                        Ionicons.camera_outline,
                        color: ColorUtils.mainRed,
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
              controller.unFocus();
              controller.showModalBottomSheet();
            },
            child: SizedBox(
              width: Get.width,
              height: Get.height * .23,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: Get.width * .3,
                      height: Get.width * .3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 5.0,
                        ),
                        boxShadow: ViewUtils.boxShadow(
                          spreadRadius: 12.0,
                          blurRadius: 12.0,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Globals.userStream.user!.isImageLocal == true
                            ? Image.file(
                                File(
                                  Globals.userStream.user!.avatarFile!.path,
                                ),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                Globals.userStream.user!.avatar == null
                                    ? RequestsUtil.baseRequestUrl +
                                        '/src/images/Individuals/avatar.jpg'
                                    : Globals.userStream.user!.avatar!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: ViewUtils.boxShadow(),
                        shape: BoxShape.circle,
                      ),
                      height: Get.width * .1,
                      width: Get.width * .1,
                      child: Center(
                        child: Icon(
                          Ionicons.camera_outline,
                          size: 18.0,
                          color: ColorUtils.mainRed,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildCapabilities() {
    return GetBuilder(
      init: controller,
      builder: (context) {
        return Container(
          height: ((Get.height / 24) + 24) +
              (controller.listOfSubSubGroups.length * ((Get.height / 24) + 18)),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorUtils.mainRed,
              width: 0.1,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 24,
                  child: Row(
                    children: [
                      const AutoSizeText(
                        "تخصص های من",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontSize: 16.0,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        // onTap: (){
                        // print(controller.listOfSubSubGroups);
                        // },
                        onTap: () {
                          if(Globals.userStream.user!.role!.isWorkerSpecialty!){
                            ViewUtils.showErrorDialog(
                              'با توجه به نوع اشتراک ، قادر به افزودن تخصص نیستید',
                            );
                          }else{
                            controller.unFocus();
                            controller.selectFieldsAndGroups();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: ViewUtils.boxShadow(
                              blurRadius: 12.0,
                              spreadRadius: 2.0,
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 37,
                          width: 37,
                          child: Center(
                            child: Icon(
                              Ionicons.add,
                              color: ColorUtils.mainRed,
                              size: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.listOfSubSubGroups.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Divider(
                      color: ColorUtils.mainRed,
                      thickness: 0.1,
                    ),
                  ),
                Expanded(
                  child: AnimationLimiter(
                    child: StreamBuilder(
                      stream: Globals.userStream.getStream,
                      builder: (c , r){
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Globals.userStream.user!.specialities!.length,
                          itemBuilder: buildField,
                          separatorBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Divider(
                                color: ColorUtils.mainRed.withOpacity(0.5),
                                thickness: 0.1,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFilters() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return GetBuilder(
              init: controller,
              builder: (context) {
                return Container(
                  height: ((Get.height / 24) + 24) +
                      (controller.listOfOptions
                              .where((element) => element.isSelected)
                              .length *
                          ((Get.height / 24) + 18)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorUtils.mainRed,
                      width: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "اطلاعات من",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.unFocus();
                                controller.selectPublicFilters();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: ViewUtils.boxShadow(
                                    blurRadius: 12.0,
                                    spreadRadius: 2.0,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                height: 37,
                                width: 37,
                                child: Center(
                                  child: Icon(
                                    Ionicons.add,
                                    color: ColorUtils.mainRed,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (controller.listOfOptions
                            .any((element) => element.isSelected))
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            child: Divider(
                              color: ColorUtils.mainRed,
                              thickness: 0.1,
                            ),
                          ),
                        Expanded(
                          child: AnimationLimiter(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listOfOptions
                                  .where((element) => element.isSelected)
                                  .length,
                              itemBuilder: buildOption,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Divider(
                                    color: ColorUtils.mainRed.withOpacity(0.5),
                                    thickness: 0.1,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else {
          return GetBuilder(
            init: controller,
            builder: (context) {
              return Container(
                height: ((Get.height * .08) + 24) +
                    (controller.listOfOptions
                            .where((element) => element.isSelected)
                            .length *
                        ((Get.height / 24) + 18)),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorUtils.mainRed,
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "اطلاعات من",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              controller.unFocus();
                              controller.selectPublicFilters();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: ViewUtils.boxShadow(
                                  blurRadius: 12.0,
                                  spreadRadius: 2.0,
                                ),
                                shape: BoxShape.circle,
                              ),
                              height: 37,
                              width: 37,
                              child: Center(
                                child: Icon(
                                  Ionicons.add,
                                  color: ColorUtils.mainRed,
                                  size: 22.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (controller.listOfOptions
                          .any((element) => element.isSelected))
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Divider(
                            color: ColorUtils.mainRed,
                            thickness: 0.1,
                          ),
                        ),
                      Expanded(
                        child: AnimationLimiter(
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.listOfOptions
                                .where((element) => element.isSelected)
                                .length,
                            itemBuilder: buildOption,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Divider(
                                  color: ColorUtils.mainRed.withOpacity(0.5),
                                  thickness: 0.1,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget buildPortfolio() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 300.0) {
          return GetBuilder(
            init: controller,
            builder: (context) {
              return Container(
                height: (Get.height / 24) +
                    24 +
                    (controller.listOfCvFiles.isNotEmpty
                        ? Get.height / 8 +
                            ((controller.listOfCvFiles.length / 3) *
                                Get.height /
                                5.5)
                        : 0.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorUtils.mainRed,
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "نمونه کار های من",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          GetBuilder(
                            init: controller,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () => controller.isDeleting
                                    ? {
                                        controller.isDeleting = false,
                                        controller.update(),
                                        controller.unFocus(),
                                      }
                                    : controller.addCvFile(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: ViewUtils.boxShadow(
                                      blurRadius: 12.0,
                                      spreadRadius: 2.0,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  height: 37,
                                  width: 25,
                                  child: Center(
                                    child: Icon(
                                      controller.isDeleting
                                          ? Ionicons.close_outline
                                          : Ionicons.add,
                                      color: ColorUtils.mainRed,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      if (controller.listOfCvFiles.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Divider(
                            color: ColorUtils.mainRed,
                            thickness: 0.1,
                          ),
                        ),
                      Expanded(
                        child: AnimationLimiter(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: Get.height / 6,
                            ),
                            itemCount: controller.listOfCvFiles.length,
                            itemBuilder: buildCvFileItem,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return GetBuilder(
            init: controller,
            builder: (context) {
              return Container(
                height: (Get.height * .08) +
                    24 +
                    (controller.listOfCvFiles.isNotEmpty
                        ? Get.height / 8 +
                            ((controller.listOfCvFiles.length / 3) *
                                Get.height /
                                5.5)
                        : 0.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorUtils.mainRed,
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "نمونه کار های من",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          GetBuilder(
                              init: controller,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => controller.isDeleting
                                      ? {
                                          controller.isDeleting = false,
                                          controller.update(),
                                          controller.unFocus(),
                                        }
                                      : controller.addCvFile(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: ViewUtils.boxShadow(
                                        blurRadius: 12.0,
                                        spreadRadius: 2.0,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    height: 37,
                                    width: 25,
                                    child: Center(
                                      child: Icon(
                                        controller.isDeleting
                                            ? Ionicons.close_outline
                                            : Ionicons.add,
                                        color: ColorUtils.mainRed,
                                        size: 22.0,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                      if (controller.listOfCvFiles.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Divider(
                            color: ColorUtils.mainRed,
                            thickness: 0.1,
                          ),
                        ),
                      Expanded(
                        child: AnimationLimiter(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: Get.height / 6,
                            ),
                            itemCount: controller.listOfCvFiles.length,
                            itemBuilder: buildCvFileItem,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void previewItem(CustomFileModel item) {
    print(item.url);
    print(item.file);
    String? cvItem;
    String? ext;

    if (item.url is String) {
      cvItem = item.url;
      ext = cvItem!.split('.').last;
    } else {
      cvItem = item.file!.path;
      ext = cvItem.split('.').last;
    }
    switch (ext) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return preViewImage(item);
      case 'mp4':
      case 'mov':
      case 'mkv':
      case 'flv':
      case 'mpeg':
        return preViewVideo(item);
      case '3gp':
      case 'aa':
      case 'ra':
      case 'ogg':
      case 'aac':
      case 'mp3':
      case 'waw':
      case 'm4a':
      case 'wma':
        return preViewAudio(item);
      case 'pdf':
      case 'doc':
      case 'docm':
      case 'docx':
      case 'html':
      case 'htm':
      case 'rtf':
      case 'txt':
      case 'xml':
      case 'xps':
      case 'csv':
      case 'xltx':
      case 'xlsx':
      case 'xls':
      default:
        return download(item);
    }
  }

  void download(CustomFileModel cvItem) async {
    var dio = Dio();
    if (cvItem.url is String) {
      download2(dio, cvItem.url!, cvItem.name);
    } else {
      ViewUtils.showErrorDialog(
        'برای دانلود فایل مورد نظر ایتدا تغییرات پروفایل را ثبت و از صفحه ویرایش پروفایل خارج شده و دوباره امتحان کنید.',
      );
    }
  }

  Future download2(Dio dio, String url, String fileName) async {
    Permission.storage.status.then(
      (value) async {
        if (!value.isGranted) {
          Permission.storage.request().then(
            (value) {
              download2(
                dio,
                url,
                fileName,
              );
            },
          );
        } else {
          EasyLoading.show(
            status: 'درحال دانلود فایل لطفا صبر کنید',
          );
          try {
            dio
                .get(
              url,
              onReceiveProgress: showDownloadProgress,
              //Received data with List<int>
              options: Options(
                  responseType: ResponseType.bytes,
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  }),
            )
                .then(
              (value) async {
                Directory dir = Directory('/storage/emulated/0/Download');
                File file =
                    File("${dir.path}/$fileName.${url.split('.').last}");
                var raf = file.openSync(mode: FileMode.write);
                // value.data is List<int> type
                raf.writeFromSync(value.data);
                await raf.close();
                EasyLoading.dismiss();
                ViewUtils.showSuccessDialog(
                  'با موفقیت دانلود شد',
                );
              },
            );
          } catch (e) {
            print(e);
          }
        }
      },
    );
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  void preViewImage(CustomFileModel cvItem) {
    Get.dialog(
      ImagePreviewDialog(
        file: cvItem,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void preViewAudio(CustomFileModel cvItem) {
    Get.dialog(
      VoicePlayerDialog(
        file: cvItem,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void preViewVideo(CustomFileModel cvItem) {
    Get.dialog(
      VideoPlayerDialog(
        file: cvItem,
        fromDashboard: false,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  Widget buildField(BuildContext context, int index) {
    // FieldModel field = controller.listOfSubSubGroups[index];
    FieldModel field = Globals.userStream.user!.specialities![index];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: Get.height / 24,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {

              if(Globals.userStream.user!.role!.isWorkerSpecialty!){
                ViewUtils.showErrorDialog(
                  'با توجه به نوع اشتراک ، قادر به تغییر تخصص خود نمی باشید',
                );
              }else{
                bool canDelete = await GetConfirmationDialog.show(
                  text: "شما در حال حذف این حرفه از لیست تخصص های خود هستید.",
                );
                if (canDelete == true) {
                  controller.listOfSubSubGroups.remove(field);
                  controller.update();
                  controller.unFocus();
                }
              }

            },
            child: Icon(
              Ionicons.close,
              color: ColorUtils.mainRed.shade200,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            field.name,
            style: const TextStyle(
              color: ColorUtils.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCvFileItem(BuildContext context, int index) {
    CustomFileModel file = controller.listOfCvFiles[index];
    return GestureDetector(
      onTap: () => previewItem(
        file,
      ),
      child: AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          verticalOffset: index * 25.0,
          child: FadeInAnimation(
            child: GestureDetector(
              child: Container(
                width: Get.height / 12,
                height: Get.height / 12,
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: ViewUtils.boxShadow(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: Get.height * .04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: AutoSizeText(
                                  file.name,
                                  maxFontSize: 16.0,
                                  minFontSize: 12.0,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                controller.unFocus();

                                bool? isConfirmed =
                                    await GetConfirmationDialog.show(
                                  text: "آیا از حذف این فایل مطمین هستید؟",
                                );
                                if (isConfirmed == true) {
                                  controller.deleteFile(file: file);
                                  controller.save(fabAction: false);
                                  controller.update();
                                }
                              },
                              child: Container(
                                width: Get.height / 25,
                                height: Get.height / 25,
                                child: Center(
                                  child: Icon(
                                    Ionicons.trash_outline,
                                    size: Get.height / 50,
                                    color: ColorUtils.red,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  boxShadow: ViewUtils.boxShadow(
                                    blurRadius: 12.0,
                                    spreadRadius: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FilePreview(
                              file: file,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSocialMedias() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return Obx(
            () => Container(
              height: Get.height / 10 +
                  ((controller.isSocialMediaLoaded.isTrue
                              ? controller.listOfSocialMedias.length
                              : 0) *
                          (Get.height / 18) +
                      8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorUtils.mainRed,
                  width: 0.1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          height: 37,
                          child: Center(
                            child: Text(
                              "راه های ارتباطی",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Divider(
                        color: ColorUtils.mainRed,
                        thickness: 0.1,
                      ),
                    ),
                    Expanded(
                      child: controller.isSocialMediaLoaded.isTrue
                          ? GetBuilder(
                              init: controller,
                              builder: (context) {
                                return AnimationLimiter(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        controller.listOfSocialMedias.length,
                                    itemBuilder: buildSocialMedia,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: WidgetUtils.loadingWidget(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Obx(
            () => Container(
              height: Get.height * .15 +
                  ((controller.isSocialMediaLoaded.isTrue
                              ? controller.listOfSocialMedias.length
                              : 0) *
                          (Get.height / 18) +
                      8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorUtils.mainRed,
                  width: 0.1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    width: double.maxFinite,
                    height: 37,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AutoSizeText(
                        "راه های ارتباطی",
                        maxLines: 1,
                        maxFontSize: 14.0,
                        minFontSize: 10.0,
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Divider(
                      color: ColorUtils.mainRed,
                      thickness: 0.1,
                    ),
                  ),
                  Expanded(
                    child: controller.isSocialMediaLoaded.isTrue
                        ? GetBuilder(
                            init: controller,
                            builder: (context) {
                              return AnimationLimiter(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.listOfSocialMedias.length,
                                  itemBuilder: buildSocialMedia,
                                ),
                              );
                            },
                          )
                        : Center(
                            child: WidgetUtils.loadingWidget(),
                          ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildSocialMedia(BuildContext context, int index) {
    SocialMediaModel socialMedia = controller.listOfSocialMedias[index];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return GestureDetector(
            onTap: () async {
              controller.unFocus();
              if (socialMedia.id == 6 &&
                  Globals.userStream.user!.isMobileShown) {
                controller.setAddressForSocialMedia(socialMedia);
              } else {
                ViewUtils.showErrorDialog(
                  'برای ثبت شماره واستاپ ابتدا باید اجازه نمایش شماره برای عموم صادر شود',
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              height: Get.height / 18,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: Get.width / 6,
                    height: Get.width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          socialMedia.icon,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Center(
                        child: AutoSizeText(
                          socialMedia.isAddressSet
                              ? socialMedia.address!
                              : socialMedia.name,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: ColorUtils.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: socialMedia.isAddressSet
                            ? ColorUtils.green.shade600
                            : ColorUtils.mainRed.shade800,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 30,
                    height: 30,
                    child: Icon(
                      socialMedia.isAddressSet ? Icons.edit : Icons.edit,
                      size: 15.0,
                      color: socialMedia.isAddressSet
                          ? ColorUtils.green.shade800
                          : ColorUtils.mainRed.shade200,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () async {
              controller.unFocus();
              if (socialMedia.id == 6) {
                if (controller.showMobile) {
                  controller.setAddressForSocialMedia(socialMedia);
                } else {
                  ViewUtils.showErrorDialog(
                    'برای ثبت شماره واستاپ ابتدا باید اجازه نمایش شماره برای عموم صادر شود',
                  );
                }
              } else {
                controller.setAddressForSocialMedia(socialMedia);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              height: Get.height / 18,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: Get.width / 6,
                    height: Get.width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        socialMedia.icon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Center(
                        child: AutoSizeText(
                          socialMedia.isAddressSet
                              ? socialMedia.address!
                              : socialMedia.name,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: ColorUtils.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: socialMedia.isAddressSet
                            ? ColorUtils.green.shade600
                            : ColorUtils.mainRed.shade800,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 30,
                    height: 30,
                    child: Icon(
                      socialMedia.isAddressSet ? Icons.edit : Icons.edit,
                      size: 15.0,
                      color: socialMedia.isAddressSet
                          ? ColorUtils.green.shade800
                          : ColorUtils.mainRed.shade200,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildBio() {
    return AnimatedContainer(
      height: (controller.bioTextController.text.length > 150)
          ? Get.height * .4
          : Get.height / 4,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorUtils.mainRed,
          width: 0.1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      duration: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(
                  height: 37,
                  child: Center(
                    child: Text(
                      "بیوگرافی",
                      style: TextStyle(
                        color: ColorUtils.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Divider(
                color: ColorUtils.mainRed,
                thickness: 0.1,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller.bioTextController,
                maxLines: 10,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget genderSelect() {
    return GetBuilder(
      init: controller,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.unFocus();
                    controller.selectGender(2);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: controller.gender == 2
                          ? ViewUtils.boxShadow(
                              blurRadius: 12.0,
                              spreadRadius: 2.0,
                            )
                          : ViewUtils.boxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                            ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "خانم",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: controller.gender == 2
                              ? ColorUtils.mainRed
                              : ColorUtils.inActiveTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width / 18,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.unFocus();
                    controller.selectGender(1);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: controller.gender == 1
                          ? ViewUtils.boxShadow(
                              blurRadius: 12.0,
                              spreadRadius: 2.0,
                            )
                          : ViewUtils.boxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                            ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "آقا",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: controller.gender == 1
                              ? ColorUtils.mainRed
                              : ColorUtils.inActiveTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPersonalInfo() {
    return Column(
      children: [
        name(),
        ViewUtils.sizedBox(),
        lastName(),
        ViewUtils.sizedBox(),
        // password(),
        // ViewUtils.sizedBox(),
        // genderSelect(),
        ViewUtils.sizedBox(),
        buildShowMobile(),
        ViewUtils.sizedBox(),
        buildMoarefiCode()
      ],
    );
  }

  Widget _textInput({
    required TextEditingController controller,
    required String name,
    void Function(String)? onChange,
    required FocusNode focusNode,
    bool onlyEnglish = false,
    bool enabled = true,
    int maxLen = 9999,
    TextAlign align = TextAlign.right,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        textAlign: align,
        controller: controller,
        onChanged: onChange,
        focusNode: focusNode,
        enabled: enabled,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          LengthLimitingTextInputFormatter(
            maxLen,
          ),
          if (onlyEnglish)
            FilteringTextInputFormatter.allow(
              RegExp(
                "[A-Za-z0-9!\"#\$%&'()*+,-./:;<=>?@[\\]^_`{|}~]",
              ),
            ),
        ],
        style: TextStyle(
          color: ColorUtils.textColor,
        ),
        cursorColor: ColorUtils.mainRed,
        decoration: InputDecoration(
          labelText: name,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorUtils.mainRed,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorUtils.textColor,
            ),
          ),
          labelStyle: TextStyle(
            color: ColorUtils.textColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget name() {
    return _textInput(
      controller: controller.nameController,
      focusNode: controller.nameFocusNode,
      name: "نام",
      enabled: true,
    );
  }

  Widget lastName() {
    return _textInput(
      enabled: true,
      controller: controller.lastNameController,
      focusNode: controller.lastNameFocusNode,
      name: "نام خانوادگی",
    );
  }

  Widget password() {
    return _textInput(
      controller: controller.passwordTextController,
      focusNode: controller.passwordFocusNode,
      name: "رمز عبور دلخواه شما",
    );
  }

  Widget buildCityAndState() {
    return Obx(
      () => controller.isStatesLoaded.isTrue
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: WidgetUtils.selectOptions(
                        title: "انتخاب استان",
                        unFocus: controller.unFocus,
                        controller: controller,
                        items: controller.listOfStates,
                        isActive: (elem) => elem.isSelected,
                        displayFormat: displayStates,
                        makeActive: controller.makeStateActive,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: GetBuilder(
                        init: controller,
                        builder: (ctx) => WidgetUtils.selectOptions(
                          title: "انتخاب شهر",
                          unFocus: controller.unFocus,
                          controller: controller,
                          enabled: controller.listOfStates
                              .any((element) => element.isSelected),
                          errorMessage: "لطفا ابتدا استان را انتخاب کنید",
                          items: controller.listOfStates
                                  .any((element) => element.isSelected)
                              ? controller.listOfStates
                                  .singleWhere((element) => element.isSelected)
                                  .listOfCities
                              : [],
                          isActive: (elem) => elem.isSelected,
                          displayFormat: displayCity,
                          makeActive: controller.makeCityActive,
                        ),
                      ),
                    ),
                  ],
                ),
                GetBuilder(
                  init: controller,
                  builder: (ctx) {
                    if (controller.listOfDistricts.isNotEmpty) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: WidgetUtils.selectOptions(
                                  title: "انتخاب محدوده",
                                  unFocus: controller.unFocus,
                                  controller: controller,
                                  items: controller.listOfDistricts,
                                  isActive: (elem) => elem.isSelected,
                                  displayFormat: displayDistrict,
                                  makeActive: controller.makeDistrictActive,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            )
          : WidgetUtils.loadingWidget(),
    );
  }

  String displayStates(p1) {
    return p1.name;
  }

  String displayCity(p1) {
    return p1.name;
  }

  String displayDistrict(p1) {
    return p1.name;
  }

  Widget buildOption(BuildContext context, int index) {
    OptionModel option = controller.listOfOptions
        .where((element) => element.isSelected)
        .toList()[index];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: Get.height / 24,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              controller.unFocus();

              bool canDelete = await GetConfirmationDialog.show(
                text: "شما در حال حذف این حرفه از لیست تخصص های خود هستید.",
              );
              if (canDelete == true) {
                option.values.forEach((element) {
                  element.isSelected.value = false;
                });
                controller.update();
              }
            },
            child: Icon(
              Ionicons.close,
              color: ColorUtils.mainRed.shade200,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            option.name + ": ",
            style: TextStyle(
              color: ColorUtils.textColor,
              fontSize: 12.0,
            ),
          ),
          Text(
            option.values
                .singleWhere((element) => element.isSelected.value)
                .name,
            style: const TextStyle(
              color: ColorUtils.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabs() {
    return TabBarView(
      children: [
        generalInfo(),
        if (Globals.userStream.user?.role?.membershipId != 1) ...[
          filters(),
          portfolio(),
        ],
      ],
    );
  }

  Widget generalInfo() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 300.0) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ViewUtils.sizedBox(25),
                buildImage(),
                // ViewUtils.sizedBox(12.5),
                buildPersonalInfo(),
                ViewUtils.sizedBox(25),
                (Globals.userStream.user?.role?.membershipId == 1)
                    ? SizedBox(
                        height: Get.height * .1,
                      )
                    : Container(),
                if (Globals.userStream.user?.role?.membershipId != 1) ...[
                  buildCityAndState(),
                  ViewUtils.sizedBox(25),
                  buildSocialMedias(),
                  ViewUtils.sizedBox(25),
                  buildBio(),
                  ViewUtils.sizedBox(25),
                  buildCv(),
                  ViewUtils.sizedBox(7),
                ],
                ViewUtils.sizedBox(25),
                // WidgetUtils.button(
                //   text: "ذخیره سازی",
                //   onTap: () => controller.save(),
                // ),
                // ViewUtils.sizedBox(5),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                ViewUtils.sizedBox(25),
                buildImage(),
                // ViewUtils.sizedBox(12.5),
                buildPersonalInfo(),
                ViewUtils.sizedBox(25),
                (Globals.userStream.user?.role?.membershipId == 1)
                    ? SizedBox(
                        height: Get.height * .1,
                      )
                    : Container(),
                if (Globals.userStream.user?.role?.membershipId != 1) ...[
                  buildCityAndState(),
                  ViewUtils.sizedBox(25),
                  buildSocialMedias(),
                  ViewUtils.sizedBox(25),
                  buildBio(),
                  ViewUtils.sizedBox(25),
                  buildCv(),
                  ViewUtils.sizedBox(7),
                ],
                ViewUtils.sizedBox(25),
                // WidgetUtils.button(
                //   text: "ذخیره سازی",
                //   onTap: () => controller.save(),
                // ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget portfolio() {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (Globals.userStream.user?.role?.membershipId != 1) ...[
            ViewUtils.sizedBox(25),
            buildPortfolio(),
            ViewUtils.sizedBox(7),
          ],
          ViewUtils.sizedBox(5),
        ],
      ),
    );
  }

  Widget filters() {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (Globals.userStream.user?.role?.membershipId != 1) ...[
            ViewUtils.sizedBox(25),
            buildCapabilities(),
            ViewUtils.sizedBox(25),
            buildFilters(),
            ViewUtils.sizedBox(7),
          ],
          ViewUtils.sizedBox(5),
        ],
      ),
    );
  }

  Widget buildCv() {
    return AnimatedContainer(
      height: (controller.bioTextController.text.length > 150)
          ? Get.height * .4
          : Get.height / 4,
      duration: const Duration(
        milliseconds: 200,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorUtils.mainRed,
          width: 0.1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(
                  height: 37,
                  child: Center(
                    child: Text(
                      "رزومه",
                      style: TextStyle(
                        color: ColorUtils.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Divider(
                color: ColorUtils.mainRed,
                thickness: 0.1,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller.cvTextController,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShowMobile() {
    return GetBuilder(
      init: controller,
      builder: (context) {
        return Row(
          children: [
            Switch(
              activeColor: Colors.green,
              value: controller.showMobile,
              onChanged: (bool showMobile) {
                controller.showMobile = showMobile;
                controller.update();
                controller.unFocus();
              },
            ),
            const Text(
              "نمایش شماره موبایل برای عموم",
              style: TextStyle(
                color: ColorUtils.black,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildMoarefiCode() {
    return SizedBox(
      width: Get.width,
      height: Get.height * .05,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Row(
                children: [
                  const Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          'کد معرفی شما: ',
                          maxLines: 1,
                          maxFontSize: 12.0,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          Globals.userStream.user!.mobile.toString(),
                          maxFontSize: 18.0,
                          maxLines: 1,
                          minFontSize: 12.0,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: ColorUtils.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Share.share(
                      Globals.userStream.user!.mobile.toString(),
                    );
                  },
                  icon: Icon(
                    Icons.share,
                    color: ColorUtils.myRed,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
