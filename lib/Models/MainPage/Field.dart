import 'package:paakaar/Plugins/get/get.dart';

class FieldModel {
  bool searchShow = true;

  FieldModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.listOfSubItems,
    required this.hasSubCategory,
    required this.isSpeciality,
  });

  int id;
  String name;
  String icon;
  RxBool isSelected = false.obs;
  bool hasSubCategory = false;
  bool isSpeciality = false;
  List<FieldModel> listOfSubItems = [];
  factory FieldModel.fromJson(Map<String, dynamic> json){
    print('------------------------------------------------');
    return FieldModel(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      icon: json["icon"] == null ? null : json["icon"],
      hasSubCategory: json['hasSubGroup'] ?? false,
      isSpeciality: json['isSpeciality'] ?? false,
      listOfSubItems: json["listOfSubItems"] == null
          ? []
        // :[]
          : FieldModel.listFromJson(json["listOfSubItems"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };

  static List<FieldModel> listFromJson(List data) {
    return data.map((e) => FieldModel.fromJson(e)).toList();
  }
}