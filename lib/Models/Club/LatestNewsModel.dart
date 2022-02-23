class LatestNewsModel {
  bool searchShow = true;

  LatestNewsModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.cover,
    required this.text,
  });

  int id;
  String title;
  String summary;
  String cover;
  String text;

  factory LatestNewsModel.fromJson(Map<String, dynamic> json) =>
      LatestNewsModel(
        id: json["id"],
        title: json["title"],
        summary: json["summary"],
        cover: json["cover"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary,
        "cover": cover,
        "text": text,
      };

  static List<LatestNewsModel> listFromJson(List data) {
    return data.map((e) => LatestNewsModel.fromJson(e)).toList();
  }
}
