class MessageModel {
  MessageModel({
    required this.id,
    required this.title,
    required this.sender,
    required this.receiver,
    required this.isRead,
    required this.timestamp,
    required this.time,
  });

  int id;
  String title;
  DateTime timestamp;
  String time;
  int sender;
  int receiver;
  bool isRead;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        title: json["title"],
        timestamp: DateTime.parse(json["timestamp"]),
        time: json["time"],
        sender: json["sender"],
        receiver: json["receiver"],
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sender": sender,
        "receiver": receiver,
      };

  static List<MessageModel> listFromJson(List data) {
    return data.map((e) => MessageModel.fromJson(e)).toList();
  }
}
