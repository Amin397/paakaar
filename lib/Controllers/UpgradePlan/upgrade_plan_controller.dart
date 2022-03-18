import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/membership_model.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Pages/Profile/Widgets/complete_profile_dialog.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/image_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradePlanController extends GetxController {
  late List<MembershipModel> listOfMemberShips;
  RxBool isMemberShipsLoaded = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ProjectRequestUtils requests = ProjectRequestUtils();
  late StreamSubscription _sub;

  @override
  void onInit() {
    this.getMemberShips();

    super.onInit();
  }

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      Map<String, String> params = uri!.queryParameters;
      Map data = jsonDecode(params['data']!);
      showLottie(data['status'] == true);
      if (data['status'] == true) {
        Get.back();
        handleStart();
      }
      closeWebView();
    }, onError: (err) {});
  }

  void showLottie(bool success) {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pop(context);
    });
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SizedBox.expand(
          child: Container(
            margin: const EdgeInsets.all(50.0),
            child: Center(
              child: success ? ImageUtils.creditSuccess : ImageUtils.creditFail,
            ),
          ),
        );
      },
    );
  }

  void getMemberShips() async {
    ApiResult result = await this.requests.getAllMemberships();
    if (result.isDone) {
      listOfMemberShips = MembershipModel.listFromJson(result.data);

      UserModel userModel = Globals.userStream.user!;
      MembershipModel membershipModel = Globals.userStream.user!.role!;
      listOfMemberShips.forEach((element) {
        element.isDisabled.value = (!element.isSpecial! &&
                (membershipModel.isSpecial! && !userModel.isExpired)) ||
            element.membershipId == membershipModel.membershipId;
      });

      isMemberShipsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog();
    }
  }

  void buyPlan() async {
    if (listOfMemberShips.any((element) => element.isSelected.isTrue)) {
      EasyLoading.show();
      ApiResult result = await requests.buyMembership(
        listOfMemberShips
            .singleWhere((element) => element.isSelected.isTrue)
            .membershipId!,
      );
      EasyLoading.dismiss();
      if (result.isDone) {
        if (result.data['type'] == 'free') {
          if (result.data['status'] == true) {
            // setMembership();
            handleStart();
            ViewUtils.showSuccessDialog(result.data['message']);
          } else {
            ViewUtils.showErrorDialog(result.data['message']);
          }
        } else {
          if (result.data['status'] == true) {
            initUniLinks();
            launch(result.data['url']);
          } else {
            ViewUtils.showErrorDialog(result.data['message']);
          }
        }
      } else {
        ViewUtils.showErrorDialog();
      }
    }
  }

  void setMembership() {
    // MembershipModel membershipModel =
    //     listOfMemberShips.singleWhere((element) => element.isSelected.isTrue);
    // UserModel userModel = Globals.userStream.user!;
    // userModel.role = membershipModel;
    // Globals.userStream.changeUser(userModel);
    Get.back();
    Get.toNamed(
      RoutingUtils.completeProfile.name,
    );
    Get.dialog(
      CompleteProfileDialog(),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }



  void handleStart() async {
      ApiResult result =
      await requests.getIndividualData( Globals.userStream.user!.id.toString());
      if (result.isDone) {
        Globals.userStream.user = UserModel.fromJson(
          result.data,
        );
        Get.back();
        Get.toNamed(
          RoutingUtils.dashboard.name,
        );
        Get.dialog(
          CompleteProfileDialog(),
          barrierColor: Colors.black.withOpacity(0.5),
        );

        // print('main page');
        // if(notif != 0 && notif != null){
        //   List<dynamic> notifList = jsonDecode(box.read('notifList'));
        //   Globals.notification.setNotification(notification: notif , messagesList: notifList);
        // }

      }
  }



}
