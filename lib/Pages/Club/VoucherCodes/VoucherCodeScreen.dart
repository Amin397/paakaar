import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:frefresh/frefresh.dart';
import 'package:paakaar/Controllers/Club/Services/VoucherCodeController.dart';
import 'package:paakaar/Models/Club/Services/VoucherCodes/VoucherCodeProviderModel.dart';
import 'package:paakaar/Pages/Club/VoucherCodes/Widgets/VoucherCodeInfo.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';

class VoucherCodeScreen extends StatelessWidget {
  final VoucherCodeController voucherCodeController =
      Get.put(VoucherCodeController());
  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: FeatherIcons.code,
        text: "تخفیف ها",
      ),
      body: Column(
        children: [
          WidgetUtils.singlePageTextField(
            onChange: this.voucherCodeController.onSearch,
          ),
          Expanded(
            child: Obx(
              () => this.voucherCodeList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget voucherCodeList() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 175),
      child: this.voucherCodeController.isLoaded.isTrue
          ? this.voucherCodeController.getList!.length > 0
              ? FRefresh(
                  footerBuilder: (setter) {
                    return Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation(
                            ColorUtils.yellow,
                          ),
                        ),
                      ),
                    );
                  },
                  onLoad: () async {
                    this.voucherCodeController.page++;
                    // await this.getVoucherCodes();
                    this.voucherCodeController.refreshController.finishLoad();
                  },
                  footerHeight: 100.0,
                  controller: this.voucherCodeController.refreshController,
                  child: AnimationLimiter(
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: this.voucherCodeController.getList!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        color: ColorUtils.yellow,
                        thickness: 1.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 375),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: this.voucherCodeProviderBuilder(
                                this.voucherCodeController.getList![index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: WidgetUtils.dataNotFound("کد تخفیف"),
                  ),
                )
          : Center(
              child: SizedBox(
                height: Get.width / 1,
                width: Get.width / 1,
                child: WidgetUtils.loadingWidget(),
              ),
            ),
    );
  }

  Widget voucherCodeProviderBuilder(VoucherCodeProviderModel provider) {
    return GestureDetector(
      onTap: () {
        // showModalBottomSheet(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return FlightInfoModal(
        //       flight: float,
        //     );
        //   },
        // );

        // if (!VisitorBlocInstance.customer.card) {
        //   ViewHelper.showCardDialog(context);
        //   return;
        // }
        this.getVoucherCodeInfo(provider);
      },
      child: WidgetUtils.blurWidget(
        child: Container(
          width: Get.width,
          height: Get.height / 12,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: Get.height / 12,
                                height: Get.height / 12,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    provider.logo!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                provider.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                width: Get.width / 3,
                                child: Text(
                                  provider.description.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width / 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: Get.height / 36,
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  color: ColorUtils.yellow,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 10.0,
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    provider.percent.toString() + '% تخفیف',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0),
        ),
      ),
    );
  }

  String formatDate(var departure) {
    return departure.formatter.yyyy +
        '-' +
        departure.formatter.mm +
        '-' +
        departure.formatter.dd;
  }

  void getVoucherCodeInfo(VoucherCodeProviderModel provider) {
    Get.dialog(
      VoucherCodeInfoDialog(
        codeProvider: provider,
        reset: () {
          // this.voucherCodeController.listOfVoucherCodeProviders = null;
          this.voucherCodeController.getVoucherCodes();
        },
      ),
    );
  }
}
