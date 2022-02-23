import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

class CityPickerModal extends StatefulWidget {
  final bool isDismissible;

  const CityPickerModal({
    required this.isDismissible,
  });

  @override
  _CityPickerModalState createState() => _CityPickerModalState();
}

class _CityPickerModalState extends State<CityPickerModal> {
  List<CityModel>? listOfCities;

  void getCities() async {
    ApiResult result = await ClubRequestUtils.instance.allCities();
    if (result.isDone) {
      this.setState(() {
        this.listOfCities = CityModel.listFromJson(result.data);
      });
    }
  }

  @override
  void initState() {
    this.getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.1,
          height: Get.height / 1.2,
          decoration: BoxDecoration(
            color: ColorUtils.black,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 30.0,
              spreadRadius: 15.0,
            ),
          ),
          child: Column(
            children: [
              ViewUtils.sizedBox(40),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: this.header(),
              ),
              ViewUtils.sizedBox(40),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: this.searchWidget(),
              ),
              ViewUtils.sizedBox(50),
              Expanded(
                child: Center(
                  child: this.listOfCities is List<CityModel>
                      ? (this
                                      .listOfCities
                                      ?.where((element) => element.searchShow)
                                      .length ??
                                  0) >
                              0
                          ? this.buildCityList()
                          : WidgetUtils.dataNotFound("شهری")
                      : WidgetUtils.loadingWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchWidget() {
    return WidgetUtils.neuSearchField();
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            WidgetUtils.closeButton(ColorUtils.textColor),
            SizedBox(
              width: 5.0,
            ),
            AutoSizeText(
              'انتخاب شهر',
              style: TextStyle(
                fontSize: 15.0,
                color: ColorUtils.textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCityList() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RawScrollbar(
        thickness: 2,
        thumbColor: ColorUtils.yellow.withOpacity(0.5),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AnimationLimiter(
              child: ListView.builder(
                itemBuilder: this.buildCityItem,
                itemCount: this
                        .listOfCities
                        ?.where((element) => element.searchShow)
                        .length ??
                    0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCityItem(BuildContext context, int index) {
    CityModel city = this
        .listOfCities!
        .where((element) => element.searchShow)
        .toList()[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            height: Get.height / 15,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  this
                      .listOfCities
                      ?.where((element) => element.searchShow)
                      .forEach((element) {
                    element.isSelected = false;
                  });
                  city.isSelected = true;
                  this.setState(() {
                    Globals.city.updateCityData(city);
                  });
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            city.isSelected ? ColorUtils.yellow : Colors.grey,
                      ),
                      child: city.isSelected
                          ? Center(
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 15.0,
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      city.name,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_left,
                      color: ColorUtils.yellow,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showCityPicker({bool isDismissible = false}) {
  Get.dialog(
    CityPickerModal(
      isDismissible: isDismissible,
    ),
    barrierDismissible: isDismissible,
  );
}

Widget cityFab([
  Function? callback,
]) {
  return FloatingActionButton.extended(
    elevation: 0.0,
    hoverElevation: 0.0,
    shape: StadiumBorder(
      side: BorderSide(
        color: ColorUtils.yellow,
        width: 1,
      ),
    ),
    highlightElevation: 0.0,
    disabledElevation: 0.0,
    focusElevation: 0.0,
    foregroundColor: ColorUtils.yellow,
    label: StreamBuilder<CityModel>(
      stream: Globals.city.getStream,
      initialData: Globals.city.city,
      builder: (BuildContext context, AsyncSnapshot<CityModel> snapshot) {
        return Text(
          snapshot.hasData ? "${Globals.city.city?.name}" : "انتخاب شهر",
          style: TextStyle(),
        );
      },
    ),
    icon: Icon(
      Ionicons.location_outline,
    ),
    backgroundColor: ColorUtils.black,
    onPressed: () {
      showCityPicker();
    },
  );
}
