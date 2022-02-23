import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Calls/CallPriceType.dart';

class ProposalModel {
  int id;
  String date;
  String desc;
  bool isRead;
  bool isAccepted;
  CallPriceType priceType;
  UserModel individual;
  int price;

  ProposalModel({
    required this.id,
    required this.date,
    required this.desc,
    required this.isRead,
    required this.isAccepted,
    required this.priceType,
    required this.price,
    required this.individual,
  });

  factory ProposalModel.fromJson(Map json) => ProposalModel(
        id: json['id'],
        date: json['date'],
        desc: json['desc'],
        isRead: json['isRead'],
        isAccepted: json['isAccepted'],
        priceType: CallPriceType(
          id: json['priceType']['id'],
          name: json['priceType']['name'],
        ),
        price: json['price'],
        individual: UserModel.fromJson(
          json['user'],
        ),
      );

  static List<ProposalModel> listFromJson(List data) {
    return data.map((e) => ProposalModel.fromJson(e)).toList();
  }
}
