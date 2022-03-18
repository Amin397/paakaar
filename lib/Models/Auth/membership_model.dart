import 'package:paakaar/Plugins/get/get.dart';





class MembershipModel {
  MembershipModel({
    this.membershipId,
    this.membershipTime,
    this.membershipName,
    this.membershipPrice,
    this.freeCallCount,
    this.priceCallCount,
    this.callPrice,
    this.isSpecial,
    this.freeAdCount,
    this.priceAdCount,
    this.adPrice,
    this.freeCallTime,
    this.priceCallTime,
    this.freeAdTime,
    this.priceAdTime,
    this.viewAds,
    this.viewCalls,
    this.viewUpSliders,
    this.viewDownSliders,
    this.viewTvs,
    this.isWorkerSpecialty,
  });

  RxBool isSelected = false.obs;
  RxBool isDisabled = false.obs;
  int subSubGroupCount = 2;

  int? membershipId;
  String? membershipTime;
  String? membershipName;
  int? membershipPrice;
  int? freeCallCount;
  int? priceCallCount;
  int? callPrice;
  bool? isSpecial;
  bool? isWorkerSpecialty;
  int? freeAdCount;
  int? priceAdCount;
  int? adPrice;
  int? freeCallTime;
  int? priceCallTime;
  int? freeAdTime;
  int? priceAdTime;
  bool? viewAds;
  bool? viewCalls;
  bool? viewUpSliders;
  bool? viewDownSliders;
  bool? viewTvs;

  factory MembershipModel.fromJson(Map<String, dynamic> json) => MembershipModel(
    membershipId: json["membership_id"],
    membershipTime: json["membership_time"],
    membershipName: json["membership_name"],
    membershipPrice: json["membership_price"],
    freeCallCount: json["free_call_count"],
    priceCallCount: json["price_call_count"],
    callPrice: json["call_price"],
    isSpecial: json["isSpecial"],
    isWorkerSpecialty: json["isWorkerSpecialty"],
    freeAdCount: json["free_ad_count"],
    priceAdCount: json["price_ad_count"],
    adPrice: json["ad_price"],
    freeCallTime: json["free_call_time"],
    priceCallTime: json["price_call_time"],
    freeAdTime: json["free_ad_time"],
    priceAdTime: json["price_ad_time"],
    viewAds: json["viewAds"],
    viewCalls: json["viewCalls"],
    viewUpSliders: json["viewUpSliders"],
    viewDownSliders: json["viewDownSliders"],
    viewTvs: json["viewTvs"],
  );

  static List<MembershipModel> listFromJson(List data) {
    return data.map((e) => MembershipModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "membership_id": membershipId,
    "membership_time": membershipTime,
    "membership_name": membershipName,
    "membership_price": membershipPrice,
    "free_call_count": freeCallCount,
    "price_call_count": priceCallCount,
    "call_price": callPrice,
    "isSpecial": isSpecial,
    "free_ad_count": freeAdCount,
    "price_ad_count": priceAdCount,
    "ad_price": adPrice,
    "free_call_time": freeCallTime,
    "price_call_time": priceCallTime,
    "free_ad_time": freeAdTime,
    "price_ad_time": priceAdTime,
    "viewAds": viewAds,
    "viewCalls": viewCalls,
    "viewUpSliders": viewUpSliders,
    "viewDownSliders": viewDownSliders,
    "viewTvs": viewTvs,
  };
}
