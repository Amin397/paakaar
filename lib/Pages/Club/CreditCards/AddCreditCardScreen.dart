import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paakaar/Controllers/Club/Services/CreditCardsController.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/color_utils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:paakaar/Utils/widget_utils.dart';

class AddCreditCardScreen extends StatelessWidget {
  final CreditCardsController creditCardsController;

  AddCreditCardScreen({
    Key? key,
    required this.creditCardsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12.0,
        ),
        child: Column(
          children: [
            this.cardBuilder(),
            ViewUtils.sizedBox(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: ViewUtils.boxShadow(),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      this.header(),
                      SizedBox(
                        height: Get.height / 15,
                      ),
                      this.body(),
                      Spacer(),
                      WidgetUtils.button(
                        onTap: () => this.creditCardsController.addCard(),
                        text: "افزودن کارت",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            WidgetUtils.closeButton(),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'افزودن کارت',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget body() {
    return Column(
      children: [
        this.cardNumber(),
        SizedBox(
          height: Get.width / 30,
        ),
        Row(
          children: [
            Expanded(child: this.cvv2()),
            SizedBox(
              width: Get.width / 15,
            ),
            Expanded(child: this.expireDate()),
          ],
        ),
      ],
    );
  }

  Widget cardBuilder() {
    return Container(
      height: Get.height / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: ViewUtils.boxShadow(),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: Get.height / 5,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: this.creditCardsController.isBankLoaded.isTrue
              ? BoxDecoration(
                  gradient: this.creditCardsController.isColorLoaded.isTrue
                      ? LinearGradient(
                          colors: [
                            this
                                .creditCardsController
                                .bank!
                                .paletteGenerator!
                                .paletteColors
                                .first
                                .color
                                .withOpacity(0.3),
                            this
                                .creditCardsController
                                .bank!
                                .paletteGenerator!
                                .paletteColors
                                .first
                                .color
                                .withOpacity(0.1),
                          ],
                        )
                      : null,
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.0),
                )
              : BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.0),
                ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => this
                                      .creditCardsController
                                      .isBankLoaded
                                      .isTrue
                                  ? Container(
                                      width: Get.width / 8,
                                      child: Image.network(
                                        this.creditCardsController.bank!.logo,
                                      ),
                                      height: Get.height / 25,
                                    )
                                  : Container(
                                      width: Get.width / 8,
                                      height: Get.height / 25,
                                    ),
                            ),
                            Container(
                              width: Get.width / 5,
                              margin: EdgeInsets.only(right: 5.0),
                              child: Text(
                                " ",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 25,
                    ),
                    Center(
                      child: Container(
                        width: Get.width / 1.2,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              this.textWidget(
                                "${this.creditCardsController.cardNumberController.value.text.length > 0 ? this.creditCardsController.cardNumberController.value.text.characters.first : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 1 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[1] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 2 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[2] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 3 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[3] : '-'}",
                              ),
                              this.textWidget(
                                "${this.creditCardsController.cardNumberController.value.text.length > 4 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[4] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 5 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[5] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 6 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[6] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 7 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[7] : '-'}",
                              ),
                              this.textWidget(
                                "${this.creditCardsController.cardNumberController.value.text.length > 8 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[8] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 9 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[9] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 10 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[10] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 11 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[11] : '-'}",
                              ),
                              this.textWidget(
                                "${this.creditCardsController.cardNumberController.value.text.length > 12 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[12] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 13 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[13] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 14 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[14] : '-'}"
                                " ${this.creditCardsController.cardNumberController.value.text.length > 15 ? this.creditCardsController.cardNumberController.value.text.characters.toList()[15] : '-'}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                    Center(
                      child: Container(
                        width: Get.width / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Globals.userStream.user!.fullName,
                            ),
                            Text(
                              '${this.creditCardsController.expDateYearController.value.text.length > 0 ? this.creditCardsController.expDateYearController.value.text.characters.toList()[0] : '-'}'
                              '${this.creditCardsController.expDateYearController.value.text.length > 1 ? this.creditCardsController.expDateYearController.value.text.characters.toList()[1] : '-'}'
                              '/'
                              '${this.creditCardsController.expDateMouthController.value.text.length > 0 ? this.creditCardsController.expDateMouthController.value.text.characters.toList()[0] : '-'}'
                              '${this.creditCardsController.expDateMouthController.value.text.length > 1 ? this.creditCardsController.expDateMouthController.value.text.characters.toList()[1] : '-'}',
                            ),
                          ],
                        ),
                      ),
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

  Widget textWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        letterSpacing: 2.0,
        fontSize: 21.0,
        color: Colors.black,
      ),
    );
  }

  Widget cardNumber() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "شماره کارت",
        labelText: "شماره کارت",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorUtils.yellow,
          ),
        ),
        labelStyle: TextStyle(
          color: ColorUtils.black.withOpacity(0.5),
        ),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        letterSpacing:
            this.creditCardsController.cardNumberController.value.text.length >
                    0
                ? 5.0
                : 1.5,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(16),
      ],
      onChanged: this.creditCardsController.onChanged,
      controller: this.creditCardsController.cardNumberController.value,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
    );
  }

  Widget cvv2() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "cvv2",
        labelText: "cvv2",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorUtils.yellow,
          ),
        ),
        labelStyle: TextStyle(
          color: ColorUtils.black.withOpacity(0.5),
        ),
      ),
      controller: this.creditCardsController.cvv2Controller.value,
      textAlign: TextAlign.center,
      focusNode: this.creditCardsController.cvv2FocusNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
      ],
      onChanged: (string) {
        if (string.length >= 4) {
          this.creditCardsController.expDateMouthFocusNode.requestFocus();
        }
      },
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
    );
  }

  Widget expireDate() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "ماه انقضا",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorUtils.yellow,
                ),
              ),
              labelStyle: TextStyle(
                color: ColorUtils.black.withOpacity(0.5),
              ),
            ),
            controller: this.creditCardsController.expDateMouthController.value,
            focusNode: this.creditCardsController.expDateMouthFocusNode,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
            ],
            onChanged: (string) {
              if (string.length >= 2) {
                this.creditCardsController.expDateYearFocusNode.requestFocus();
              }
            },
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: Get.width / 30,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorUtils.yellow,
                ),
              ),
              labelStyle: TextStyle(
                color: ColorUtils.black.withOpacity(0.5),
              ),
              labelText: "سال انقضا",
            ),
            onChanged: (string) {
              if (string.length >= 2) {
                this.creditCardsController.expDateYearFocusNode.unfocus();
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
            ],
            controller: this.creditCardsController.expDateYearController.value,
            focusNode: this.creditCardsController.expDateYearFocusNode,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
