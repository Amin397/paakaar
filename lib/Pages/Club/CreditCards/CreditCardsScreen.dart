import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Controllers/Club/Services/CreditCardsController.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/Services/Cards/CreditCardModel.dart';
import 'package:paakaar/Pages/Club/CreditCards/AddCreditCardScreen.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';
import 'package:paakaar/Widgets/Shared/SinglePageScreen.dart';

class CreditCardsScreen extends StatelessWidget {
  final CreditCardsController creditCardsController = Get.put(
    CreditCardsController(),
  );

  @override
  Widget build(BuildContext context) {
    return SinglePageScreen(
      iconSetForAppBar: WidgetUtils.singlePageAppBar(
        icon: Ionicons.card_outline,
        text: 'کارت',
      ),
      shapeStream: this.creditCardsController.shapeStream.stream,
      body: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Obx(
          () => this.creditCardsController.isSelecting.isTrue
              ? this.deleteFab()
              : this.creditCardsController.listOfCreditCards
                          is List<Rx<CreditCardModel>> &&
                      this.creditCardsController.listOfCreditCards.length < 5
                  ? this.fab()
                  : Container(),
        ),
        body: Column(
          children: [
            Expanded(
              child: this.buildBody(),
            ),
            ViewUtils.sizedBox(12),
          ],
        ),
      ),
    );
  }

  Widget fab() {
    return Material(
      type: MaterialType.transparency,
      child: FloatingActionButton.extended(
        label: Text("افزودن کارت"),
        icon: Icon(Icons.add),
        foregroundColor: Colors.white,
        elevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        disabledElevation: 0.0,
        hoverElevation: 0.0,
        backgroundColor: ColorUtils.yellow,
        onPressed: () {
          if (!Globals.userStream.user!.isNationalCodeSet) {
            // GetNationalCodeDialog.show(context);
            return;
          }
          Get.dialog(
            AddCreditCardScreen(
              // title: "افزودن کارت بانکی",
              // addCard: (CreditCardModel creditCard) {
              //   this
              //       .creditCardsController
              //       .listOfCreditCards
              //       .add(creditCard.obs);
              // },
              creditCardsController: this.creditCardsController,
            ),
            barrierColor: ColorUtils.black.withOpacity(0.1),
          );
        },
      ),
    );
  }

  Widget deleteFab() {
    return FloatingActionButton.extended(
      onPressed: this.creditCardsController.deleteSelectedCards,
      label: Text("حذف"),
      icon: Icon(Icons.delete),
      foregroundColor: Colors.white,
      elevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      disabledElevation: 0.0,
      hoverElevation: 0.0,
      backgroundColor: ColorUtils.red,
    );
  }

  Widget buildBody() {
    return Obx(
      () => AnimatedSwitcher(
        duration: Duration(milliseconds: 175),
        child: this.creditCardsController.isLoaded.isTrue
            ? this.creditCardsController.listOfCreditCards.length > 0
                ? this.buildListView()
                : Center(
                    child: WidgetUtils.dataNotFound("کارتی"),
                  )
            : Center(
                child: WidgetUtils.loadingWidget(),
              ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemBuilder: (_, int index) => this.buildCard(
        this.creditCardsController.listOfCreditCards[index],
      ),
      itemCount: this.creditCardsController.listOfCreditCards.length,
    );
  }

  Widget buildCard(Rx<CreditCardModel> creditCard) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: Get.height / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: ViewUtils.boxShadow(),
            border: this.creditCardsController.isSelecting.isTrue &&
                    creditCard.value.isSelected
                ? Border.all(
                    color: ColorUtils.yellow.withOpacity(0.5),
                    width: 1.5,
                  )
                : null,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onLongPress: () =>
                  this.creditCardsController.onLongPress(creditCard),
              onTap: () => this.creditCardsController.onCardTap(creditCard),
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height / 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width / 8,
                              child: Image.network(
                                creditCard.value.bank.logo,
                              ),
                            ),
                            Container(
                              width: Get.width / 5,
                              margin: EdgeInsets.only(right: 5.0),
                              child: Text(
                                creditCard.value.bank.name.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 75,
                    ),
                    Center(
                      child: Container(
                        width: Get.width / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            creditCard.value.fourthFour,
                            creditCard.value.thirdFour,
                            creditCard.value.secondFour,
                            creditCard.value.firstFour,
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: Get.width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Globals.userStream.user!.fullName,
                          ),
                          Text(
                            creditCard.value.expiration,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 75,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
