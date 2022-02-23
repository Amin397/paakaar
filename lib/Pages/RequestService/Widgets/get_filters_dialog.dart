import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class GetFiltersDialog extends StatelessWidget {
  final dynamic controller;

  GetFiltersDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.2,
          height: Get.height / 2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 12.0,
              spreadRadius: 2.0,
            ),
          ),
          child: Padding(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.close(1),
                      child: Icon(
                        Icons.close,
                        size: 21.0,
                        color: ColorUtils.textColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "فیلتر کردن نتایج",
                      style: TextStyle(
                        color: ColorUtils.textColor,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: buildFilters(),
                ),
                WidgetUtils.button(
                  onTap: () {
                    controller.unFocus();
                    Get.close(1);
                  },
                ),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
          ),
        ),
      ),
    );
  }

  Widget buildFilters() {
    return Obx(
      () => controller.isOptionsLoaded.value == true
          ? GetBuilder(
              init: controller as GetxController,
              builder: (context) {
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: controller.listOfOptions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: buildOptionItem(
                              controller.listOfOptions[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : WidgetUtils.loadingWidget(),
    );
  }

  Widget buildOptionItem(OptionModel option) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => controller.getOptionValues(option),
          onLongPress: () {
            option.values.forEach((element) {
              element.isSelected.value = false;
            });
            controller.update();
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: option.isSelected
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          option.values.forEach((element) {
                            element.isSelected.value = false;
                          });
                          controller.update();
                        },
                        child: Icon(
                          Icons.close,
                          color: ColorUtils.mainRed,
                        ),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        option.name + ": ",
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        option.values
                            .singleWhere((element) => element.isSelected.isTrue)
                            .name,
                        style: const TextStyle(
                          color: ColorUtils.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        option.name,
                        style: TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 14.0,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: ColorUtils.red,
                      ),
                    ],
                  ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ViewUtils.boxShadow(),
      ),
    );
  }
}
