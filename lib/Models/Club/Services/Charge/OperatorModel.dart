import 'package:paakaar/Plugins/get/get.dart';

class OperatorModel {
  bool isSelected = false;

  OperatorModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.askAmount,
  });

  int id;
  String name;
  String logo;
  bool askAmount;

  factory OperatorModel.fromJson(Map<String, dynamic> json) => OperatorModel(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        askAmount: json["askAmount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "askAmount": askAmount,
      };

  static List<Rx<OperatorModel>> listFromJson(List list) {
    List<Rx<OperatorModel>> output = [];
    list.forEach((element) {
      OperatorModel operatorModel = OperatorModel.fromJson(element);
      output.add(operatorModel.obs);
    });
    return output;
  }
}
