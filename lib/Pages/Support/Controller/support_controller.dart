import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Pages/ConnectUs/Model/connect_us_model.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';

class SupportController extends GetxController {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  final Completer<GoogleMapController> controller = Completer();

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
}
