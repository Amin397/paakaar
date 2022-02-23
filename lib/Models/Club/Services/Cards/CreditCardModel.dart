import 'package:paakaar/Plugins/get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:palette_generator/palette_generator.dart';

class CreditCardModel {
  bool isSelected = false;

  double fontSize = 21.0;

  Text get firstFour {
    List chars = this.number.toString().characters.toList();
    return chars.length > 0
        ? this.textWidget(chars[0] + chars[1] + chars[2] + chars[3])
        : this.textWidget('----');
  }

  Text get secondFour {
    List chars = this.number.toString().characters.toList();
    return chars.length > 3
        ? this.textWidget(chars[4] + chars[5] + chars[6] + chars[7])
        : this.textWidget('----');
  }

  Text get thirdFour {
    List chars = this.number.toString().characters.toList();
    return chars.length > 10
        ? this.textWidget(chars[8] + chars[9] + chars[10] + chars[11])
        : this.textWidget('----');
  }

  Text get fourthFour {
    List chars = this.number.toString().characters.toList();
    return chars.length > 11
        ? this.textWidget(chars[12] + chars[13] + chars[14] + chars[15])
        : this.textWidget('----');
  }

  late PaletteGenerator paletteGenerator;

  void setColor(ImageProvider image, Function function) async {
    this.paletteGenerator = await PaletteGenerator.fromImageProvider(image);
    Future.delayed(Duration(milliseconds: 1), () {
      function(() {});
    });
  }

  Text textWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        letterSpacing: 2.0,
        fontSize: this.fontSize,
        color: Colors.black,
      ),
    );
  }

  CreditCardModel({
    required this.id,
    required this.bank,
    required this.number,
    required this.cvv2,
    required this.expiration,
  });

  int id;
  Bank bank;
  String number;
  int cvv2;
  String expiration;

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      CreditCardModel(
        id: json['id'],
        bank: Bank.fromJson(json["bank"]),
        number: json["number"],
        cvv2: int.parse(json["cvv2"].toString()),
        expiration: json["expiration"],
      );

  Map<String, dynamic> toJson() => {
        "bank": bank.toJson(),
        "number": number,
        "cvv2": cvv2,
        "expiration": expiration,
      };

  static List<Rx<CreditCardModel>> listFromJson(List list) {
    List<Rx<CreditCardModel>> output = [];
    list.forEach((element) {
      output.add(CreditCardModel.fromJson(element).obs);
    });
    return output;
  }
}

class Bank {
  int id;

  Bank({
    required this.id,
    required this.name,
    required this.logo,
  });

  String name;
  String logo;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        name: json["name"],
        logo: json["logo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "id": id,
      };

  PaletteGenerator? paletteGenerator;

  Future<void> setColor(
    ImageProvider image,
  ) async {
    this.paletteGenerator = await PaletteGenerator.fromImageProvider(image);
    return Future.value(null);
  }
}
