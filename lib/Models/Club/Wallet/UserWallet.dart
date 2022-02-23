import 'package:paakaar/Models/Club/LevelModel.dart';

class UserWallet {
  UserWallet({
    this.club,
    this.user,
    this.isRegistered,
  });

  ClubModel? club;
  UserWalletData? user;
  bool? isRegistered;

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
        club: json["club"] == null ? null : ClubModel.fromJson(json["club"]),
        user:
            json["user"] == null ? null : UserWalletData.fromJson(json["user"]),
        isRegistered:
            json["isRegistered"] == null ? null : json["isRegistered"],
      );

  Map<String, dynamic> toJson() => {
        "club": club?.toJson(),
        "user": user?.toJson(),
        "isRegistered": isRegistered == null ? null : isRegistered,
      };

  static List<UserWallet> listFromJson(List data) {
    return data.map((e) => UserWallet.fromJson(e)).toList();
  }
}

class ClubModel {
  ClubModel({
    this.id,
    this.name,
    this.logo,
    this.description,
  });

  String? id;
  String? name;
  String? logo;
  String? description;

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        logo: json["logo"] == null ? null : json["logo"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "logo": logo == null ? null : logo,
        "description": description == null ? null : description,
      };
}

class UserWalletData {
  UserWalletData({
    this.level,
    this.credit,
    this.score,
  });

  LevelModel? level;
  String? credit;
  String? score;

  factory UserWalletData.fromJson(Map<String, dynamic> json) => UserWalletData(
        level:
            json["level"] == null ? null : LevelModel.fromJson(json["level"]),
        credit: json["credit"] == null ? null : json["credit"],
        score: json["score"] == null ? null : json["score"],
      );

  Map<String, dynamic> toJson() => {
        "level": level?.toJson(),
        "credit": credit == null ? null : credit,
        "score": score == null ? null : score,
      };
}
