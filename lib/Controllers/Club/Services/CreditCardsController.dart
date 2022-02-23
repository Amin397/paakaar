import 'dart:async';

import 'package:paakaar/Models/Club/Services/Cards/CreditCardModel.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/ClubRequestUtils.dart';
import 'package:paakaar/Utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreditCardsController extends GetxController {
  List<Rx<CreditCardModel>> listOfCreditCards = <Rx<CreditCardModel>>[];
  final StreamController<bool> shapeStream = StreamController<bool>.broadcast();

  Rx<bool> isSelecting = false.obs;
  Rx<bool> isLoaded = false.obs;

  ClubRequestUtils requests = ClubRequestUtils();

  // add card

  Rx<TextEditingController> cardNumberController =
      (new TextEditingController()).obs;
  Rx<TextEditingController> cvv2Controller = (new TextEditingController()).obs;
  FocusNode cvv2FocusNode = new FocusNode();
  Rx<TextEditingController> expDateMouthController =
      (new TextEditingController()).obs;
  Rx<TextEditingController> expDateYearController =
      (new TextEditingController()).obs;
  FocusNode expDateMouthFocusNode = new FocusNode();
  FocusNode expDateYearFocusNode = new FocusNode();

  Bank? bank;
  Rx<bool> isBankLoaded = false.obs;
  Rx<bool> isColorLoaded = false.obs;
  void getCards() async {
    ApiResult result = await ClubRequestUtils.instance.allCards();
    if (result.isDone) {
      print(result.data);
      this.listOfCreditCards = CreditCardModel.listFromJson(result.data);
      this.isLoaded.value = true;
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }

  @override
  void onInit() {
    this.getCards();
    super.onInit();
  }

  void onCardTap(Rx<CreditCardModel> creditCard) {
    if (this.isSelecting.isTrue) {
      creditCard.value.isSelected = !creditCard.value.isSelected;
      creditCard.refresh();
      this.shapeStream.sink.add(false);
      if (!this.listOfCreditCards.any((element) => element.value.isSelected)) {
        this.isSelecting.value = false;
      }
    }
  }

  void onLongPress(Rx<CreditCardModel> creditCard) {
    this.isSelecting.value = true;
    creditCard.value.isSelected = true;
    this.shapeStream.sink.add(false);
    creditCard.refresh();
  }

  void deleteSelectedCards() async {
    EasyLoading.show();
    this.isLoaded.toggle();
    ApiResult result = await ClubRequestUtils.instance.deleteCards(
      list: this
          .listOfCreditCards
          .where((element) => element.value.isSelected)
          .map((e) => e.value.id)
          .toList(),
    );
    EasyLoading.dismiss();
    if (result.isDone) {
      this.isLoaded.toggle();
      this.listOfCreditCards.removeWhere((element) => element.value.isSelected);
      this.isSelecting.value = false;
    } else {
      ViewUtils.showErrorDialog(result.data.toString());
    }
  }

  void findBank(String text) async {
    ApiResult result = await ClubRequestUtils.instance.findBank(text);
    if (result.isDone) {
      this.bank = Bank.fromJson(result.data);
      this.isBankLoaded.toggle();
      this
          .bank!
          .setColor(
            Image.network(this.bank!.logo).image,
          )
          .then((value) {
        this.isColorLoaded.value = true;
      });
    }
  }

  void onChanged(String string) {
    RegExp regex = new RegExp(r'[0-9]');
    if (!regex.hasMatch(string)) {
      this.cardNumberController.value.text =
          string.substring(0, string.length - 1);
    }
    if (this.cardNumberController.value.text.length == 6) {
      this.findBank(this.cardNumberController.value.text);
    } else if (this.cardNumberController.value.text.length < 6) {
      this.bank = null;
      this.isBankLoaded.value = false;
      this.isColorLoaded.value = false;
    }
    this.cardNumberController.refresh();
    if (string.length >= 16) {
      this.cvv2FocusNode.requestFocus();
    }
  }

  void addCard() async {
    EasyLoading.show();
    ApiResult result = await ClubRequestUtils.instance.addCard(
      cardNumber: this.cardNumberController.value.text,
      cvv2: this.cvv2Controller.value.text,
      expireYear: this.expDateYearController.value.text,
      expireMonth: this.expDateMouthController.value.text,
      bankId: this.bank!.id.toString(),
    );
    EasyLoading.dismiss();
    if (result.isDone) {
      this.listOfCreditCards.add(CreditCardModel.fromJson(result.data).obs);
      Navigator.pop(context);
    } else {
      ViewUtils.showErrorDialog(
        result.data.toString(),
      );
    }
  }
}
