import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share/share.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/Notification/View/notification_modal_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class DropDownDialog extends StatelessWidget {
  final List<dynamic> items;
  final bool Function(dynamic) isActive;
  final Function(dynamic) displayFormat;
  final void Function(dynamic) makeActive;
  final GetxController controller;
  final TextEditingController searchController = TextEditingController();
  final String title;

  DropDownDialog({
    Key? key,
    required this.items,
    required this.isActive,
    required this.displayFormat,
    required this.title,
    required this.makeActive,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: Get.width / 1.1,
          height: Get.height * .6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
          child: Column(
            children: [
              header(),
              ViewUtils.sizedBox(),
              WidgetUtils.textField(
                title: "جست و جو...",
                onChanged: (String str) {
                  controller.refresh();
                },
                controller: searchController,
              ),
              ViewUtils.sizedBox(),
              Expanded(
                child: GetBuilder(
                  init: controller,
                  builder: (_) => ListView.separated(
                    separatorBuilder: (_, int index) => Divider(
                      color: ColorUtils.green,
                    ),
                    itemBuilder: buildItem,
                    itemCount: items.where((element) {
                      var display = displayFormat(element);
                      if (display is String) {
                        return display.contains(searchController.text);
                      } else if (display is Text) {
                        return display.data?.contains(searchController.text) ==
                            true;
                      }
                      return true;
                    }).length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            WidgetUtils.closeButton(),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    List items = this.items.where((element) {
      var display = displayFormat(element);
      if (display is String) {
        return display.contains(searchController.text);
      } else if (display is Text) {
        return display.data?.contains(searchController.text) == true;
      }
      return true;
    }).toList();
    bool isActive = this.isActive(items[index]);
    var display = displayFormat(items[index]);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          makeActive(items[index]);
          Future.delayed(const Duration(milliseconds: 250), () {
            Get.close(1);
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          width: Get.width,
          height: Get.height * .07,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 175),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? ColorUtils.green
                      : ColorUtils.shadowColor.withOpacity(0.15),
                ),
                child: isActive
                    ? Center(
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: Get.width / 24,
                        ),
                      )
                    : Container(),
                width: Get.width / 18,
                height: Get.width / 18,
              ),
              const SizedBox(
                width: 8.0,
              ),
              displayFormat(items[index]) is Widget
                  ? display
                  : Expanded(
                    child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                            display,
                maxLines: 2,
                maxFontSize: 16.0,
                minFontSize: 12.0,
                style: const TextStyle(
                        fontSize: 14.0,
                ),
                          ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetUtils {
  static selectOptions({
    required String title,
    required GetxController controller,
    dynamic value,
    required List<dynamic> items,
    required bool Function(dynamic) isActive,
    required Function(dynamic) displayFormat,
    Function? unFocus,
    required void Function(dynamic) makeActive,
    Color? backgroundColor,
    bool enabled = true,
    String errorMessage = "",
  }) {
    backgroundColor ??= ColorUtils.shadowColor;

    var display = items.any(isActive)
        ? displayFormat(items.singleWhere(isActive))
        : title;
    return GestureDetector(
      onTap: () {
        if (unFocus != null) unFocus();
        if (enabled) {
          Future.delayed(const Duration(milliseconds: 176), () {
            Get.dialog(
              DropDownDialog(
                title: title,
                controller: controller,
                items: items,
                makeActive: makeActive,
                isActive: isActive,
                displayFormat: displayFormat,
              ),
              barrierColor: Colors.black54,
              barrierDismissible: false,
            );
          });
        } else {
          ViewUtils.showErrorDialog(errorMessage);
        }
      },
      child: Container(
        height: Get.height / 22,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            display is String
                ? Text(
                    display,
                  )
                : display,
            Icon(
              Icons.arrow_drop_down,
              color: ColorUtils.green.shade600,
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
        ),
      ),
    );
  }

  static Widget mainSearchTextField({
    void Function(String string)? onChange,
    TextEditingController? controller,
  }) {
    return WidgetUtils.textField(
      title: ' جست و جو بر اساس نام ..',
      onChanged: onChange,
      controller: controller,
    );
  }

  static Widget neuSearchField({
    void Function(String string)? onChange,
    TextEditingController? controller,
  }) {
    return WidgetUtils.neuTextField(
      title: ' جست و جو ..',
      onChange: onChange,
      textAlign: TextAlign.center,
      controller: controller,
    );
  }

  static Widget singlePageTextField({
    required void Function(String string) onChange,
  }) {
    return WidgetUtils.textField(
      title: ' جست و جو',
      backgroundColor: ColorUtils.shadowColor,
      onChanged: onChange,
      borderColor: Colors.transparent,
    );
  }

  static separator([double thickness = 1.0]) {
    return Divider(
      color: ColorUtils.green,
      thickness: thickness,
    );
  }

  static neuButton({
    String? text,
    void Function()? onTap,
    bool enabled = false,
    double enabledBevel = 10,
    CurveType activeCurveType = CurveType.concave,
    Color textColor = Colors.white,
    double fontSize = 14.0,
    Widget? smallText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 175),
        height: Get.height / 21,
        // decoration: MyNeumorphicDecoration(
        //   borderRadius: BorderRadius.circular(10.0),
        //   color: ColorUtils.black,
        // ),
        decoration: BoxDecoration(
          color: enabled
              ? ColorUtils.green.shade600
              : ColorUtils.green.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              text,
              maxLines: 1,
              style: TextStyle(
                color: enabled ? textColor : Colors.white.withOpacity(0.8),
                fontSize: fontSize,
              ),
            ),
            if (smallText is Widget) ...[
              const SizedBox(
                width: 8.0,
              ),
              smallText
            ],
          ],
        ),
        // curveType: enabled ? activeCurveType : CurveType.flat,
        // bevel: enabled ? enabledBevel : 5.0,
      ),
    );
  }

  static textField({
    String title = '',
    IconData? icon,
    TextEditingController? controller,
    TextAlign textAlign = TextAlign.right,
    TextInputType keyboardType = TextInputType.text,
    void Function(String string)? onChanged,
    FocusNode? focusNode,
    List<TextInputFormatter> formatter = const [],
    double letterSpacing = 1.5,
    bool enabled = true,
    bool? valid,
    bool price = false,
    bool percent = false,
    Color? backgroundColor,
    double heightFactor = 21,
    Color? borderColor,
    bool toman = false,
  }) {
    controller ??= TextEditingController();
    backgroundColor ??= ColorUtils.textFieldBackground;
    return Container(
      height: Get.height / heightFactor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: price ? TextInputType.number : keyboardType,
              controller: controller,
              enabled: enabled,
              textAlignVertical: TextAlignVertical.bottom,
              style: TextStyle(
                color: enabled ? Colors.black : Colors.grey,
              ),
              inputFormatters: [
                if (percent) LengthLimitingTextInputFormatter(3),
                if (percent || price) FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (String str) {
                if (price) {
                  double value = double.parse(str.replaceAll(',', '').trim());
                  controller!.text = ViewUtils.moneyFormat(value);
                  controller.selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: controller.text.length,
                    ),
                  );
                }
                if (percent) {
                  double value;
                  try {
                    value = double.parse(str);
                  } catch (e) {
                    value = 0;
                  }
                  if (value > 100) {
                    controller!.text = '100';
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: controller.text.length,
                      ),
                    );
                  }
                }
                if (onChanged != null) onChanged(str);
              },
              decoration: InputDecoration(
                hintText: title,
                hintMaxLines: 1,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: borderColor is Color
                        ? borderColor
                        : valid == true
                            ? ColorUtils.green
                            : valid is bool
                                ? ColorUtils.red
                                : Colors.orange.withOpacity(0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: borderColor is Color
                        ? borderColor
                        : valid == true
                            ? ColorUtils.orange
                            : valid is bool
                                ? ColorUtils.red
                                : Colors.grey.withOpacity(0.2),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: borderColor is Color
                        ? borderColor
                        : valid == true
                            ? ColorUtils.orange
                            : valid is bool
                                ? ColorUtils.red
                                : Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),
          if (toman)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Text(
                "تومان",
              ),
            ),
        ],
      ),
    );
  }

  static neuTextField({
    String title = '',
    IconData? icon,
    TextEditingController? controller,
    TextAlign textAlign = TextAlign.right,
    TextInputType keyboardType = TextInputType.text,
    void Function(String string)? onChange,
    FocusNode? focusNode,
    List<LengthLimitingTextInputFormatter> formatter = const [],
    double letterSpacing = 1.5,
    bool enabled = true,
    bool price = false,
  }) {
    return Container(
      height: Get.height / 21,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: TextFormField(
        cursorColor: ColorUtils.mainRed,
        controller: controller,
        onChanged: (String str) {
          if (price) {
            try {
              double value = double.parse(str.replaceAll(',', '').trim());
              controller?.text = ViewUtils.moneyFormat(value);
              controller?.selection = TextSelection.fromPosition(
                TextPosition(
                  offset: controller.text.length,
                ),
              );
            } catch (e) {}
          }
          if (onChange != null) onChange(str);
        },
        enabled: enabled,
        textAlign: textAlign,
        inputFormatters: formatter,
        focusNode: focusNode,
        keyboardType: keyboardType,
        style: TextStyle(
          letterSpacing: letterSpacing,
          color: ColorUtils.textColor,
        ),
        decoration: InputDecoration(
          fillColor: ColorUtils.textFieldBackground,
          focusColor: ColorUtils.mainRed,
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: ColorUtils.black.withOpacity(0.4),
              width: 0.8,
            ),
          ),
          contentPadding: const EdgeInsets.all(8.0),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: ColorUtils.mainRed.withOpacity(0.4),
              width: 0.8,
            ),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: ColorUtils.textColor,
          ),
          hintText: title,
        ),
      ),
    );
  }

  static Widget buildBottomNavIcon(IconData iconData) => Icon(
        iconData,
        color: ColorUtils.green,
        size: 21,
      );

  static Widget buildInActiveBottomNavIcon(IconData iconData) => Icon(
        iconData,
        color: ColorUtils.textColor,
        size: 21,
      );

  static button({
    Color? textColor,
    bool enabled = true,
    String text = 'تایید',
    void Function()? onTap,
    bool outline = false,
  }) {
    textColor ??= Colors.white;
    if (outline) textColor = ColorUtils.textColor;
    return Container(
      height: Get.height / 22,
      decoration: BoxDecoration(
        gradient: !outline && enabled
            ? LinearGradient(
                colors: [
                  ColorUtils.mainRed.withOpacity(0.9),
                  ColorUtils.mainRed,
                ],
              )
            : null,
        color: outline
            ? Colors.white
            : enabled
                ? null
                : ColorUtils.mainRed.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10.0),
        border: outline
            ? Border.all(
                color: ColorUtils.black.withOpacity(0.3),
                width: 0.7,
              )
            : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: enabled ? onTap : null,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget blurWidget({
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: child,
      ),
    );
  }

  static singlePageAppBar({
    required dynamic icon,
    bool isIconAsset = false,
    required String? text,
    bool changeColor = false,
  }) {
    return NeumorphicContainer(
      height: Get.height / 7,
      width: Get.width,
      bevel: 4,
      decoration: const MyNeumorphicDecoration(
        color: ColorUtils.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: Get.width - Get.height / 16,
            top: Get.height / 11,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: NeumorphicIcon(
                Ionicons.arrow_back,
                size: 30,
                curve: Curves.bounceIn,
                style: NeumorphicStyle(
                  depth: 1.0,
                  color: ColorUtils.green,
                ),
              ),
            ),
          ),
          Positioned(
            right: Get.height / 24,
            bottom: -Get.height / 24,
            child: NeumorphicContainer(
              height: Get.height / 8,
              width: Get.height / 8,
              decoration: const MyNeumorphicDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              curveType: CurveType.concave,
              bevel: 12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isIconAsset
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SvgPicture.asset(
                            icon,
                            width: Get.width / 13,
                            height: Get.width / 13,
                            fit: BoxFit.cover,
                            color: changeColor
                                ? ColorUtils.green.withOpacity(0.6)
                                : null,
                          ),
                        )
                      : icon is IconData
                          ? NeumorphicIcon(
                              icon,
                              size: Get.width / 13,
                              style: NeumorphicStyle(
                                intensity: 0.2,
                                color: ColorUtils.green.withOpacity(0.6),
                              ),
                            )
                          : icon is String
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    icon,
                                    width: Get.width / 13,
                                    height: Get.width / 13,
                                    fit: BoxFit.cover,
                                    color: changeColor
                                        ? ColorUtils.green.withOpacity(0.6)
                                        : null,
                                  ),
                                )
                              : Container(),
                  Container(
                    width: Get.height / 8,
                    child: AutoSizeText(
                      text,
                      maxLines: 1,
                      minFontSize: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static dataNotFound(String s) {
    return Center(
      child: Text("هیچ $s یافت نشد"),
    );
  }

  static Widget closeButton([Color? color]) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(Get.context!);
      },
      child: Icon(
        Ionicons.close,
        color: color ?? ColorUtils.black,
      ),
    );
  }

  static appBar({
    bool innerPage = false,
    GlobalKey<ScaffoldState>? key,
    VoidCallback? onTap,
  }) {
    return AppBar(
      backgroundColor: ColorUtils.mainRed.shade900,
      actions: [
        if (!innerPage) ...[
          IconButton(
            onPressed: () {
              Share.share('تیتراژ\nhttps://titraj.negaapps.ir');
            },
            icon: const Icon(
              Ionicons.share_social_outline,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              if (innerPage) {
                Get.back();
              } else {
                Get.toNamed(
                  RoutingUtils.myBookmarks.name,
                  arguments: {},
                );
              }
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
                  if (innerPage) {
                    if (onTap is VoidCallback) {
                      onTap();
                    } else {
                      Get.back();
                    }
                  } else {
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
                  }
                },
                icon: Icon(
                  innerPage ? Ionicons.arrow_back : FeatherIcons.bell,
                  color: Colors.white,
                ),
              ),
            ),
            if (!innerPage)
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
          "تـــیـــتـــراژ",
          style: TextStyle(
            letterSpacing: 5.0,
            color: Colors.white,
          ),
        ),
      ),
      leading: innerPage ? Container() : IconButton(
        onPressed: () {
          print(innerPage);
          if (!innerPage) {
            if (key?.currentState?.isDrawerOpen != true) {
              key?.currentState?.openDrawer();
            } else {
              key?.currentState?.openEndDrawer();
            }
          }
        },
        icon: const Icon(
          FeatherIcons.menu,
          color: Colors.white,
        ),
      ),
    );
  }
}
