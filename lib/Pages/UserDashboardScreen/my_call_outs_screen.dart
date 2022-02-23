import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Controllers/UserDashboardController/my_call_outs_controller.dart';
import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class MyCallOutsScreen extends StatelessWidget {
  MyCallOutsScreen({Key? key}) : super(key: key);
  final MyCallOutsController controller = Get.put(
    MyCallOutsController(),
  );

  Widget buildFab() {
    return FloatingActionButton(
      onPressed: () => controller.deleteCalls(),
      child: const Icon(
        Icons.delete_outline,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: GetBuilder(
          init: controller,
          builder: (_) => controller.isDeleting ? buildFab() : Container(),
        ),
        backgroundColor: Colors.white,
        key: controller.scaffoldKey,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: controller.scaffoldKey,
        ),
        drawer: CustomDrawerWidget(),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildCallOuts() {
    return Obx(
      () => Expanded(
        child: controller.isCallOutsLoaded.isTrue
            ? GetBuilder(
                init: controller,
                builder: (context) {
                  return controller.listOfCallOuts.isNotEmpty
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
                              await controller.getCallOuts();
                              controller.callOutsRefreshController
                                  .finishRefresh();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.listOfCallOuts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      child: FadeInAnimation(
                                        child: buildCallOut(
                                          controller.listOfCallOuts[index],
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
        border: Border.all(
          color: call.isDeleting ? ColorUtils.mainRed : Colors.white,
          width: 0.5,
        ),
      ),
      height: Get.height / 9,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onLongPress: () {
            controller.enterDeletingMode(call);
          },
          onTap: () {
            if (controller.isDeleting) {
              call.isDeleting = !call.isDeleting;
              controller.isDeleting = controller.listOfCallOuts
                  .any((element) => element.isDeleting);
              controller.update();
              return;
            }
            Get.toNamed(
              RoutingUtils.myCallOutSingle.name,
              arguments: {
                'callOut': call,
                'isRating': call.isAccepted,
              },
            );
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: Get.width / 4,
                  height: Get.width / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      call.cover,
                      width: Get.width / 4,
                      height: Get.width / 4,
                      fit: BoxFit.cover,
                    ),
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 20.0,
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
                                    maxLines: 1,
                                    maxFontSize: 16.0,
                                    minFontSize: 12.0,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    CallModel.getStatus(call.status),
                                    style: const TextStyle(
                                      fontSize: 12.0,
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
                      if (!call.isAccepted) ...[
                        SizedBox(
                          width: (Get.width) -
                              (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                          child: Text(
                            "پیشنهادی های ارسالی: ${call.proposeCount}",
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: ColorUtils.textColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (Get.width) -
                              (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                          child: Text(
                            "پیشنهادی های خوانده نشده: ${call.unReadProposalCount}",
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: ColorUtils.mainRed,
                            ),
                          ),
                        ),
                      ],
                      if (call.isAccepted) ...[
                        SizedBox(
                          width: (Get.width) -
                              (8.0 + (Get.width / 4) + 16 + Get.width / 4),
                          child: Text(
                            "استخدام شد!",
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: ColorUtils.green.shade900,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
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

  Widget buildBody() {
    return Column(
      children: [
        ViewUtils.sizedBox(),
        const Text(
          "فراخوان های من",
          style: TextStyle(
            color: ColorUtils.black,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        ViewUtils.sizedBox(),
        buildCallOuts(),
      ],
    );
  }
}
