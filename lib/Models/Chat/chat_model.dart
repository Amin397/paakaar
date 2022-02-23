import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Chat/messages_model.dart';

class ChatModel {
  UserModel user;
  List<MessageModel> messages;

  bool searchShow = true;

  ChatModel({
    required this.user,
    required this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        user: UserModel.fromJson(
          json['user'],
        ),
        messages: MessageModel.listFromJson(
          json['messages'],
        ),
      );

  static List<ChatModel> listFromJson(List data) {
    return data.map((e) => ChatModel.fromJson(e)).toList();
  }
}
