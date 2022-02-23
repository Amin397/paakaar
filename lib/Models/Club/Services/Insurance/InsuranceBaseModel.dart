class InsuranceBaseModel {
  int id;
  String title;
  String? description;

  InsuranceBaseModel({
    required this.id,
    required this.title,
    this.description,
  });

  factory InsuranceBaseModel.fromJson(Map data) {
    return InsuranceBaseModel(
      id: data['id'],
      title: data['title'],
      description: data['Description'] != null ? data['Description'] : null,
    );
  }

  static List<InsuranceBaseModel> listFromJson(List data) {
    return data.map((e) => InsuranceBaseModel.fromJson(e)).toList();
  }
}

class InsuranceCarBrand {
  int id;
  String title;
  List vehicleCategoryIds;

  InsuranceCarBrand({
    required this.id,
    required this.title,
    required this.vehicleCategoryIds,
  });

  factory InsuranceCarBrand.fromJson(Map data) {
    return InsuranceCarBrand(
      id: data['id'],
      title: data['title'],
      vehicleCategoryIds: data['VehicleCategorieIds'],
    );
  }

  static List<InsuranceCarBrand> listFromJson(List data) {
    return data.map((e) => InsuranceCarBrand.fromJson(e)).toList();
  }
}

class InsuranceCompany {
  int id;
  String title;
  String logoUrl;

  InsuranceCompany({
    required this.id,
    required this.title,
    required this.logoUrl,
  });

  factory InsuranceCompany.fromJson(Map data) {
    return InsuranceCompany(
      id: data['id'],
      title: data['title'],
      logoUrl: data['LogoUrl'],
    );
  }

  static List<InsuranceCompany> listFromJson(List data) {
    return data.map((e) => InsuranceCompany.fromJson(e)).toList();
  }
}
