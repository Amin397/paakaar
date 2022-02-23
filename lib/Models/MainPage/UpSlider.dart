import 'package:paakaar/Models/MainPage/Field.dart';

class UpSliderModel {
  UpSliderModel({
    required this.id,
    required this.upSliderImage,
    required this.upSliderName,
    required this.upSliderLink,
    required this.upSliderText,
    required this.field,
    required this.createdAt,
  });

  int id;
  String upSliderImage;
  String upSliderName;
  String upSliderLink;
  String upSliderText;
  FieldModel? field;
  DateTime createdAt;

  factory UpSliderModel.fromJson(Map<String, dynamic> json) => UpSliderModel(
        id: json["id"],
        upSliderImage: json["up_slider_image"],
        upSliderName: json["up_slider_name"],
        upSliderLink: json["up_slider_link"],
        field:
            json['field'] != null ? FieldModel.fromJson(json['field']) : null,
        upSliderText: json['up_slider_text'],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "up_slider_image": upSliderImage,
        "up_slider_name": upSliderName,
        "created_at": createdAt.toIso8601String(),
      };

  static List<UpSliderModel> listFromJson(List data) {
    return data.map((e) => UpSliderModel.fromJson(e)).toList();
  }
}
