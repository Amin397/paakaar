class ConnectusModel {
  ConnectusModel({
    this.telephone,
    this.latitude,
    this.longitude,
    this.email,
    this.address,
    this.whatsapp,
    this.telegram,
    this.instagram,
    this.website,
  });

  String? telephone;
  String? latitude;
  String? longitude;
  String? email;
  String? address;
  String? whatsapp;
  String? telegram;
  String? instagram;
  String? website;

  factory ConnectusModel.fromJson(Map<String, dynamic> json) => ConnectusModel(
    telephone: json["telephone"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    email: json["email"],
    address: json["address"],
    whatsapp: json["whatsapp"],
    telegram: json["telegram"],
    instagram: json["instagram"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "telephone": telephone,
    "latitude": latitude,
    "longitude": longitude,
    "email": email,
    "address": address,
    "whatsapp": whatsapp,
    "telegram": telegram,
    "instagram": instagram,
    "website": website,
  };
}
