class WorkGroupModel {
  bool searchShow = true;

  WorkGroupModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  int id;
  String name;
  String icon;

  factory WorkGroupModel.fromJson(Map<String, dynamic> json) => WorkGroupModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };

  static List<WorkGroupModel> listFromJson(List data) {
    return data.map((e) => WorkGroupModel.fromJson(e)).toList();
  }
}
