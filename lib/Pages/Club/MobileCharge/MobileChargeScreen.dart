import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paakaar/Controllers/Club/Services/MobileChargeController.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/Services/Charge/MobileChargeModel.dart';
import 'package:paakaar/Models/Club/Services/Charge/OperatorModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';

class MobileChargeScreen extends StatelessWidget {
  final MobileChargeController mobileChargeController = Get.put(
    MobileChargeController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: Icons.sim_card_outlined,
        text: "خرید شارژ",
      ),
      shapeStream: this.mobileChargeController.shapeStream.stream,
      body: this.buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          height: Get.height / 8,
          width: Get.width,
          decoration: BoxDecoration(
            boxShadow: ViewUtils.boxShadow(
              blurRadius: 8.0,
              spreadRadius: 8.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Obx(
              () => AnimatedSwitcher(
                duration: Duration(milliseconds: 150),
                child: this.mobileChargeController.isLoaded.isTrue
                    ? this.buildList()
                    : ViewUtils.circularProgressIndicator(),
              ),
            ),
          ),
        ),
        ViewUtils.sizedBox(
          25,
        ),
        this.buildMobileField(),
        ViewUtils.sizedBox(
          25,
        ),
        this.buildAmountWidget(),
        Spacer(),
        SafeArea(
          child: WidgetUtils.button(
            text: "خرید شارژ",
            onTap: () => this.mobileChargeController.submit(),
          ),
        ),
      ],
    );
  }

  Widget _buildChargeAmountContainer(Rx<MobileChargeModel> mobileCharge) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: GestureDetector(
          onTap: () {
            this.mobileChargeController.listOfChargeAmounts.forEach((element) {
              element.value.isSelected = false;
              element.refresh();
            });
            mobileCharge.value.isSelected = true;
            mobileCharge.refresh();
            this.mobileChargeController.amountPageController.animateToPage(
                  this
                      .mobileChargeController
                      .listOfChargeAmounts
                      .indexOf(mobileCharge),
                  duration: Duration(milliseconds: 175),
                  curve: Curves.easeIn,
                );
            this.mobileChargeController.chargeAmountController.text =
                ViewUtils.moneyFormat(mobileCharge.value.amount);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: Get.height * .05,
            width: Get.width * .3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: (mobileCharge.value.isSelected)
                  ? ColorUtils.orange
                  : Colors.white,
              border: Border.all(
                color: (mobileCharge.value.isSelected)
                    ? Colors.transparent
                    : ColorUtils.black,
                width: 0.2,
              ),
            ),
            child: Center(
              child: AutoSizeText(
                ViewUtils.moneyFormat(mobileCharge.value.amount) + ' تومان ',
                style: TextStyle(
                  fontSize: 16.0,
                  color: (mobileCharge.value.isSelected)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAmountWidget() {
    return Obx(
      () => AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        duration: Duration(milliseconds: 120),
        child: this.mobileChargeController.isLoaded.isTrue &&
                this.mobileChargeController.listOfOperators.length > 0 &&
                this
                    .mobileChargeController
                    .listOfOperators
                    .singleWhere((element) => element.value.isSelected)
                    .value
                    .askAmount
            ? Container(
                width: Get.width,
                height: Get.height / 18,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: this.mobileChargeController.onAmountChanged,
                  physics: BouncingScrollPhysics(),
                  controller: this.mobileChargeController.amountPageController,
                  itemCount:
                      this.mobileChargeController.listOfChargeAmounts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildChargeAmountContainer(
                      this.mobileChargeController.listOfChargeAmounts[index],
                    );
                  },
                ),
              )
            : Center(
                child: WidgetUtils.textField(
                  heightFactor: 18,
                  controller:
                      this.mobileChargeController.chargeAmountController,
                  textAlign: TextAlign.center,
                  backgroundColor: Colors.white,
                  title: "مبلغ",
                  price: true,
                ),
              ),
      ),
    );
  }

  Widget buildMobileField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                this.mobileChargeController.mobileController.text =
                    Globals.userStream.user!.mobile!;
              },
              child: Icon(
                Icons.sim_card_outlined,
                size: Get.width / 12,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
            SizedBox(
              width: Get.width / 40,
            ),
            GestureDetector(
              onTap: () {
                // contactListModal();
              },
              child: Icon(
                Icons.contacts_outlined,
                size: Get.width / 12,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
        SizedBox(
          width: Get.width / 25,
        ),
        Flexible(
          child: _phoneTextField(),
        ),
      ],
    );
  }

  void onChange(String string) {
    List<String> list = string.split('');
    if (list.length > 0) {
      switch (list.length) {
        case 1:
          if (list[0] == '0') {
            this.mobileChargeController.mobileController.text = '0';
          } else {
            this.mobileChargeController.mobileController.clear();
          }
          break;
        case 2:
          if (list[1] == '9') {
            this.mobileChargeController.mobileController.text = '09';
          } else {
            this.mobileChargeController.mobileController.text = '0';
          }

          break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
          list.removeAt(0);
          list.removeAt(0);
          this.mobileChargeController.mobileController.text =
              '09' + list.join('');
          break;
      }
      Future.delayed(
        Duration.zero,
        () => this.mobileChargeController.mobileController.selection =
            TextSelection.fromPosition(
          TextPosition(
            offset: this.mobileChargeController.mobileController.text.length,
          ),
        ),
      );

      if (this.mobileChargeController.mobileController.text.length == 11) {
        FocusScope.of(Get.context!).unfocus();
      }
    }
  }

  Widget _phoneTextField() {
    return Container(
      height: Get.height / 18,
      child: WidgetUtils.textField(
        title: "موبایل",
        textAlign: TextAlign.center,
        backgroundColor: Colors.white,
        controller: this.mobileChargeController.mobileController,
        formatter: [
          LengthLimitingTextInputFormatter(11),
        ],
      ),
    );
  }

  Widget buildList() {
    return PageView.builder(
      onPageChanged: this.mobileChargeController.onPageChanged,
      controller: mobileChargeController.pageController,
      itemCount: this.mobileChargeController.listOfOperators.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) => this.buildOperator(
        this.mobileChargeController.listOfOperators[index],
      ),
    );
  }

  Widget buildOperator(Rx<OperatorModel> operator) {
    return Obx(
      () => GestureDetector(
        onTap: () => this.mobileChargeController.pageController.animateToPage(
              this.mobileChargeController.listOfOperators.indexOf(operator),
              duration: Duration(milliseconds: 175),
              curve: Curves.easeIn,
            ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 175),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: operator.value.isSelected ? ColorUtils.black : Colors.white,
            boxShadow: ViewUtils.boxShadow(
              spreadRadius: operator.value.isSelected ? 8.0 : 3.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                operator.value.logo,
                color: operator.value.isSelected ? ColorUtils.yellow : null,
                width: Get.width / 7,
                height: Get.width / 7,
              ),
              Text(
                operator.value.name,
                style: TextStyle(
                  color: !operator.value.isSelected
                      ? ColorUtils.black
                      : Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
