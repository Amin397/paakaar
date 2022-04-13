import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Dist/categories_controller.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class SelectFieldAndGroupScreen extends StatelessWidget {
  final CategoriesController controller = Get.put(CategoriesController());
  final FieldModel? field;

  SelectFieldAndGroupScreen({Key? key,
    this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.goBack();
        return Future.value(false);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: buildBody(),
            width: Get.width,
            height: Get.height,
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Scaffold(
      appBar: WidgetUtils.appBar(
        innerPage: true,
        key: controller.scaffoldKey,
      ),
      drawer: CustomDrawerWidget(),
      key: controller.scaffoldKey,
      backgroundColor: Colors.white,
      // floatingActionButton: showButton!
      //     ? FloatingActionButton.extended(
      //         onPressed: () {
      //           Get.close(1);
      //           Get.back();
      //           Get.toNamed(
      //             RoutingUtils.addCallOut.name,
      //             arguments: {
      //               'field': controller.field,
      //             },
      //           );
      //         },
      //         elevation: 4.0,
      //         focusElevation: 4.0,
      //         disabledElevation: 4.0,
      //         highlightElevation: 4.0,
      //         hoverElevation: 4.0,
      //         backgroundColor: ColorUtils.green,
      //         label: const Text("ثبت فراخوان جدید"),
      //         foregroundColor: Colors.white,
      //         icon: const Icon(
      //           Ionicons.add,
      //         ),
      //       )
      //     : Container(),
      body: Column(
        children: [
          ViewUtils.sizedBox(75),
          const Text(
            "انتخاب تخصص مورد نظر",
            style: TextStyle(
              color: ColorUtils.black,
              fontSize: 18.0,
            ),
          ),
          ViewUtils.sizedBox(),
          buildLastFields(),
          ViewUtils.sizedBox(),
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.isFalse) {
                  return controller.listOfLists.last.isNotEmpty
                      ? AnimationLimiter(
                          child: FRefresh(
                            controller: controller.refreshController,
                            headerHeight: Get.height / 8,
                            header: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Center(
                                child: WidgetUtils.loadingWidget(),
                              ),
                            ),
                            onRefresh: () async {
                              controller.refreshController.finishRefresh();
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listOfLists.last.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: buildField(
                                          controller.listOfLists.last[index]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : WidgetUtils.dataNotFound("اطلاعاتی");
                } else {
                  return WidgetUtils.loadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required int length,
    required String label,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 175),
      decoration: BoxDecoration(
        color: controller.listOfLists.length > length
            ? ColorUtils.orange
            : Colors.white,
        border: Border.all(
          color: ColorUtils.orange,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: controller.listOfLists.length > length
                ? Colors.white
                : ColorUtils.black,
          ),
        ),
      ),
      width: Get.width / 4,
      height: Get.height / 21,
    );
  }

  Widget buildField(FieldModel last) {
    return Container(
      width: Get.width,
      height: Get.height / 16,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ViewUtils.boxShadow(),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            print('================');
            print(last.hasSubCategory);
            print(last.isSpeciality);
            print('================');
            controller.listOfGroups.add(
              last,
            );
            controller.update();
            controller.getNextLevel();
          },
          child: Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Image.network(
              //     last.icon,
              //   ),
              // ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                last.name,
                style: const TextStyle(
                  color: ColorUtils.black,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_right,
                color: ColorUtils.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLastFields() {
    return Container(
      height: Get.height / 24,
      child: GetBuilder(
        init: controller,
        builder: (context) {
          return AnimationLimiter(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: buildLastField,
              itemCount: controller.listOfGroups.length,
            ),
          );
        },
      ),
    );
  }

  Widget buildLastField(BuildContext context, int index) {
    FieldModel field = controller.listOfGroups[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        horizontalOffset: 150.0,
        child: FadeInAnimation(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  controller.deleteLast();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Ionicons.close,
                      color: ColorUtils.mainRed,
                    ),
                    Text(
                      field.name,
                      style: TextStyle(
                        color: ColorUtils.textColor,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: ViewUtils.boxShadow(),
            ),
          ),
        ),
      ),
    );
  }
}
