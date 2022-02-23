import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Models/Calls/ProposalModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';

class MyCallOutSingleController extends GetxController {
  late List<ProposalModel> listOfProposals;
  RxBool isExpertsLoaded = false.obs;
  bool isRating = false;
  final ProjectRequestUtils requests = ProjectRequestUtils.instance;
  late CallModel callOut;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FRefreshController proposalRefreshController = FRefreshController();
  @override
  void onInit() {
    this.callOut = Get.arguments['callOut'];
    this.isRating = Get.arguments['isRating'];
    this.getExperts();
    super.onInit();
  }

  Future<void> getExperts() async {
    this.isExpertsLoaded.value = false;
    ApiResult result = await this.requests.getCallOutProposals(
          this.callOut.id,
        );
    if (result.isDone) {
      this.listOfProposals = ProposalModel.listFromJson(
        result.data,
      );
      if (this.isRating) {
        Get.offAndToNamed(
          RoutingUtils.viewProposal.name,
          arguments: {
            'proposal': this.listOfProposals.first,
            'isRating': this.isRating,
            'callOut': this.callOut,
          },
        );
        return;
      }
      this.isExpertsLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }
}
