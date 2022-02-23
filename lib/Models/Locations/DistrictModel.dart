class DistrictModel {
  int id;
  String name;

  bool isSelected = false;

  bool searchShow = true;

  DistrictModel({
    required this.id,
    required this.name,
  });

  factory DistrictModel.fromJson(item) => DistrictModel(
        id: item['id'],
        name: item['name'],
      );

  static List<DistrictModel> listFromJson(List data) {
    return data.map((e) => DistrictModel.fromJson(e)).toList();
  }
}
