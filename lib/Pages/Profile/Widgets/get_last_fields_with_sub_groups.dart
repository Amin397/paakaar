import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Profile/complete_profile_controller.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class GetLastFieldsWithSubGroups extends StatelessWidget {
  final List<FieldModel> listOfSpecialties;
  List<FieldModel> listOfSelectedSpecialties = [];
  final CompleteProfileController controller;

  GetLastFieldsWithSubGroups({
    Key? key,
    required this.listOfSpecialties,
    required this.controller,
    this.listOfSelectedSpecialties = const [],
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: Get.width / 1.1,
          height: Get.height / 1.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: GetBuilder(
            init: controller,
            builder: (context) {
              return Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.close(1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Ionicons.close,
                            color: ColorUtils.textColor,
                          ),
                        ),
                      ),
                      Text(
                        "حداکثر تا ${Globals.userStream.user?.role?.subSubGroupCount} تخصص را انتخاب کنید",
                        style: const TextStyle(
                          color: ColorUtils.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: buildSubSubGroups(),
                  ),
                  ViewUtils.sizedBox(75),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: WidgetUtils.button(
                            outline: true,
                            text: "مرحله قبل",
                            onTap: () => Get.back(
                              result: 'get-back',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: WidgetUtils.button(
                            onTap: () => Get.back(
                              result: listOfSelectedSpecialties,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ViewUtils.sizedBox(75),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildField(FieldModel field) {
    bool isSelected = listOfSelectedSpecialties.any(
      (e) => e.id == field.id,
    );
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          if (!listOfSelectedSpecialties.contains(field)) {
            listOfSelectedSpecialties.add(field);
          }

          if (listOfSelectedSpecialties.length >=
              (Globals.userStream.user?.role?.subSubGroupCount ?? 2)) {
            Get.back(
              result: listOfSelectedSpecialties,
            );
          }
          controller.update();
        },
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          height: Get.height / 24,
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 25,
                  height: 25,
                  child: Center(
                    child: Icon(
                      Icons.done,
                      color: isSelected ? Colors.white : Colors.transparent,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorUtils.green
                        : ColorUtils.searchBackground,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  field.name,
                  style: const TextStyle(
                    color: ColorUtils.black,
                  ),
                ),
                // Spacer(),
                // Icon(
                //   Icons.arrow_right,
                //   color: ColorUtils.mainRed.withOpacity(0.8),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSeparator(BuildContext context, int index) {
    return Container(
      height: Get.height / 75,
      child: Divider(
        color: ColorUtils.mainRed.withOpacity(0.5),
      ),
    );
  }

  Widget buildSubSubGroups() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => buildField(
        listOfSpecialties[index],
      ),
      itemCount: listOfSpecialties.length,
    );
  }

  Widget buildSubSubGroup(BuildContext context, int index) {
    FieldModel subSubGroup = listOfSpecialties[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: (subSubGroup.listOfSubItems.length *
              ((Get.height / 24) + 4.0 + (Get.height / 75))) +
          (Get.height / 24) +
          (Get.height / 75),
      child: Column(
        children: [
          Container(
            height: Get.height / 24,
            child: Row(
              children: [
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(
                  Icons.remove_outlined,
                  color: ColorUtils.orange,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  subSubGroup.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.mainRed,
                  ),
                ),
              ],
            ),
          ),
          ViewUtils.sizedBox(75),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => buildField(
                subSubGroup.listOfSubItems[index],
              ),
              separatorBuilder: buildSeparator,
              itemCount: subSubGroup.listOfSubItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
