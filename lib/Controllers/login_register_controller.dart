import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/alert_utils.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/AuthUtils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

class LoginRegisterController extends GetxController {
  RxBool isLogin = false.obs;
  RxBool isRegister = false.obs;
  RxBool isForgot = false.obs;
  RxBool getFingerprint = false.obs;
  File? file;
  Rx<TextEditingController> mobileController =
      (TextEditingController()).obs;
  TextEditingController codeController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();

  FocusNode mobileFocusNode =  FocusNode();
  FocusNode codeFocusNode =  FocusNode();
  FocusNode passwordNode =  FocusNode();

  final ProjectRequestUtils requests = ProjectRequestUtils();

  bool acceptTerms = false;

  // methods



  @override
  void onInit() {
    // createFile();
    super.onInit();
  }

  void onChange(String string) {
    List<String> list = string.split('');
    if (list.isNotEmpty) {
      switch (list.length) {
        case 1:
          if (list[0] == '0') {
            mobileController.value.text = '0';
          } else {
            mobileController.value.clear();
          }
          break;
        case 2:
          if (list[1] == '9') {
            mobileController.value.text = '09';
          } else {
            mobileController.value.text = '0';
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
          mobileController.value.text = '09' + list.join('');
          break;
      }
      if (mobileController.value.text.length == 11) {
        submit();
      } else {
        Future.delayed(
          Duration.zero,
          () => mobileController.value.selection =
              TextSelection.fromPosition(
            TextPosition(
              offset: mobileController.value.text.length,
            ),
          ),
        );
      }
    }
  }

  void submit() {
    if (isForgot.value == true) {
      forgot();
    } else if (isRegister.value == true) {
      if (acceptTerms) {
        register();
      } else {
        ViewUtils.showErrorDialog(
            "?????? ???????? ???????????? ?? ???????????? ???? ?????? ???? ???????????? ?????????????? ??????????");
      }
    } else if (isLogin.value == true) {
      login();
    } else {
      start();
    }
  }

  void register() async {

    EasyLoading.show();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print(token);
    ApiResult result = await requests.register(
          mobile: mobileController.value.text,
          code: codeController.text,
          pushId: token ?? '',
        );

    EasyLoading.dismiss();
    if (result.isDone) {
      completeData();
    } else {
      ViewUtils.showErrorDialog(
        result.data,
      );
    }
  }

  void login() async {
    if (passwordController.text.length < 4) {
      ViewUtils.showErrorDialog(
        "???????? ?????? ???????? ???? ???? ?????????? ???????? ????????",
      );
      return;
    }

    FirebaseMessaging? messaging;
    String? token;

    if (Firebase.apps.length != 0){
      messaging = FirebaseMessaging.instance;
      token = await messaging.getToken();
    }
    EasyLoading.show();

    print(token);
    ApiResult result = await requests.login(
          mobile: mobileController.value.text,
          password: passwordController.text,
          pushId: token ?? '',
        );
    EasyLoading.dismiss();
    if (result.isDone) {
      // ViewUtils.showSuccessDialog(
      //   // result.data['message'],
      //   ''
      // );

      FocusScope.of(context).requestFocus(FocusNode());
      // PrefHelpers.setCustomerId(result.data['customerId'].toString());
      // PrefHelpers.setCustomerIdBackup(result.data['customerId'].toString());
      // PrefHelpers.setMobile(mobileController.value.text.toString());
      Globals.userStream.changeUser(UserModel.fromJson(
        result.data['userData'],
      ));
      final box = GetStorage();
      box.write(
        'userId',
        Globals.userStream.user?.id.toString(),
      );

      print("Globals.userStream.user");
      print(Globals.userStream.user!.id);
      ViewUtils.showSuccessDialog('???????? ???? ???????????? ?????????? ????');
      Future.delayed(const Duration(seconds: 3), () {
        toMainPage();
      });
    } else {
      ViewUtils.showErrorDialog(
        result.data,
      );
    }
  }

  void start() async {
    if (mobileController.value.text.length != 11) {
      ViewUtils.showErrorDialog(
        "???????? ???????????? ???? ???? ?????????? ???????? ????????",
      );
      return;
    }
    EasyLoading.show();
    ApiResult result = await requests.startLoginRegister(
          mobile: mobileController.value.text,
        );
    EasyLoading.dismiss();
    if (result.isDone) {
      isLogin.value = result.data['type'] == 'login';
      if (isLogin.value) {
        // PrefHelpers.getFingerPrint().then((value) {
        //   if (value == 'true') {
        //     fingerprint();
        //   }
        // });
        passwordNode.requestFocus();
      }
      isRegister.value = result.data['type'] == 'register';
      if (isRegister.value == true) {
        codeFocusNode.requestFocus();
      }
      // ViewUtils.showInfoDialog(
      //   result.data['message'],
      // );
    } else {
      ViewUtils.showErrorDialog(
        result.data['message'],
      );
    }
  }

  void forgotPassword() async {
    EasyLoading.show();
    ApiResult result =
        await requests.forgotPassword(mobileController.value.text);
    EasyLoading.dismiss();
    if (result.isDone) {
      isForgot.value = true;
      codeFocusNode.requestFocus();
      isLogin.value = false;
      isRegister.value = false;
    } else {
      ViewUtils.showErrorDialog(
        result.data,
      );
    }
  }

  void forgot() async {
    EasyLoading.show();
    ApiResult result = await requests.forgotPasswordConfirm(
          mobileController.value.text,
          codeController.text,
        );
    EasyLoading.dismiss();

    if (result.isDone) {
      // ViewUtils.showSuccessDialog(
      //   "?????? ???????? ???????? ??????: ${codeController.text}",
      // );
      final box = GetStorage();
      box.write(
        'userId',
        result.data['userData']['id'],
      );
      Globals.userStream.changeUser(
        UserModel.fromJson(
          result.data['userData'],
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        toMainPage();
      });
    } else {
      ViewUtils.showErrorDialog(
        result.data,
      );
    }
  }

  void fingerprint() async {
    bool didAuthenticate = await authenticate(
      '???????? ???????? ?????? ?????????? ???? ?????? ????????.',
    );
    if (didAuthenticate) {
      // PrefHelpers.getCustomersIdBackup().then((value) async {
      //   if (value != null) {
      //     await PrefHelpers.setCustomerId(value);
      //     ApiResult result = await RequestHelper.getCustomerData(value);
      //     if (result.isDone) {
      //       Blocs.user.changeUser(UserModel.fromJson(result.data));
      //       TransitionHelper.replace(
      //         context: context,
      //         targetPage: MainPageScreen(),
      //       );
      //     } else {
      //       ViewUtils.showErrorDialog(context);
      //     }
      //   } else {
      //     ViewUtils.showErrorDialog(context);
      //   }
      // });
    }
  }

  void smsListen() async {
    // if (Platform.isAndroid) {
    //   final Telephony telephony = Telephony.instance;
    //   telephony.listenIncomingSms(
    //     onNewMessage: (SmsMessage message) {
    //       print(message.body);
    //     },
    //     listenInBackground: false,
    //   );
    // }
  }

  void toMainPage() async {
    Get.offAndToNamed(
      RoutingUtils.dashboard.name,

    );
  }

  void completeData() async {
    AlertUtils.completeData(
      mobile: mobileController.value.text,
      code: codeController.text,
    );
  }

  void onTermsChanged(bool? value) {
    acceptTerms = value!;
    // if(codeController.text.length == 5){

    // }
    refresh();
    submit();
  }





  Future createFile()async{
    final directory = await getTemporaryDirectory();
    print(await rootBundle.loadString('assets/logo.png'));
    // if(!await File(directory.path + '/assets/logo.png').exists()){
    //   file = File(directory.path + '/assets/logo.png');
    //   print('nist');
    // }else{
    //   print('hast');
    //   file = File(directory.path + '/assets/logo.png');
    // }
  }


  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

}
