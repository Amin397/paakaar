import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Services/request_service_controller.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Pages/RequestService/expert_single_page_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class RequestServiceScreen extends StatelessWidget {
  RequestServiceScreen({Key? key}) : super(key: key);
  final RequestServiceController controller = Get.put(
    RequestServiceController(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: controller.scaffoldKey,
        ),
        drawer: CustomDrawerWidget(),
        key: controller.scaffoldKey,
        floatingActionButton: controller.showAddCallOutButton
            ? FloatingActionButton.extended(
                onPressed: () {
                  // Get.toNamed(
                  //   RoutingUtils.addCallOut.name,
                  //   arguments: {
                  //     'field': controller.field,
                  //   },
                  // );
                  controller.getCanAddCall();
                },
                elevation: 4.0,
                focusElevation: 4.0,
                disabledElevation: 4.0,
                highlightElevation: 4.0,
                hoverElevation: 4.0,
                backgroundColor: ColorUtils.green,
                label: const Text("ثبت فراخوان"),
                foregroundColor: Colors.white,
                icon: const Icon(
                  Ionicons.add,
                ),
              )
            : Container(),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: Column(
            children: [
              ViewUtils.sizedBox(),
              Center(
                child: Text(
                  controller.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: ColorUtils.black,
                  ),
                ),
              ),
              ViewUtils.sizedBox(),
              buildLastFields(),
              ViewUtils.sizedBox(50),
              _buildSelectStateAndCity(),

              ViewUtils.sizedBox(50),
              if (controller.showAddCallOutButton) buildCallOuts(),
              if (!controller.showAddCallOutButton) buildExperts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLastFields() {
    print(controller.listOfGroups.length);
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
            margin: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 2.0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  if (!controller.showAddCallOutButton) {
                    controller.goBack();
                    controller.listOfOptions
                        .removeWhere((element) => !element.isPublic);
                    // controller.refresh();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!controller.showAddCallOutButton)
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

  Widget buildField(FieldModel last) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
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
            controller.listOfGroups.add(
              last,
            );
            controller.update();
            // controller.getNextLevel();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: (Get.width / 16),
                  child: Image.network(
                    last.icon,
                  ),
                ),
              ),
              Text(
                last.name,
                style: const TextStyle(
                  color: ColorUtils.black,
                ),
              ),
              const Icon(
                Icons.arrow_right,
                color: ColorUtils.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExperts() {
    return Obx(
      () => Expanded(
        child: controller.isDataLoaded.isTrue
            ? GetBuilder(
                init: controller,
                builder: (context) {
                  return controller.getListOfExperts.isNotEmpty
                      ? AnimationLimiter(
                          child: FRefresh(
                            headerHeight: Get.height / 8,
                            header: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Center(
                                child: WidgetUtils.loadingWidget(),
                              ),
                            ),
                            controller: controller.expertsRefreshController,
                            onRefresh: () async {
                              await controller.getExperts();
                              controller.expertsRefreshController
                                  .finishRefresh();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.getListOfExperts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      child: FadeInAnimation(
                                        child: buildExpert(
                                          controller.getListOfExperts[index],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : WidgetUtils.dataNotFound("خدمت");
                })
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildExpert(UserModel expert) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: ViewUtils.boxShadow(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: Get.height / 9,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => Get.to(
            () => ExpertSinglePageScreen(
              expert: expert,
              fromChat: false,
            ),
          ),
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6.0,
              ),
              Container(
                width: Get.width * .21,
                height: Get.width * .21,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    expert.avatar ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    expert.fullName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: ColorUtils.black,
                    ),
                  ),
                  Text(
                    expert.fields!.isNotEmpty
                        ? expert.specialities!.map((e) => e.name).join('٬ ')
                        // ? expert.fields!.first.name
                        : '',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
                  (expert.city is CityModel)
                      ? Text(
                          expert.city!.name,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ColorUtils.textColor,
                          ),
                        )
                      : Container(),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                color: ColorUtils.green,
              ),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
    );
  }

  Widget buildCallOuts() {
    return Obx(
      () => Expanded(
        child: controller.isDataLoaded.isTrue
            ? GetBuilder(
                init: controller,
                builder: (context) {
                  return controller.getListOfCallOuts.isNotEmpty
                      ? AnimationLimiter(
                          child: FRefresh(
                            headerHeight: Get.height / 8,
                            header: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Center(
                                child: WidgetUtils.loadingWidget(),
                              ),
                            ),
                            controller: controller.callOutsRefreshController,
                            onRefresh: () async {
                              await controller.getCallOuts(refresh: true);
                              controller.callOutsRefreshController
                                  .finishRefresh();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.getListOfCallOuts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      child: FadeInAnimation(
                                        child: buildCallOut(
                                          controller.getListOfCallOuts[index],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : WidgetUtils.dataNotFound("فراخوانی");
                })
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildCallOut(CallModel call) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: ViewUtils.boxShadow(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: Get.height / 9,
      width: Get.width,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => Get.toNamed(
            RoutingUtils.callOutSingle.name,
            arguments: {
              'callOut': call,
            },
          ),
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              Container(
                width: Get.width * .21,
                height: Get.width * .21,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    call.cover,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: Get.height * .05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    call.name,
                                    maxLines: 2,
                                    minFontSize: 10.0,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width / 5,
                              height: Get.height / 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: ColorUtils.mainRed,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: call.isAccepted
                                    ? [
                                        const Text(
                                          'استخدام شد!',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]
                                    : [
                                        Text(
                                          "پیشنهادات:",
                                          style: TextStyle(
                                            fontSize: 9.0,
                                            color: Colors.white.withOpacity(0.7),
                                          ),
                                        ),
                                        Text(
                                          call.proposeCount.toString(),
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (Get.width) -
                            (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                        child: Text(
                          call.day,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ColorUtils.textColor,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: (Get.width) -
                      //       (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                      //   child: Text(
                      //     call.individual?.fullName ?? '',
                      //     overflow: TextOverflow.ellipsis,
                      //     textDirection: TextDirection.rtl,
                      //     style: TextStyle(
                      //       fontSize: 11.0,
                      //       color: ColorUtils.textColor,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: (Get.width) -
                            (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                        child: Text(
                          call.state.name + ' - ' + call.city.name,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ColorUtils.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
                height: double.maxFinite,
                child: Icon(
                  Icons.arrow_right,
                  color: ColorUtils.green,
                ),
              ),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
    );
  }

  Widget buildSearchAndFilters() {
    return Row(
      children: [
        const SizedBox(
          width: 8.0,
        ),
        GestureDetector(
          onTap: () => controller.getFilters(),
          child: Container(
            height: Get.height / 18,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Ionicons.filter,
                    color: ColorUtils.green.shade900,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: ColorUtils.green.shade900.withOpacity(0.6),
                width: 1,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
      ],
    );
  }

  Widget _buildSelectStateAndCity() {
    // return GestureDetector(
    //   onTap: () => controller.getCityAndState(),
    //   child: Container(
    //     height: Get.height / 18,
    //     child: Padding(
    //       padding:  EdgeInsets.symmetric(horizontal: 8.0),
    //       child: Row(
    //         children: [
    //           Icon(
    //             Ionicons.location_outline,
    //             color: ColorUtils.orange.shade900,
    //           ),
    //         ],
    //       ),
    //     ),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.0),
    //       border: Border.all(
    //         color: ColorUtils.orange.shade900.withOpacity(0.6),
    //         width: 1,
    //       ),
    //     ),
    //   ),
    // );
    // }
    return Obx(
      () => controller.isStatesLoaded.isTrue
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder(
                      init: controller,
                      builder: (ctx) => Expanded(
                        child: WidgetUtils.selectOptions(
                          title: "انتخاب استان",
                          controller: controller,
                          items: controller.listOfStates,
                          isActive: (elem) => elem.isSelected,
                          displayFormat: displayStates,
                          makeActive: controller.makeStateActive,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: GetBuilder(
                        init: controller,
                        builder: (ctx) => WidgetUtils.selectOptions(
                          title: "انتخاب شهر",
                          controller: controller,
                          enabled: controller.listOfStates
                              .any((element) => element.isSelected),
                          errorMessage: "لطفا ابتدا استان را انتخاب کنید",
                          items: controller.listOfStates
                                  .any((element) => element.isSelected)
                              ? controller.listOfStates
                                  .singleWhere((element) => element.isSelected)
                                  .listOfCities
                              : [],
                          isActive: (elem) => elem.isSelected,
                          displayFormat: displayCity,
                          makeActive: controller.makeCityActive,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    // (controller.showAddCallOutButton)?buildSearchAndFilters():Container(),
                    (controller.showAddCallOutButton)?Container():Container(),

                    (controller.showAddCallOutButton)
                        ? Container()
                        : GestureDetector(
                            onTap: () => controller.getFilters(),
                            child: Container(
                              height: Get.height * .045,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.filter,
                                      color: ColorUtils.green.shade900,
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: ColorUtils.green.shade900
                                      .withOpacity(0.6),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),

                GetBuilder(
                  init: controller,
                  builder: (ctx) {
                    if (controller.listOfDistricts.isNotEmpty) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: WidgetUtils.selectOptions(
                                  title: "انتخاب محدوده",
                                  unFocus: controller.unFocus,
                                  controller: controller,
                                  items: controller.listOfDistricts,
                                  isActive: (elem) => elem.isSelected,
                                  displayFormat: displayDistrict,
                                  makeActive: controller.makeDistrictActive,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            )
          : WidgetUtils.loadingWidget(),
    );
  }

  String displayStates(p1) {
    return p1.name;
  }

  String displayCity(p1) {
    return p1.name;
  }

  String displayDistrict(p1) {
    return p1.name;
  }
}
