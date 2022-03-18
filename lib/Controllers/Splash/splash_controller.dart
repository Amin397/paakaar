import 'dart:convert';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/version_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:get_storage/get_storage.dart';

import '../../Widgets/update_alert.dart';

class SplashController extends GetxController {
  final ProjectRequestUtils _projectRequestUtils = ProjectRequestUtils();

  @override
  void onInit() {
    checkVersion();
    super.onInit();
  }

  checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    VersionModel? versionModel;
    _projectRequestUtils.getAppVersion().then(
      (value)async {
        if (value.isDone) {
          versionModel = VersionModel.fromJson(value.data);
          if (packageInfo.version == versionModel!.current) {
            handleStart();
          } else {
            //force alert
             final amin = await showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                content: UpdateAlert(
                  versionModel: versionModel,
                  packageName: packageInfo.packageName,
                ),
              ),
            );
             if(amin){
               // print(amin);
               handleStart();
             }
          }
        }
      },
    );
  }

  void handleStart() async {
    final box = GetStorage();
    var userId = box.read('userId');
    if (userId != null) {
      ApiResult result =
          await _projectRequestUtils.getIndividualData(userId.toString());
      if (result.isDone) {
        Globals.userStream.user = UserModel.fromJson(
          result.data,
        );
        // print('main page');

        var notif = box.read('notif');
        if (notif != 0 && notif != null) {
          List<dynamic> notifList = jsonDecode(box.read('notifList'));
          Globals.notification
              .setNotification(notification: notif, messagesList: notifList);
        }
        Get.offAndToNamed(
          RoutingUtils.dashboard.name,
        );
        return;
      }
    }
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAndToNamed(
        RoutingUtils.appIntroScreen.name,
      );
    });
  }
}
