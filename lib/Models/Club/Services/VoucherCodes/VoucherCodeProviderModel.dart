// To parse this JSON data, do
//
//     final voucherCodeProvider = voucherCodeProviderFromJson(jsonString);

import 'dart:convert';

class VoucherCodeProviderModel {
  VoucherCodeProviderModel({
    this.id,
    this.name,
    this.logo,
    this.percent,
    this.expireDate,
    this.description,
    this.code,
  });

  int? id;
  String? name;
  String? logo;
  String? code;
  int? percent;
  String? expireDate;
  String? description;
  bool searchShow = true;

  factory VoucherCodeProviderModel.fromRawJson(String str) =>
      VoucherCodeProviderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VoucherCodeProviderModel.fromJson(Map<String, dynamic> json) =>
      VoucherCodeProviderModel(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        percent: json["percent"],
        expireDate: json["expireDate"].toString(),
        description: json["description"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "percent": percent,
        "expireDate": expireDate,
        "code": code,
      };

  static List<VoucherCodeProviderModel> listFromJson(List list) {
    List<VoucherCodeProviderModel> output = [];
    list.forEach((element) {
      output.add(VoucherCodeProviderModel.fromJson(element));
    });
    return output;
  }
}
