class AppIntroScreenModel {
  AppIntroScreenModel({
    required this.id,
    required this.title,
    required this.text,
    required this.banner,
  });

  int id;
  String title;
  String text;
  String banner;

  factory AppIntroScreenModel.fromJson(Map<String, dynamic> json) =>
      AppIntroScreenModel(
        id: json["id"],
        title: json["title"],
        text: json["text"],
        banner: json["banner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "text": text,
        "banner": banner,
      };
  static List<AppIntroScreenModel> listFromJson(List data) {
    return data.map((e) => AppIntroScreenModel.fromJson(e)).toList();
  }
}
