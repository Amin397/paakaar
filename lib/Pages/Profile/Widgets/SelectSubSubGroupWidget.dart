import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Profile/complete_profile_controller.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class SelectSubSubGroupWidget extends StatelessWidget {
  final CompleteProfileController controller;

  SelectSubSubGroupWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorUtils.mainRed,
          elevation: 4.0,
          highlightElevation: 4.0,
          focusElevation: 4.0,
          hoverElevation: 4.0,
          onPressed: () => this.exit(),
          foregroundColor: Colors.white,
          icon: Icon(
            Icons.check,
          ),
          label: Text(
            "تایید",
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => this.exit(),
                      child: Icon(
                        Ionicons.close,
                        color: ColorUtils.black,
                      ),
                    ),
                    Text(
                      "انتخاب تخصص ها",
                    ),
                    Icon(
                      Ionicons.close,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                ViewUtils.sizedBox(25),
                WidgetUtils.mainSearchTextField(
                  controller: this.controller.searchController,
                  onChange: (String str) {
                    this.controller.listOfSubSubGroups.forEach((element) {
                      element.searchShow =
                          element.name.contains(str) || str.isEmpty;
                    });
                    this.controller.update();
                  },
                ),
                ViewUtils.sizedBox(25),
                Expanded(
                  child: GetBuilder(
                    init: this.controller,
                    builder: (_) => AnimationLimiter(
                      child: ListView.separated(
                        itemCount: this
                            .controller
                            .listOfSubSubGroups
                            .where((element) => element.searchShow)
                            .length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Divider(),
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            child: this.buildSubSubGroup(
                              this
                                  .controller
                                  .listOfSubSubGroups
                                  .where((element) => element.searchShow)
                                  .toList()[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                ViewUtils.sizedBox(12.5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubSubGroup(FieldModel field) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          field.isSelected.value = !field.isSelected.value;
          this.controller.update();
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
                    color: field.isSelected.isTrue
                        ? Colors.white
                        : Colors.transparent,
                  ),
                ),
                decoration: BoxDecoration(
                  color: field.isSelected.isTrue
                      ? ColorUtils.green
                      : ColorUtils.searchBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                field.name,
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

  void exit() {
    Get.back();
  }
}
