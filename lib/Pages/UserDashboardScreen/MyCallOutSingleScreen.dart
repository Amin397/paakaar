import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Controllers/UserDashboardController/MyCallOutSingleController.dart';
import 'package:paakaar/Models/Calls/ProposalModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/routing_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/custom_drawer_widget.dart';

class MyCallOutSingleScreen extends StatelessWidget {
  final MyCallOutSingleController controller = Get.put(
    MyCallOutSingleController(),
  );
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: this.controller.scaffoldKey,
        appBar: WidgetUtils.appBar(
          innerPage: true,
          key: this.controller.scaffoldKey,
        ),
        drawer: CustomDrawerWidget(),
        body: Padding(
          padding: ViewUtils.scaffoldPadding,
          child: this.buildBody(),
        ),
      ),
    );
  }

  Widget buildProposals() {
    return Obx(
      () => Expanded(
        child: this.controller.isExpertsLoaded.isTrue
            ? GetBuilder(
                init: this.controller,
                builder: (context) {
                  return this.controller.listOfProposals.length > 0
                      ? AnimationLimiter(
                          child: FRefresh(
                            headerHeight: Get.height / 8,
                            header: Container(
                              margin: EdgeInsets.all(8.0),
                              child: Center(
                                child: WidgetUtils.loadingWidget(),
                              ),
                            ),
                            controller:
                                this.controller.proposalRefreshController,
                            onRefresh: () async {
                              await this.controller.getExperts();
                              this
                                  .controller
                                  .proposalRefreshController
                                  .finishRefresh();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    this.controller.listOfProposals.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      child: FadeInAnimation(
                                        child: this.buildProposal(
                                          this
                                              .controller
                                              .listOfProposals[index],
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

  Widget buildProposal(ProposalModel proposal) {
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
          onTap: () => Get.toNamed(
            RoutingUtils.viewProposal.name,
            arguments: {
              'proposal': proposal,
              'callOut': this.controller.callOut,
            },
          ),
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            children: [
              Container(
                width: Get.width / 4,
                height: Get.width / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    proposal.individual.avatar ?? "",
                    width: Get.width / 4,
                    height: Get.width / 4,
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
                    proposal.individual.fullName.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: ColorUtils.black,
                    ),
                  ),
                  Text(
                    proposal.individual.specialities!.length > 0
                        ? proposal.individual.specialities!
                            .map((e) => e.name)
                            .join('٬ ')
                        : '',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
                  Text(
                    proposal.priceType.name.toString() +
                        (proposal.priceType.id == 4
                            ? ""
                            : ' - ' +
                                ViewUtils.moneyFormat(
                                  proposal.price.toDouble(),
                                  toman: true,
                                )),
                    style: TextStyle(
                      fontSize: 11.0,
                      color: ColorUtils.textColor,
                    ),
                  ),
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
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        ViewUtils.sizedBox(),
        Text(
          "پیشنهاد ها برای فرخوان ${this.controller.callOut.name}",
          style: TextStyle(
            color: ColorUtils.black,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        ViewUtils.sizedBox(),
        this.buildProposals(),
      ],
    );
  }
}
