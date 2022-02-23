import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';
import 'package:paakaar/Models/option_model.dart';

class CallModel {
  bool searchShow = true;

  CallModel({
    required this.id,
    required this.status,
    required this.cover,
    required this.name,
    required this.state,
    required this.city,
    required this.desc,
    required this.expireDate,
    required this.field,
    required this.category,
    required this.speciality,
    required this.day,
    required this.district,
    required this.individual,
    required this.listOfOptions,
    required this.listOfPublicFilters,
    this.proposeCount = 0,
    this.priceType,
    this.proposalPrice,
    this.unReadProposalCount = 0,
    // required this.isPast,
    required this.hasProposed,
    required this.isAccepted,
    required this.iAmAccepted,
  });

  int id;
  int status;
  int? proposalPrice;
  int? priceType;
  String cover;
  String name;
  String desc;
  String expireDate;
  String day;
  // bool isPast;
  bool hasProposed;
  bool isAccepted;
  bool isDeleting = false;
  bool iAmAccepted;
  int proposeCount = 0;
  int unReadProposalCount = 0;
  String district;
  FieldModel? field;
  StateModel state;
  CityModel city;
  FieldModel? category;
  FieldModel? speciality;
  UserModel? individual;

  List<OptionModel>? listOfOptions;
  List<OptionModel>? listOfPublicFilters;
  factory CallModel.fromJson(Map<String, dynamic> json) {
    print('start');
    print(json['publicFilters']);
    print('end');
    return CallModel(
      id: json["id"],
      status: json["status"],
      proposalPrice: json["proposalPrice"],
      cover: json["cover"],
      priceType: json["priceType"],
      // isPast: json["isPast"],
      hasProposed: json["hasProposed"],
      isAccepted: json["isAccepted"],
      day: json["day"],
      iAmAccepted: json["iAmAccepted"],
      proposeCount: json["proposeCount"],
      unReadProposalCount: json["unReadProposalCount"],
      district: json["district"],
      individual: json['individual'] != null
          ? UserModel.fromJson(
              json['individual'],
            )
          : null,
      name: json["name"],
      state: StateModel.fromJson(json["state"]),
      city: CityModel.fromJson(json["city"]),
      desc: json["desc"],
      expireDate: json["expireDate"],
      field: json["field"] != null ? FieldModel.fromJson(json["field"]) : null,
      category: json["category"] != null
          ? FieldModel.fromJson(json["category"])
          : null,
      speciality: json["speciality"] != null
          ? FieldModel.fromJson(json["speciality"])
          : null,
      listOfOptions: OptionModel.listFromJson(
        json['options'],
      ),
      listOfPublicFilters: OptionModel.listFromJson(
        json['publicFilters'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "state_id": state.id,
        "city_id": city.id,
        "desc": desc,
        "fieldId": field,
      };

  static List<CallModel> listFromJsonForMyCallOut(List data) {
    return data.map((e) => CallModel.fromJson(e)).toList();
  }


  static List<CallModel> listFromJsonForMyProposal(List data) {
    return data.map((e) => CallModel.fromJson(e['callOut'])).toList();
  }

  static Map<String, String> listOfStatuses = {
    '2': "رد شده",
    '3': "منقضی شده",
    '0': "در انتظار تایید",
    '1': "تایید شده",
  };
  static String getStatus(int status) {
    print(status);
    return listOfStatuses[status.toString()] ?? "نا مشخص";
  }
}
