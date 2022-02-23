class SocialMediaModel {
  SocialMediaModel({
    required this.id,
    required this.name,
    required this.icon,
    this.address,
    this.prefix,
  });

  int id;
  String name;
  String icon;
  String? address;
  String? prefix;
  bool get isAddressSet => address is String;
  factory SocialMediaModel.fromJson(Map<String, dynamic> json) =>
      SocialMediaModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        address: json["address"],
        prefix: json["prefix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "address": address,
      };

  static List<SocialMediaModel> listFromJson(List data) {
    return data.map((e) => SocialMediaModel.fromJson(e)).toList();
  }
}
