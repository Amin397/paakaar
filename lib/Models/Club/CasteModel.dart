class CasteModel {
  bool searchShow = true;

  CasteModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  int id;
  String name;
  String icon;

  factory CasteModel.fromJson(Map<String, dynamic> json) => CasteModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };

  static List<CasteModel> listFromJson(List data) {
    return data.map((e) => CasteModel.fromJson(e)).toList();
  }
}
