import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class GetMobileDialog extends StatefulWidget {
  const GetMobileDialog({Key? key}) : super(key: key);

  @override
  _GetMobileDialogState createState() => _GetMobileDialogState();

  static show() async {
    return await Get.dialog(
      const GetMobileDialog(),
      barrierDismissible: false,
    );
  }
}

class _GetMobileDialogState extends State<GetMobileDialog> {
  bool get isOk => mobileController.text.length == 11;

  TextEditingController mobileController = TextEditingController();

  Widget closeButton() {
    return WidgetUtils.closeButton(
      ColorUtils.textColor,
    );
  }

  Widget header() {
    return Row(
      children: [
        closeButton(),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          'شماره موبایل مورد نظر را وارد کنید',
          style: TextStyle(
            fontSize: 15.0,
            color: ColorUtils.textColor,
          ),
        ),
      ],
    );
  }

  Widget buildMobileField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                mobileController.text = Globals.userStream.user!.mobile!;
                onChange(
                  mobileController.text,
                );
              },
              child: Icon(
                Icons.sim_card_outlined,
                size: Get.width / 12,
                color: ColorUtils.textColor.withOpacity(0.2),
              ),
            ),
            SizedBox(
              width: Get.width / 40,
            ),
            GestureDetector(
              onTap: () {
                // contactListModal();
              },
              child: Icon(
                Icons.contacts_outlined,
                size: Get.width / 12,
                color: ColorUtils.textColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
        SizedBox(
          width: Get.width / 25,
        ),
        Flexible(
          child: _phoneTextField(),
        ),
      ],
    );
  }

  void onChange(String string) {
    List<String> list = string.split('');
    if (list.isNotEmpty) {
      switch (list.length) {
        case 1:
          if (list[0] == '0') {
            mobileController.text = '0';
          } else {
            mobileController.clear();
          }
          break;
        case 2:
          if (list[1] == '9') {
            mobileController.text = '09';
          } else {
            mobileController.text = '0';
          }

          break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
          list.removeAt(0);
          list.removeAt(0);
          mobileController.text = '09' + list.join('');
          break;
      }
      setState(() {});
      Future.delayed(
        Duration.zero,
        () => mobileController.selection = TextSelection.fromPosition(
          TextPosition(
            offset: mobileController.text.length,
          ),
        ),
      );
      if (mobileController.text.length == 11) {
        FocusScope.of(Get.context!).unfocus();
      }
    }
  }

  Widget _phoneTextField() {
    return WidgetUtils.neuTextField(
      // focusNode: this.loginRegisterController.mobileFocusNode,
      controller: mobileController,
      // onChange: this.loginRegisterController.onChange,
      textAlign: TextAlign.center,
      formatter: [
        LengthLimitingTextInputFormatter(11),
      ],
      keyboardType: TextInputType.phone,
      title: "شماره موبایل",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          height: Get.height / 4,
          width: Get.width / 1.1,
          decoration: BoxDecoration(
            color: ColorUtils.black,
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 20.0,
              spreadRadius: 5.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                header(),
                ViewUtils.sizedBox(25),
                buildMobileField(),
                const Spacer(),
                confirmBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget confirmBtn() {
    return WidgetUtils.button(
      text: "خرید",
      onTap: isOk ? confirm : null,
    );
  }

  void confirm() {
    Get.back(
      result: mobileController.text,
    );
  }
}
