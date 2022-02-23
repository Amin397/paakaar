class TvModel {
  TvModel({
    required this.name,
    required this.individualId,
    required this.content,
    required this.cover,
    required this.createdAt,
    required this.fieldId,
  });

  String name;
  int individualId;
  String content;
  String cover;
  int createdAt;
  int fieldId;
  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        name: json["name"] == null ? null : json["name"],
        individualId:
            json["individualId"] == null ? null : json["individualId"],
        content: json["content"] == null ? null : json["content"],
        cover: json["cover"] == null ? null : json["cover"],
        createdAt: json["createdAt"],
        fieldId: json["fieldId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "individualId": individualId,
        "content": content,
        "cover": cover,
        "createdAt": createdAt,
      };

  static List<TvModel> listFromJson(List data) {
    return data.map((e) => TvModel.fromJson(e)).toList();
  }
}
