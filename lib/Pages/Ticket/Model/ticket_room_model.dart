class TicketRoomModel {
  TicketRoomModel({
    this.id,
    this.title,
    this.message,
    this.isClosed,
  });

  int? id;
  String? title;
  List<Message>? message;
  int? isClosed;

  factory TicketRoomModel.fromJson(Map<String, dynamic> json) => TicketRoomModel(
    id: json["id"],
    title: json["title"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    isClosed: json["isClosed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": List<dynamic>.from(message!.map((x) => x.toJson())),
    "isClosed": isClosed,
  };
}

class Message {
  Message({
    this.date,
    this.byAdmin,
    this.message,
  });

  String? date;
  bool? byAdmin;
  String? message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    date: json["date"],
    byAdmin: json["byAdmin"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "byAdmin": byAdmin,
    "message": message,
  };
}
