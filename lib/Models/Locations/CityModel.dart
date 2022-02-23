class CityModel {
  int id;
  String name;

  bool isSelected = false;

  bool searchShow = true;

  CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromJson(item) => CityModel(
        id: item['id'],
        name: item['name'],
      );

  static List<CityModel> listFromJson(List data) {
    return data.map((e) => CityModel.fromJson(e)).toList();
  }
}
