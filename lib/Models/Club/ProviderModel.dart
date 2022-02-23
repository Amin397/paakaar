class ProviderModel {
  bool searchShow = true;

  ProviderModel({
    required this.id,
    required this.code,
    required this.discountPercent,
    required this.fname,
    required this.lname,
    required this.mobile,
    required this.tel,
    required this.desc,
    required this.lng,
    required this.lat,
    required this.name,
    required this.avatar,
  });

  int id;
  int code;
  String discountPercent;
  String fname;
  String lname;
  String mobile;
  String tel;
  String desc;
  double lng;
  double lat;
  String name;
  String avatar;

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        id: json["id"],
        code: json["code"],
        discountPercent: json["discountPercent"],
        fname: json["fname"],
        lname: json["lname"],
        mobile: json["mobile"],
        tel: json["tel"],
        desc: json["desc"],
        lng: double.parse(json["lng"].toString()),
        lat: double.parse(json["lat"].toString()),
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "discountPercent": discountPercent,
        "fname": fname,
        "lname": lname,
        "mobile": mobile,
        "tel": tel,
        "desc": desc,
        "lng": lng,
        "lat": lat,
        "name": name,
        "avatar": avatar,
      };

  static List<ProviderModel> listFromJson(List data) {
    return data.map((e) => ProviderModel.fromJson(e)).toList();
  }
}
