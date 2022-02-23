import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/Scores/Model/score_model.dart';
import 'package:paakaar/Pages/Scores/VIew/Widgets/score_modal_view.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class MyScoreController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FRefreshController scoresRefreshController = FRefreshController();

  final ProjectRequestUtils requests = ProjectRequestUtils.instance;
  late List<ScoreModel> listOfScores;
  RxBool isCallOutsLoaded = false.obs;

  bool isDeleting = false;


  void getScore1()async {
    ApiResult result = await requests.getDashboardScore();
    if(result.isDone){
      Globals.userStream.setUserScore(result.data);
    }
  }

  getScore() async {
    ApiResult result = await requests.getScore();

    if (result.isDone) {
      listOfScores = ScoreModel.listFromJson(result.data);
      isCallOutsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  @override
  void onInit() {
    getScore();
    getScore1();
    super.onInit();
  }

  void showModal() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => ScoreModalView(
        myScoreController: this,
      ),
    );
  }
}
