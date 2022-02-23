import 'package:paakaar/Plugins/get/get.dart';

class OptionModel {
  OptionModel({
    required this.id,
    required this.name,
    required this.values,
    required this.isPublic,
  });

  int id;
  String name;
  bool isPublic = true;
  List<OptionValue> values;

  bool get isSelected => this.values.any(
        (element) => element.isSelected.isTrue,
      );

  factory OptionModel.fromJson(Map<String, dynamic> json, bool isPublic) =>
      OptionModel(
        id: json['id'],
        isPublic: json['isPublic'] ?? isPublic,
        name: json["name"],
        values: List<OptionValue>.from(
          json["values"].map(
            (x) => OptionValue.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };

  static List<OptionModel> listFromJson(
    List data, {
    bool isPublic = true,
  }) {
    return data.length > 0
        ? data
            .map(
              (e) => OptionModel.fromJson(e, isPublic),
            )
            .toList()
        : [];
  }
}

class OptionValue {
  OptionValue({
    required this.id,
    required this.name,
    required this.isSelected,
  });

  int id;
  String name;
  RxBool isSelected = false.obs;

  factory OptionValue.fromJson(Map<String, dynamic> json) => OptionValue(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        isSelected: json['isSelected'] is bool
            ? RxBool(
                json['isSelected'],
              )
            : false.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
