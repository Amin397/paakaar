import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:paakaar/Controllers/MainPage/dashboard_controller.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class FieldsWidget extends StatelessWidget {
  final DashboardController dashboardController;

  FieldsWidget({
    Key? key,
    required this.dashboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxHeight > 480.0) {
          return Container(
            height: Get.height * .16,
            width: Get.width,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    dashboardController.goToOffset(next: false , controller: dashboardController.scrollController);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .01,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => dashboardController.isFieldsLoaded.isTrue
                        ? Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                controller:
                                    dashboardController.scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: buildField,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    dashboardController.listOfFields.length,
                              ),
                            ),
                          )
                        : WidgetUtils.loadingWidget(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    dashboardController.goToOffset(next: true , controller: dashboardController.scrollController);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .01,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: Get.height * .16,
            width: Get.width,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    dashboardController.goToOffset(next: false , controller: dashboardController.scrollController);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .01,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => dashboardController.isFieldsLoaded.isTrue
                        ? Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                controller:
                                    dashboardController.scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: buildField,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    dashboardController.listOfFields.length,
                              ),
                            ),
                          )
                        : WidgetUtils.loadingWidget(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    dashboardController.goToOffset(next: true , controller: dashboardController.scrollController);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .01,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildField(BuildContext context, int index) {
    FieldModel field = dashboardController.listOfFields[index];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        if (raints.maxWidth > 480.0) {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              verticalOffset: index * 25.0,
              child: FadeInAnimation(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: EdgeInsets.symmetric(
                    vertical: Get.height * .02,
                    horizontal: Get.width * .018,
                  ),
                  width: Get.width * .14,
                  height: Get.width * .14,
                  child: GestureDetector(
                    onTap: () => dashboardController.onFieldClick(field),
                    child: Obx(
                      () => Column(
                        children: [
                          Flexible(
                            flex: 2,
                            child: NeumorphicContainer(
                              padding: const EdgeInsets.all(6.0),
                              decoration: MyNeumorphicDecoration(
                                border: Border.all(
                                  color: ColorUtils.mainRed.withOpacity(.8),
                                  width: .5,
                                ),
                                shape: BoxShape.circle,
                                color: field.isSelected.isTrue
                                    ? ColorUtils.red
                                    : Colors.white,
                              ),
                              bevel: field.isSelected.isTrue ? 0.0 : 12.0,
                              curveType: field.isSelected.isTrue
                                  ? CurveType.emboss
                                  : CurveType.concave,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Image.network(
                                    field.icon,
                                    fit: BoxFit.cover,
                                    color: field.isSelected.isTrue
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // ViewUtils.sizedBox(100),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: Center(
                                child: AutoSizeText(
                                  field.name,
                                  style: TextStyle(
                                    fontSize:12,
                                    color: field.isSelected.isTrue
                                        ? ColorUtils.red.shade900
                                        : ColorUtils.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(100)
                  ),
                ),
              ),
            ),
          );
        } else {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              verticalOffset: index * 25.0,
              child: FadeInAnimation(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  // margin:  EdgeInsets.all(6.0),
                  width: Get.width * .2,
                  child: GestureDetector(
                    onTap: () => dashboardController.onFieldClick(field),
                    child: Obx(
                      () => Column(
                        children: [
                          Expanded(
                            child: NeumorphicContainer(
                              decoration: MyNeumorphicDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: field.isSelected.isTrue
                                    ? ColorUtils.mainRed
                                    : Colors.white,
                              ),
                              bevel: field.isSelected.isTrue ? 0.0 : 12.0,
                              curveType: field.isSelected.isTrue
                                  ? CurveType.emboss
                                  : CurveType.concave,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                    field.icon,
                                    fit: BoxFit.cover,
                                    height: 55.0,
                                    width: 55.0,
                                    color: field.isSelected.isTrue
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // ViewUtils.sizedBox(100),
                          Text(
                            field.name,
                            style: TextStyle(
                              fontSize: field.isSelected.isTrue ? 14.0 : 12.0,
                              color: field.isSelected.isTrue
                                  ? ColorUtils.mainRed.shade900
                                  : ColorUtils.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
