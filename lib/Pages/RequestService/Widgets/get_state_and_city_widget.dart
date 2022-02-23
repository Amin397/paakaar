import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Services/request_service_controller.dart';
import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class GetStateAndCityWidget extends StatelessWidget {
  final RequestServiceController controller;

  GetStateAndCityWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder(
          init: controller,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: controller.listOfStates
                          .any((element) => element.isSelected) &&
                      !controller.showStates &&
                      controller
                          .listOfStates[controller.listOfStates
                              .indexWhere((element) => element.isSelected)]
                          .listOfCities
                          .any((element) => element.isSelected) &&
                      !controller.showStates
                  ? FloatingActionButton.extended(
                      backgroundColor: ColorUtils.mainRed,
                      elevation: 4.0,
                      highlightElevation: 4.0,
                      focusElevation: 4.0,
                      hoverElevation: 4.0,
                      onPressed: () => Get.back(),
                      foregroundColor: Colors.white,
                      icon: Icon(
                        Icons.location_on_outlined,
                      ),
                      label: Text(
                        "تایید",
                      ),
                    )
                  : FloatingActionButton.extended(
                      backgroundColor: ColorUtils.mainRed,
                      elevation: 4.0,
                      highlightElevation: 4.0,
                      focusElevation: 4.0,
                      hoverElevation: 4.0,
                      onPressed: () {
                        controller.listOfStates.forEach((element) {
                          element.isSelected = false;
                        });
                        controller.update();
                        Get.back();
                      },
                      foregroundColor: Colors.white,
                      icon: Icon(
                        Icons.location_on_outlined,
                      ),
                      label: Text(
                        "همه",
                      ),
                    ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        textDirection: controller.listOfStates
                                    .any((element) => element.isSelected) &&
                                !controller.showStates
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.close(1),
                            child: Icon(
                              Ionicons.close,
                              color: ColorUtils.black,
                            ),
                          ),
                          Text(
                            "انتخاب شهر و استان",
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.showStates = true;
                              controller.refresh();
                            },
                            child: Icon(
                              Icons.arrow_left,
                              color: !controller.showStates
                                  ? ColorUtils.mainRed
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      ViewUtils.sizedBox(25),
                      Expanded(
                        child: GetBuilder(
                          init: controller,
                          builder: (_) => AnimationLimiter(
                            child: ListView.separated(
                              itemCount: controller.listOfStates.any(
                                          (element) => element.isSelected) &&
                                      !controller.showStates
                                  ? controller
                                      .listOfStates[controller.listOfStates
                                          .indexWhere(
                                              (element) => element.isSelected)]
                                      .listOfCities
                                      .length
                                  : controller.listOfStates.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 48.0,
                                  ),
                                  child: Divider(
                                    color: ColorUtils.mainRed.withOpacity(0.5),
                                    thickness: 0.2,
                                  ),
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    horizontalOffset: 150.0,
                                    child: FadeInAnimation(
                                      child: controller.listOfStates.any(
                                                  (element) =>
                                                      element.isSelected) &&
                                              !controller.showStates
                                          ? buildCity(
                                              controller
                                                  .listOfStates[controller
                                                      .listOfStates
                                                      .indexWhere((element) =>
                                                          element.isSelected)]
                                                  .listOfCities[index],
                                            )
                                          : buildState(
                                              controller.listOfStates[index],
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget buildCity(CityModel city) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          city.isSelected = !city.isSelected;
          controller.update();
        },
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          margin: EdgeInsets.symmetric(vertical: 2.0),
          height: Get.height / 24,
          child: Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                width: 25,
                height: 25,
                child: Center(
                  child: Icon(
                    Icons.done,
                    color: city.isSelected ? Colors.white : Colors.transparent,
                  ),
                ),
                decoration: BoxDecoration(
                  color: city.isSelected
                      ? ColorUtils.green
                      : ColorUtils.searchBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                city.name,
                style: TextStyle(
                  color: ColorUtils.black,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                color: ColorUtils.mainRed.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildState(StateModel state) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          controller.listOfStates.forEach((element) {
            element.isSelected = false;
          });
          state.isSelected = true;
          controller.showStates = false;
          controller.update();
        },
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          margin: EdgeInsets.symmetric(vertical: 2.0),
          height: Get.height / 24,
          child: Row(
            children: [
              Text(
                state.name,
                style: TextStyle(
                  color: ColorUtils.black,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                color: ColorUtils.mainRed.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
