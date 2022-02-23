import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paakaar/Models/Calls/call_model.dart';
import 'package:paakaar/Models/Calls/ProposalModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';

class ViewProposalController extends GetxController {
  late ProposalModel proposal;
  late CallModel callOut;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isRating = false;
  @override
  void onInit() {
    this.proposal = Get.arguments['proposal'];
    this.callOut = Get.arguments['callOut'];
    this.isRating = Get.arguments['isRating'] ?? false;
    this.readProposal();
    super.onInit();
  }

  void unFocus() {
    Focus.of(Get.context!).requestFocus(FocusNode());
  }

  void acceptProposal() async {
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.acceptProposal(
      proposalId: this.proposal.id,
      callOutId: this.callOut.id,
    );
    EasyLoading.dismiss();

    if (result.isDone) {
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      ViewUtils.showSuccessDialog(
        result.data.toString(),
      );
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  void readProposal() async {
    ApiResult result = await ProjectRequestUtils.instance.readProposal(
      proposalId: this.proposal.id,
      callOutId: this.callOut.id,
    );
  }

  void saveComment(Map<String, dynamic> map) async {
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.saveComment(
      rate: map['rate'],
      comment: map['comment'],
      targetId: this.proposal.individual.id!,
      proposalId: this.proposal.id,
    );
    EasyLoading.dismiss();

    if (result.isDone) {
      ViewUtils.showSuccessDialog(
        result.data.toString(),
      );
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }
}
