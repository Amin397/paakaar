import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:paakaar/Controllers/Club/Providers/ProviderListController.dart';
import 'package:paakaar/Models/Club/CasteModel.dart';
import 'package:paakaar/Models/Club/ProviderModel.dart';
import 'package:paakaar/Models/Club/WorkGroupModel.dart';
import 'package:paakaar/Pages/Club/Providers/Providers/single_provider_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/loadmore/loadmore.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';

class ProviderListScreen extends StatelessWidget {
  late ProviderListController providerListController;
  final CasteModel caste;
  final WorkGroupModel workGroup;

  ProviderListScreen({
    Key? key,
    required this.caste,
    required this.workGroup,
  }) {
    this.providerListController = Get.put(
      ProviderListController(
        this.workGroup,
        this.caste,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        text: this.caste.name,
        icon: this.workGroup.icon,
        changeColor: true,
      ),
      backgroundColor: ColorUtils.black,
      body: Column(
        children: [
          WidgetUtils.neuSearchField(
            onChange: this.providerListController.onChange,
          ),
          ViewUtils.sizedBox(),
          Expanded(
            child: Obx(
              () => AnimatedSwitcher(
                duration: Duration(milliseconds: 175),
                child: this.providerListController.isLoaded.isTrue
                    ? this.buildItems()
                    : Center(
                        child: WidgetUtils.loadingWidget(),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItems() {
    return Obx(
      () => LoadMore(
        isFinish: this.providerListController.listOfProviders!.length >=
            this.providerListController.totalCount,
        onLoadMore: () async {
          this.providerListController.page++;
          await this.providerListController.getProviders();
          return true;
        },
        textBuilder: (LoadMoreStatus state) {
          switch (state) {
            case LoadMoreStatus.nomore:
              return 'اطلاعات دیگری موجود نیست!';
            case LoadMoreStatus.idle:
              break;
            case LoadMoreStatus.loading:
              return 'در حال بارگذاری';

              break;
            case LoadMoreStatus.fail:
              return 'خطایی رخ داد';

              break;
          }
          return 'در حال بارگذاری';
        },
        child: ListView.builder(
          controller: this.providerListController.scrollController,
          physics: this.providerListController.isLoading.isTrue
              ? NeverScrollableScrollPhysics()
              : BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            return this.providerListController.isLoaded.isTrue
                ? this._buildMainItem(
                    provider: this.providerListController.getList[index],
                    index: index,
                  )
                : this.buildShimmer();
          },
          itemCount: this.providerListController.isLoaded.isTrue
              ? this.providerListController.getList.length
              : 9,
        ),
      ),
    );
  }

  Widget _buildMainItem({
    required ProviderModel provider,
    required int index,
  }) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 175),
      delay: Duration.zero,
      child: SlideAnimation(
        horizontalOffset: 75.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              Get.to(
                () => SingleProviderScreen(
                  provider: provider,
                  workGroup: this.workGroup,
                  caste: this.caste,
                ),
              );
              // TransitionHelper.push(
              //   context: context,
              //   targetPage: SingleProviderScreen(
              //     provider: provider,
              //     workGroup: this.widget.workGroup,
              //     caste: this.widget.caste,
              //   ),
              // );
            },
            child: NeumorphicContainer(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
              height: Get.height / 9,
              decoration: MyNeumorphicDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              bevel: 18.0,
              curveType: CurveType.emboss,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width / 25,
                  ),
                  Container(
                    width: Get.width / 7,
                    height: Get.width / 7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        provider.avatar.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        provider.name,
                        textAlign: TextAlign.center,
                        minFontSize: 2.0,
                        maxLines: 1,
                        style: TextStyle(
                          height: 1.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 100,
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            '%' + provider.discountPercent,
                            textAlign: TextAlign.center,
                            minFontSize: 2.0,
                            maxFontSize: 14.0,
                            maxLines: 1,
                            style: TextStyle(
                              height: 1.6,
                              fontSize: 14.0,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 100,
                          ),
                          AutoSizeText(
                            'درصد تخفیف نقدی',
                            textAlign: TextAlign.center,
                            minFontSize: 2.0,
                            maxFontSize: 12.0,
                            maxLines: 1,
                            style: TextStyle(
                              height: 1.6,
                              fontSize: 12.0,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Ionicons.arrow_back,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: Get.width / 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildShimmer() {
    return NeumorphicContainer(
      width: Get.width,
      height: Get.height * .1,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .015,
      ),
      decoration: MyNeumorphicDecoration(
        color: ColorUtils.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      curveType: CurveType.emboss,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Shimmer.fromColors(
              period: Duration(milliseconds: 500),
              baseColor: ColorUtils.yellow.withOpacity(0.7),
              highlightColor: ColorUtils.yellow.withOpacity(0.2),
              child: Icon(
                Ionicons.storefront_outline,
              ),
            ),
            Shimmer.fromColors(
              period: Duration(milliseconds: 500),
              baseColor: ColorUtils.yellow.withOpacity(0.7),
              highlightColor: ColorUtils.yellow.withOpacity(0.2),
              child: AutoSizeText(
                "در حال بارگزاری...",
                minFontSize: 2.0,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
