import 'package:paakaar/Plugins/get/get.dart';

class LevelModel {
  bool isSelected = false;

  LevelModel({
    this.id,
    this.title,
    this.image,
    this.description,
    required this.discountPercent,
    this.price,
  });

  int? id;
  String? title;
  String? image;
  String? description;
  double? discountPercent = 0.0;
  double? price;

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    // json['price'] = json['price'] == null ? 0.0 : json['price'];
    return LevelModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      discountPercent: double.parse(json["discountPercent"].toString()),
      image: json["image"],
      price: double.parse(json["price"].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "price": price,
      };

  static List<Rx<LevelModel>> listFromJson(List data) {
    return data.map((e) => LevelModel.fromJson(e).obs).toList();
  }
}
