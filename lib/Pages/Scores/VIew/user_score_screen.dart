import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/Scores/Controller/my_score_controller.dart';
import 'package:paakaar/Pages/Scores/Model/score_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class UserScoreScreen extends StatelessWidget {
  UserScoreScreen({Key? key}) : super(key: key);
  MyScoreController myScoreController = Get.put(MyScoreController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // floatingActionButton: GetBuilder(
        //   init: myScoreController,
        //   builder: (_) =>
        //       myScoreController.isDeleting ? buildFab() : Container(),
        // ),
        backgroundColor: Colors.white,
        key: myScoreController.scaffoldKey,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: myScoreController.scaffoldKey,
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
        child: myScoreController.isCallOutsLoaded.isTrue
            ? GetBuilder(
                init: myScoreController,
                builder: (context) {
                  return myScoreController.listOfScores.isNotEmpty
                      ? AnimationLimiter(
                          child: FRefresh(
                            headerHeight: Get.height / 8,
                            header: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Center(
                                child: WidgetUtils.loadingWidget(),
                              ),
                            ),
                            controller:
                                myScoreController.scoresRefreshController,
                            onRefresh: () async {
                              await myScoreController.getScore();
                              myScoreController.scoresRefreshController
                                  .finishRefresh();
                            },
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: myScoreController.listOfScores.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                    child: FadeInAnimation(
                                      child: _buildScores(
                                        myScoreController.listOfScores[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            ),
                          ),
                        )
                      : WidgetUtils.dataNotFound("پیشنهادی");
                },
              )
            : WidgetUtils.loadingWidget(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        ViewUtils.sizedBox(),
        const Text(
          "امتیاز های من",
          style: TextStyle(
            color: ColorUtils.black,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        ViewUtils.sizedBox(),
        buildCallOuts(),
        ViewUtils.sizedBox(),
        Container(
          height: Get.height * .05,
          width: Get.width,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              'مجموع امتیازات:',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: Globals.userStream.getStream,
                        builder: (BuildContext context, i) => Flexible(
                          flex: 1,
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  Globals.userStream.user!.score.toString(),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * .025,
                                ),
                                AutoSizeText(
                                  'امتیاز',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorUtils.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * .05,
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    myScoreController.showModal();
                  },
                  child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: ColorUtils.myRed,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: AutoSizeText(
                        'شرکت در طرح های امتیازی',
                        maxLines: 1,
                        maxFontSize: 14.0,
                        minFontSize: 10.0,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ViewUtils.sizedBox(),
      ],
    );
  }

  _buildScores(ScoreModel? item) {
    return Container(
      height: Get.height * .1,
      width: Get.width,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .01,
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                          item!.type!.name,
                          style: TextStyle(
                            color: ColorUtils.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.time_outline,
                                    color: ColorUtils.myRed,
                                    size: 18.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      child: Center(
                                        child: AutoSizeText(
                                          item.time,
                                          style: TextStyle(
                                            color: ColorUtils.textColor,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.calendar_outline,
                                    color: ColorUtils.myRed,
                                    size: 18.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      child: Center(
                                        child: AutoSizeText(
                                          item.date,
                                          style: TextStyle(
                                            color: ColorUtils.textColor,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeText(
                    item.amount.toString(),
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .025,
                  ),
                  AutoSizeText(
                    'امتیاز',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
