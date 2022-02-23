class ScoreModel {
  ScoreModel({
    this.type,
    this.amount,
    this.date,
    this.time,
  });

  Type? type;
  int? amount;
  String? date;
  String? time;

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
    type: Type.fromJson(json["type"]),
    amount: json["amount"],
    date: json["date"],
    time: json["time"],
  );



  static List<ScoreModel> listFromJson(List data)=>data.map((e) => ScoreModel.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    "type": type!.toJson(),
    "amount": amount,
    "date": date,
    "time": time,
  };
}

class Type {
  Type({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
