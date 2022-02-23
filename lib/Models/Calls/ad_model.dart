import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';

class AdModel {
  AdModel({
    required this.id,
    required this.cover,
    required this.title,
    required this.stateId,
    required this.cityId,
    required this.desc,
    required this.fieldId,
    required this.link,
    required this.status,
    required this.field,
    required this.state,
    required this.city,
    required this.price,
    required this.adType,
    required this.individualId,
    required this.name,
    required this.individualPic,
  });

  int id;
  int adType;
  int status;
  String cover;
  String title;
  int stateId;
  int cityId;
  String desc;
  int individualId;
  String name;
  String individualPic;
  int fieldId;
  String link;
  bool isDeleting = false;
  int price;
  FieldModel field;
  StateModel state;
  CityModel city;
  static Map<String, String> listOfStatuses = {
    '3': "رد شده",
    '0': "در انتظار تایید",
    '1': "تایید شده",
  };
  static String getStatus(int status) {
    print(status);
    return listOfStatuses[status.toString()] ?? "نا مشخص";
  }

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json["id"],
      cover: json["cover"],
      title: json["title"],
      stateId: json["state_id"],
      cityId: json["city_id"],
      desc: json["desc"],
      adType: json["adType"],
      price: json["price"],
      link: json["link"],
      fieldId: json["fieldId"],
      status: json["status"],
      individualId: json["individual_id"],
      name: json["name"],
      individualPic: json["individual_pic"],
      state: StateModel.fromJson(json["state"]),
      city: CityModel.fromJson(json["city"]),
      field: FieldModel.fromJson(json["field"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": title,
        "state_id": stateId,
        "city_id": cityId,
        "desc": desc,
        "fieldId": fieldId,
      };

  static List<AdModel> listFromJson(List data) {
    return data.map((e) => AdModel.fromJson(e)).toList();
  }
}
