import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paakaar/Pages/ConnectUs/Model/connect_us_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class ConnectUsController extends GetxController {
  final ProjectRequestUtils requests = ProjectRequestUtils();

  ConnectusModel? model;

  Completer<GoogleMapController> controller = Completer();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void onInit() {
    getInfoData();
    super.onInit();
  }

  getInfoData() async {
    ApiResult result = await requests.getInfoData();
    if (result.isDone) {
      model = ConnectusModel.fromJson(result.data);
      update();
    } else {
      ViewUtils.showErrorDialog(
        'خطایی رخ داد',
      );
    }
  }
}
