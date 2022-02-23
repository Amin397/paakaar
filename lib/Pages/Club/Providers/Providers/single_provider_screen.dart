import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:paakaar/Controllers/Club/Providers/SingleProviderController.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/CasteModel.dart';
import 'package:paakaar/Models/Club/ProviderModel.dart';
import 'package:paakaar/Models/Club/WorkGroupModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleProviderScreen extends StatelessWidget {
  final ProviderModel provider;
  late SingleProviderController singleProviderController;
  final CasteModel caste;
  final WorkGroupModel workGroup;

  SingleProviderScreen({
    Key? key,
    required this.provider,
    required this.caste,
    required this.workGroup,
  }) {
    singleProviderController = Get.put(
      SingleProviderController(provider),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorUtils.black,
        body: Column(
          children: [
            WidgetUtils.singlePageAppBar(
              text: provider.name.toString(),
              icon: provider.avatar.toString(),
            ),
            ViewUtils.sizedBox(10),
            Expanded(
              child: Padding(
                padding: ViewUtils.scaffoldPadding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.height / 18,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            "خرید از فروشگاه ${provider.name} تا سقف ${provider.discountPercent} درصد تخفیف",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: ColorUtils.yellow,
                          ),
                        ),
                      ),
                      ViewUtils.sizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "خرید شما با ${singleProviderController.calcPercent()}٪ تخفیف: ",
                            style: TextStyle(
                              color: ColorUtils.textColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              singleProviderController.showInfoDialog();
                            },
                            child: Text(
                              "اطلاعات بیشتر",
                              style: TextStyle(
                                color: ColorUtils.darkBlue,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ViewUtils.sizedBox(),
                      buildAmountWidget(),
                      ViewUtils.sizedBox(),
                      buildButtonsWidget(),
                      ViewUtils.sizedBox(25),
                      geoInfoWidget(),
                      ViewUtils.sizedBox(),
                      WidgetUtils.neuButton(
                        text: 'مسیریابی',
                        enabled: true,
                        onTap: () {
                          String scheme = 'https';
                          if (Platform.isIOS) {
                            scheme = 'maps';
                          }
                          String url =
                              "$scheme://www.google.com/maps/dir/?api=1&travelmode=driving&layer=traffic&destination=${singleProviderController.singleProvider?.latitude},${singleProviderController.singleProvider?.longitude}";
                          canLaunch(url).then(
                            (value) => {
                              if (value == true)
                                {
                                  launch(url),
                                }
                            },
                          );
                        },
                        enabledBevel: 6.0,
                        activeCurveType: CurveType.flat,
                        textColor: Colors.white,
                      ),
                      ViewUtils.sizedBox(),
                      generalInfoWidget()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAmountWidget() {
    return Row(
      children: [
        Flexible(
          flex: 12,
          child: WidgetUtils.neuTextField(
            controller: singleProviderController.priceController,
            keyboardType: TextInputType.number,
            title: "مبلغ پرداخت",
            price: true,
            onChange: (String string) {
              // setState(() {});
            },
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildButtonsWidget() {
    return Row(
      children: [
        if ((Globals.userStream.user?.credit ?? 0) >= 5000) ...[
          Flexible(
            flex: 12,
            child: GestureDetector(
              onTap: () => singleProviderController.payForProvider(
                    fromWallet: true,
                  ),
              child: NeumorphicContainer(
                height: Get.height / 21,
                child: Center(
                  child: Text(
                    "پرداخت از کیف پول (موجودی: ${ViewUtils.moneyFormat(Globals.userStream.user?.credit.toDouble())} تومان)",
                    style: TextStyle(
                      fontSize: 11.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
                ),
                bevel: this
                            .singleProviderController
                            .priceController
                            .text
                            .toDouble() >=
                        5000
                    ? 8.0
                    : 3.0,
                curveType: CurveType.flat,
                decoration: MyNeumorphicDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ColorUtils.black,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
        Flexible(
          flex: 6,
          child: GestureDetector(
            onTap: () => singleProviderController.payForProvider(),
            child: NeumorphicContainer(
              height: Get.height / 21,
              child: Center(
                child: Text(
                  "پرداخت آنلاین",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: ColorUtils.textColor,
                  ),
                ),
              ),
              bevel: this
                          .singleProviderController
                          .priceController
                          .text
                          .toDouble() >=
                      5000
                  ? 8.0
                  : 3.0,
              curveType: CurveType.flat,
              decoration: MyNeumorphicDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: ColorUtils.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget geoInfoWidget() {
    return Container(
      height: Get.height / 3.9,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Ionicons.location_outline,
                  color: ColorUtils.yellow,
                ),
                SizedBox(
                  width: Get.width / 50,
                ),
                Text(
                  "آدرس و موقعیت",
                  style: TextStyle(
                    color: ColorUtils.yellow,
                  ),
                ),
              ],
            ),
            ViewUtils.sizedBox(150),
            Divider(
              color: ColorUtils.yellow,
            ),
            ViewUtils.sizedBox(150),
            Row(
              children: [
                Obx(
                  () => singleProviderController.isLoaded.isTrue
                      ? Text(
                          Globals.city.city?.name ??
                              '' +
                                  ' - ' +
                                  (this
                                          .singleProviderController
                                          .singleProvider
                                          ?.mainStreet
                                          .toString() ??
                                      ''),
                          style: TextStyle(
                            color: ColorUtils.yellow,
                          ),
                        )
                      : shimmerWidget(
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: ColorUtils.yellow,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: Get.width / 4,
                          ),
                        ),
                ),
              ],
            ),
            shimmerWidget(
              child: Obx(
                () => singleProviderController.isLoaded.isTrue
                    ? buildMap()
                    : shimmerWidget(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorUtils.yellow,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: Get.height / 9,
                        ),
                      ),
              ),
            ),
            ViewUtils.sizedBox(75),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: ColorUtils.yellow,
        ),
      ),
    );
  }

  Widget shimmerWidget({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 500),
        child: child,
        baseColor: ColorUtils.yellow.withOpacity(0.7),
        highlightColor: ColorUtils.yellow.withOpacity(0.2),
      ),
    );
  }

  Widget buildMap() {
    return Container(
      height: Get.height / 8,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        myLocationEnabled: false,
        zoomGesturesEnabled: false,
        trafficEnabled: false,
        rotateGesturesEnabled: false,
        markers: {
          Marker(
            position: LatLng(
              double.parse(this
                      .singleProviderController
                      .singleProvider
                      ?.latitude
                      .toString() ??
                  '0.0'),
              double.parse(this
                      .singleProviderController
                      .singleProvider
                      ?.longitude
                      .toString() ??
                  '0.0'),
            ),
            markerId: MarkerId('location'),
          )
        },
        compassEnabled: false,
        tiltGesturesEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(this
                    .singleProviderController
                    .singleProvider
                    ?.latitude
                    .toString() ??
                '0.0'),
            double.parse(this
                    .singleProviderController
                    .singleProvider
                    ?.longitude
                    .toString() ??
                '0.0'),
          ),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          if (!singleProviderController.mapController.isCompleted)
            singleProviderController.mapController.complete(controller);
        },
      ),
    );
  }

  Widget generalInfoWidget() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Ionicons.information_circle_outline,
                  color: ColorUtils.yellow,
                ),
                SizedBox(
                  width: Get.width / 50,
                ),
                AutoSizeText(
                  "اطلاعات عمومی",
                  style: TextStyle(
                    color: ColorUtils.yellow,
                  ),
                ),
              ],
            ),
            ViewUtils.sizedBox(150),
            Divider(
              color: ColorUtils.yellow,
            ),
            ViewUtils.sizedBox(150),
            Row(
              children: [
                singleProviderController.isLoaded.isTrue
                    ? Text(
                        workGroup.name + ' - ' + caste.name,
                        style: TextStyle(
                          color: ColorUtils.yellow,
                        ),
                      )
                    : shimmerWidget(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: ColorUtils.yellow,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          width: Get.width / 4,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: ColorUtils.yellow,
        ),
      ),
    );
  }
}
