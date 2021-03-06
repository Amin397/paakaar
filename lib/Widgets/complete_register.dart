import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

class CompleteRegister extends StatefulWidget {
  const CompleteRegister({
    required this.mobile,
    required this.code,
  });

  final String mobile;
  final String code;

  @override
  _CompleteRegisterState createState() => _CompleteRegisterState();
}

class _CompleteRegisterState extends State<CompleteRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController moarefiCodeTextController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController refererController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode moarefiCodeFocusNode = FocusNode();
  FocusNode fatherNameFocusNode = FocusNode();
  FocusNode nationalCodeFocusNode = FocusNode();
  FocusNode refererFocusNode = FocusNode();

  int gender = 1;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: Get.width,
        height: Get.height * .57,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(Get.width > 400.0){
              return Container(
                height: Get.height * .5,
                width: Get.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      '?????????? ??????????????',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: ColorUtils.textColor,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 12.0,
                    // ),
                    body(),
                    // const SizedBox(
                    //   height: 12.0,
                    // ),
                    finalBtn(),
                    // const SizedBox(
                    //   height: 12.0,
                    // ),
                  ],
                ),
              );
            }else{
              return Container(
                height: Get.height * .55,
                width: Get.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      '?????????? ??????????????',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: ColorUtils.textColor,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 12.0,
                    // ),
                    body(),
                    // const SizedBox(
                    //   height: 12.0,
                    // ),
                    finalBtn(),
                    // const SizedBox(
                    //   height: 12.0,
                    // ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget finalBtn() {
    return Expanded(
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: WidgetUtils.neuButton(
            text: "?????? ??????",
            onTap: () => finalize(),
            enabledBevel: 8.0,
            textColor: Colors.white,
            enabled: true,
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        name(),
        // SizedBox(
        //   height: Get.height / 50,
        // ),
        lastName(),
        // SizedBox(
        //   height: Get.height / 50,
        // ),
        moarefiCode(),
        // SizedBox(
        //   height: Get.height / 50,
        // ),
        // fatherName(),
        // SizedBox(
        //   height: Get.height / 50,
        // ),
        // AnimatedSwitcher(
        //   duration: Duration(milliseconds: 150),
        //   child: nationalCode(),
        //   transitionBuilder: (Widget child, Animation animation) {
        //     return FadeTransition(
        //       opacity: animation,
        //       child: child,
        //     );
        //   },
        // ),
        // idNumber(),
        SizedBox(
          height: Get.height / 50,
        ),
        // referer(),
        // SizedBox(
        //   height: Get.height / 50,
        // ),
        genderSelect(),
        // SizedBox(
        //   height: Get.height * .1,
        // ),
      ],
    );
  }

  Widget genderSelect() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => gender = 2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: gender == 2
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
                    "????????",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: gender == 2
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
              onTap: () => setState(() => gender = 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: gender == 1
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
                    "??????",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: gender == 1
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
  }

  Widget _textInput({
    required TextEditingController controller,
    required String name,
    void Function(String)? onChange,
    required FocusNode focusNode,
    int maxLen = 9999,
    TextInputType? keyBoardType,
    TextAlign align = TextAlign.right,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        textAlign: align,
        controller: controller,
        onChanged: onChange,
        focusNode: focusNode,
        keyboardType: keyBoardType,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          LengthLimitingTextInputFormatter(
            maxLen,
          ),
        ],
        style: TextStyle(
          color: ColorUtils.textColor,
          fontSize: 12.0,
        ),
        cursorColor: ColorUtils.mainRed,
        decoration: InputDecoration(
          hintText: name,
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
        ),
      ),
    );
  }

  Widget name() {
    return _textInput(
      controller: nameController,
      focusNode: nameFocusNode,
      name: "??????",
    );
  }

  Widget lastName() {
    return _textInput(
      controller: lastNameController,
      focusNode: lastNameFocusNode,
      name: "?????? ????????????????",
    );
  }

  Widget fatherName() {
    return _textInput(
      controller: fatherNameController,
      focusNode: fatherNameFocusNode,
      name: "?????? ??????",
    );
  }

  Widget nationalCode() {
    return _numberInput(
      controller: nationalCodeController,
      focusNode: nationalCodeFocusNode,
      name: "???? ??????",
      onChange: (String string) {
        if (string.length == 10) {
          refererFocusNode.requestFocus();
        }
      },
    );
  }

  Widget _numberInput({
    required TextEditingController controller,
    required String name,
    void Function(String)? onChange,
    required FocusNode focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: TextInputType.number,
        focusNode: focusNode,
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: ColorUtils.mainRed,
        onChanged: onChange,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: name,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorUtils.mainRed,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget referer() {
    return _textInput(
      controller: refererController,
      focusNode: refererFocusNode,
      name: "???????????? ????????",
      onChange: onChange,
      align: TextAlign.center,
      maxLen: 11,
    );
  }

  void onChange(String string) {
    List<String> list = string.split('');
    if (list.isNotEmpty) {
      switch (list.length) {
        case 1:
          if (list[0] == '0') {
            moarefiCodeTextController.text = '0';
          } else {
            moarefiCodeTextController.clear();
          }
          break;
        case 2:
          if (list[1] == '9') {
            moarefiCodeTextController.text = '09';
          } else {
            moarefiCodeTextController.text = '0';
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
          moarefiCodeTextController.text = '09' + list.join('');
          break;
      }
      if (moarefiCodeTextController.text.length == 11) {
      } else {
        Future.delayed(
          Duration.zero,
          () =>
              moarefiCodeTextController.selection = TextSelection.fromPosition(
            TextPosition(
              offset: moarefiCodeTextController.text.length,
            ),
          ),
        );
      }
    }
  }

  void finalize() {
    EasyLoading.show();
    ProjectRequestUtils.instance
        .completeRegister(
      name: nameController.text,
      lastName: lastNameController.text,
      // nationalCode: nationalCodeController.text,
      gender: gender.toString(),
      // fatherName: fatherNameController.text,
      // referer: refererController.text,
      code: widget.code,
      moarefiCode: moarefiCodeTextController.text.isEmpty
          ? ''
          : moarefiCodeTextController.text,
      mobile: widget.mobile,
    )
        .then((ApiResult result) async {
      EasyLoading.dismiss();
      if (result.isDone) {
        Globals.userStream.changeUser(
          UserModel.fromJson(result.data['userData']),
        );
        final storage = GetStorage();
        await storage.write('userId', result.data['userId']);
        Get.offAllNamed(
          RoutingUtils.dashboard.name,
        );
      } else {
        ViewUtils.showErrorDialog(
          result.data,
        );
      }
    });
  }

  Widget moarefiCode() {
    return _textInput(
      onChange: onChange,
      maxLen: 11,
      keyBoardType: TextInputType.number,
      controller: moarefiCodeTextController,
      focusNode: moarefiCodeFocusNode,
      name: "???? ???????? (??????????????)",
    );
  }
}
