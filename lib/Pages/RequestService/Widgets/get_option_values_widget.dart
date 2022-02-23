import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Models/option_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class GetOptionValuesWidget extends StatelessWidget {
  final GetxController expertListController;
  final OptionModel option;
  GetOptionValuesWidget({
    Key? key,
    required this.expertListController,
    required this.option,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
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
                      onTap: () => Get.close(1),
                      child: const Icon(
                        Ionicons.close,
                        color: ColorUtils.black,
                      ),
                    ),
                    Text(
                      "انتخاب مقادیر ${option.name}",
                    ),
                    const Icon(
                      Ionicons.close,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                ViewUtils.sizedBox(25),
                Expanded(
                  child: GetBuilder(
                    init: expertListController,
                    builder: (_) => AnimationLimiter(
                      child: ListView.builder(
                        itemCount: option.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            child: buildOptionValue(
                              option.values[index],
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
      ),
    );
  }

  Widget buildOptionValue(OptionValue optionValue) {
    return Container(
      width: Get.width,
      height: Get.height / 18,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: ViewUtils.boxShadow(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            option.values.forEach((element) {
              element.isSelected.value = false;
            });
            optionValue.isSelected.value = true;
            expertListController.update();
            Future.delayed(const Duration(milliseconds: 200), () {
              Get.close(1);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 25,
                  height: 25,
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: optionValue.isSelected.isTrue
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: optionValue.isSelected.isTrue
                        ? ColorUtils.green
                        : ColorUtils.searchBackground,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  optionValue.name,
                  style: TextStyle(
                    color: ColorUtils.black,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
