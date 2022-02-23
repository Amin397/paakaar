import 'dart:convert';

class SingleProviderModel {
  SingleProviderModel({
    required this.providerCode,
    required this.senfName,
    required this.fullName,
    required this.mobile,
    required this.telephone,
    required this.cityName,
    required this.mainStreet,
    required this.latitude,
    required this.longitude,
    required this.avatar,
    required this.description,
    required this.discountCredit,
    required this.discountCash,
    required this.pic,
  });

  int providerCode;
  String senfName;
  String fullName;
  String mobile;
  String telephone;
  String cityName;
  String mainStreet;
  double latitude;
  double longitude;
  String avatar;
  String description;
  String discountCredit;
  String discountCash;
  List<dynamic> pic;

  factory SingleProviderModel.fromRawJson(String str) =>
      SingleProviderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleProviderModel.fromJson(Map<String, dynamic> json) =>
      SingleProviderModel(
        providerCode: json["provider_code"],
        senfName: json["senf_name"],
        fullName: json["full_name"],
        mobile: json["mobile"],
        telephone: json["telephone"],
        cityName: json["city_name"],
        mainStreet: json["main_street"],
        latitude: double.parse(json["latitude"].toString()),
        longitude: double.parse(json["longitude"].toString()),
        avatar: json["avatar"],
        description: json["description"],
        discountCredit: json["discount_credit"],
        discountCash: json["discount_cash"],
        pic: List<dynamic>.from(json["pic"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "provider_code": providerCode,
        "senf_name": senfName,
        "full_name": fullName,
        "mobile": mobile,
        "telephone": telephone,
        "city_name": cityName,
        "main_street": mainStreet,
        "latitude": latitude,
        "longitude": longitude,
        "avatar": avatar,
        "description": description,
        "discount_credit": discountCredit,
        "discount_cash": discountCash,
        "pic": List<dynamic>.from(pic.map((x) => x)),
      };
}
