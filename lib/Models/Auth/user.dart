import 'package:image_picker/image_picker.dart';
import 'package:paakaar/Models/Auth/social_media_model.dart';
import 'package:paakaar/Models/Auth/membership_model.dart';
import 'package:paakaar/Models/Club/LevelModel.dart';
import 'package:paakaar/Models/Comments/CommentModel.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Models/Locations/DistrictModel.dart';
import 'package:paakaar/Models/Locations/states_model.dart';
import 'package:paakaar/Models/MainPage/Field.dart';

import '../option_model.dart';

class UserModel {
  dynamic avatarFile;

  double credit = 0.0;

  int proposalCount = 0;
  int callOutCount = 0;
  int adCount = 0;
  int? rateCount;
  int sentProposalCount = 0;
  int acceptedProposalCount = 0;

  int maxCvFileSize = 10;

  bool searchShow = true;

  List<int> listOfBookmarks = [];

  List<CommentModel> comments = [];

  UserModel({
    this.id,
    this.rateCount,
    this.proposalCount = 0,
    this.callOutCount = 0,
    this.maxCvFileSize = 0,
    this.adCount = 0,
    this.sentProposalCount = 0,
    this.acceptedProposalCount = 0,
    this.firstName,
    this.membershipStart,
    this.membershipExpire,
    this.lastName,
    this.address,
    this.gender,
    this.avatar,
    this.rate,
    this.mobile,
    this.state,
    this.city,
    this.score,
    this.tel,
    this.email,
    this.socialMedia,
    this.fields,
    this.categories,
    this.specialities,
    this.bio,
    this.listOfBookmarks = const [],
    this.cvItems,
    this.role,
    this.level,
    this.isExpired = false,
    this.cardNumber = '---- ---- ---- ----',
    this.listOfOptions,
    this.listOfPublicFilters,
    this.region,
    this.individualCv,
    this.buyFreeMembership,
    this.isMobileShown = false,
    this.comments = const [],
  });

  int? id;
  int? buyFreeMembership;
  String? firstName;
  String? membershipStart;
  String? membershipExpire;
  String? lastName;
  String? address;
  int? gender;
  int? score;
  String? avatar;
  double? rate;
  String? mobile;
  StateModel? state;
  CityModel? city;
  DistrictModel? region;
  String? tel;
  String? email;
  List<SocialMediaModel>? socialMedia;
  List<FieldModel>? fields;
  List<FieldModel>? categories;
  List<FieldModel>? specialities;
  List<CustomFileModel>? cvItems;
  String cardNumber = '---- ---- ---- ---';
  MembershipModel? role;
  LevelModel? level;
  List<OptionModel>? listOfOptions;
  List<OptionModel>? listOfPublicFilters;
  bool isMobileShown;

  bool get isImageLocal => avatarFile is XFile;
  String? bio;
  String? individualCv;

  bool get isNationalCodeSet => true;
  bool isExpired;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      listOfBookmarks: List<int>.from(json['bookmarks'].map((e) => e as int)),
      firstName: json["firstName"] ?? '',
      score: int.parse(json["score"].toString()),
      proposalCount: json["proposalCount"],
      maxCvFileSize: json["maxCvFileSize"],
      isMobileShown: json["showMobile"],
      buyFreeMembership: json["buy_free_membership"],
      acceptedProposalCount: json["acceptedProposalCount"],
       sentProposalCount: json["sentProposalCount"],
      callOutCount: json["callOutCount"],
      adCount: json["adCount"],
      region: json["region"] != null ? DistrictModel.fromJson(json["region"]) : null,
      membershipStart: json["membershipStart"],
      membershipExpire: json["membershipExpire"],
      lastName: json["lastName"] ?? '',
      rateCount: json["rateCount"],
      address: json["address"],
      gender: json["gender"] ?? 1,
      avatar: json["avatar"],
      cardNumber: json["cardNumber"] ?? '---- ---- ---- ----',
      isExpired: json["isExpired"],
      comments: CommentModel.listFromJson(
        json['comments'],
      ),
      bio: json["bio"],
      individualCv: json["individualCv"] ?? '',
      rate: json["rate"].toDouble(),
      level: json["clubLevel"] != null
          ? LevelModel.fromJson(json["clubLevel"])
          : LevelModel(
              id: 0,
              discountPercent: 10.0,
              title: 'test',
              image:
                  'https://titraj.negaapps.ir/paakaar/src/images/Sliders/UpSliders/up_slider1636221219.jpg',
              description: 'test',
              price: 10000.0,
            ),
      mobile: json["mobile"],
      cvItems: CustomFileModel.listFromJson(
        json['cvItems'],
      ),
      state: json["state"] != null ? StateModel.fromJson(json["state"]) : null,
      city: json["city"] != null ? CityModel.fromJson(json["city"]) : null,
      tel: json["tel"],
      role: MembershipModel.fromJson(json['role']),
      email: json["email"],
      socialMedia: SocialMediaModel.listFromJson(
        json['socialMedia'],
      ),
      fields: List<FieldModel>.from(
        json["fields"].map(
          (x) => FieldModel.fromJson(x),
        ),
      ),
      categories: List<FieldModel>.from(
        json["categories"].map(
          (x) => FieldModel.fromJson(x),
        ),
      ),
      specialities: List<FieldModel>.from(
        json["specialities"].map(
          (x) => FieldModel.fromJson(x),
        ),
      ),
      listOfOptions: OptionModel.listFromJson(
        json['options'],
      ),
      listOfPublicFilters: OptionModel.listFromJson(
        json['publicFilters'],
      ),
    );
  }

  String get fullName => firstName! + ' ' + lastName!;

  static List<UserModel> listFromJson(List data) {
    return data
        .map(
          (e) => UserModel.fromJson(e),
        )
        .toList();
  }

  bool isBookmarked(int i) {
    return listOfBookmarks.contains(i);
  }
}
