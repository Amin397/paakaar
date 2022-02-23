import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Pages/AllAds/Controller/all_ads_controller.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class GetCategoriesDialog extends StatelessWidget {
  GetCategoriesDialog({Key? key, this.allAdsController}) : super(key: key);
  AllAdsController? allAdsController;

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
                    allAdsController!.selectField();
                    allAdsController!.unFocus();
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
      () => allAdsController!.isFieldsLoaded.value == true
          ? GetBuilder(
              init: allAdsController as GetxController,
              builder: (context) {
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: allAdsController!.listOfFields.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: buildOptionItem(
                              allAdsController!.listOfFields[index],
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

  Widget buildOptionItem(FieldModel model) {
    return GetBuilder(
      init: allAdsController,
      builder: (context){
        return AnimatedContainer(
          duration: const Duration(milliseconds: 270),
          margin: const EdgeInsets.symmetric(
            vertical: 6.0,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onLongPress: ()=>allAdsController!.removeFilter(),
              onTap: () => allAdsController!.setFieldItem(
                item: model,
              ),
              // onLongPress: () {
              //   model.forEach((element) {
              //     element.isSelected.value = false;
              //   });
              //   allAdsController!.update();
              // },
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(model.name , style: TextStyle(
                  color: (model.isSelected.value)?Colors.white:ColorUtils.black
                ),),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: (model.isSelected.value)?ColorUtils.myRed:Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: ViewUtils.boxShadow(),
          ),
        );
      },
    );
  }
}
