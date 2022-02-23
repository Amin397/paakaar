import 'dart:io' as io;

class CustomFileModel {
  int id = 0;
  io.File? file;
  String? url;

  String name = "";

  CustomFileModel({
    this.id = 0,
    this.file,
    this.url,
    this.name = "",
  });

  factory CustomFileModel.fromJson(Map json) => CustomFileModel(
        id: json['id'],
        url: json['url'],
        name: json['name'],
      );

  static List<CustomFileModel> listFromJson(List data) {
    return data.map((e) => CustomFileModel.fromJson(e)).toList();
  }
}
