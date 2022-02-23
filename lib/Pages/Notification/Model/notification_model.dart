class NotificationModel{


  String? title;
  String? message;

  NotificationModel({this.title, this.message});



  factory NotificationModel.fromJson(Map<String ,dynamic> json){
    return NotificationModel(
      title: json['title'],
      message: json['message']
    );
  }


  static List<NotificationModel> listFromJson(List data){
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
  };
}