import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Club/Wallet/NegaWalletController.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/Wallet/UserWallet.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';

class NegaWalletScreen extends StatelessWidget {
  final NegaWalletController negaWalletController = Get.put(
    NegaWalletController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      backgroundColor: ColorUtils.black,
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        text: "نگاوالت",
        icon: Ionicons.wallet_outline,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: this.buildCreditWidget(),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: this.buildScoreWidget(),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => AnimatedSwitcher(
                duration: Duration(milliseconds: 175),
                child: this.negaWalletController.isLoaded.isTrue
                    ? this.buildListView()
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

  Widget buildCreditWidget() {
    return this.buildMainIcon(
      onTap: () {
        // TransitionHelper.push(
        //   context: context,
        //   targetPage: TransactionsWidget(
        //     initialPage: 0,
        //   ),
        // );
      },
      icon: Ionicons.wallet_outline,
      text: ViewUtils.moneyFormat(
            Globals.userStream.user?.credit.toDouble(),
          ) +
          ' تومان',
    );
  }

  Widget buildScoreWidget() {
    return this.buildMainIcon(
      icon: Ionicons.diamond_outline,
      text: 'بزودی',
      isEnabled: false,
    );
  }

  Widget buildMainIcon({
    required IconData icon,
    required String text,
    bool isEnabled = true,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: NeumorphicContainer(
        curveType: CurveType.emboss,
        bevel: 10.0,
        height: Get.height / 8,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: isEnabled
                    ? ColorUtils.yellow
                    : ColorUtils.yellow.withOpacity(0.2),
                size: Get.width / 12,
              ),
              Text(
                text,
                style: TextStyle(
                  color: isEnabled
                      ? ColorUtils.textColor
                      : ColorUtils.inActiveTextColor,
                ),
              ),
            ],
          ),
        ),
        decoration: MyNeumorphicDecoration(
          color: ColorUtils.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemBuilder: (_, int index) => this.buildClubItem(
        this.negaWalletController.listOfUserWallets![index],
      ),
      itemCount: this.negaWalletController.listOfUserWallets?.length,
    );
  }

  Widget buildClubItem(UserWallet wallet) {
    return Material(
      color: ColorUtils.black,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorUtils.yellow,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 12.0),
        height: Get.height / 12,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  wallet.club?.logo ?? '',
                  width: Get.height / 25,
                  height: Get.height / 25,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                (wallet.club?.name ?? '') + ": ",
                style: TextStyle(
                  color: wallet.isRegistered == true
                      ? ColorUtils.textColor
                      : ColorUtils.inActiveTextColor,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                wallet.isRegistered == true
                    ? "${ViewUtils.moneyFormat(
                        double.parse(wallet.user?.credit ?? '0.0'),
                      )} تومان"
                    : "غیر فعال",
                style: TextStyle(
                  fontSize: 12.0,
                  color: ColorUtils.textColor,
                ),
              ),
              Spacer(),
              Icon(
                Ionicons.arrow_back_outline,
                color: wallet.isRegistered == true
                    ? ColorUtils.yellow
                    : ColorUtils.yellow.withOpacity(0.2),
                size: Get.height / 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
