class InternetPackage {
  bool showSearch = true;

  InternetPackage({
    required this.code,
    required this.description,
    required this.durationCode,
    required this.price,
  });

  String code;
  String description;
  String price;
  String durationCode;

  factory InternetPackage.fromJson(Map<String, dynamic> json) =>
      InternetPackage(
        code: json["code"].toString(),
        description: json["description"].toString(),
        price: json["price"].toString(),
        durationCode: json["durationCode"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "price": price,
        "durationCode": durationCode,
      };

  static List<InternetPackage> listFromJson(List data) {
    return data.map((e) => InternetPackage.fromJson(e)).toList();
  }
}
