import 'package:paakaar/Models/Locations/CityModel.dart';

class StateModel {
  int id;
  String name;
  List<CityModel> listOfCities;

  bool isSelected = false;

  StateModel({
    required this.id,
    required this.name,
    required this.listOfCities,
  });

  factory StateModel.fromJson(item) => StateModel(
        id: item['id'],
        name: item['name'],
        listOfCities: item['cities'] is List
            ? CityModel.listFromJson(item['cities'])
            : [],
      );

  static List<StateModel> listFromJson(List data) {
    List<StateModel> test = data.map((e) => StateModel.fromJson(e)).toList();
    for (var o in test) {
      o.listOfCities.insert(
        0,
        CityModel(id: 0, name: 'همه شهر ها'),
      );
    }
    return test;
  }
}




class ProfileStateModel {
  int id;
  String name;
  List<CityModel> listOfCities;

  bool isSelected = false;

  ProfileStateModel({
    required this.id,
    required this.name,
    required this.listOfCities,
  });

  factory ProfileStateModel.fromJson(item) => ProfileStateModel(
    id: item['id'],
    name: item['name'],
    listOfCities: item['cities'] is List
        ? CityModel.listFromJson(item['cities'])
        : [],
  );

  static List<ProfileStateModel> listFromJson(List data) {
    List<ProfileStateModel> test = data.map((e) => ProfileStateModel.fromJson(e)).toList();
    // for (var o in test) {
    //   o.listOfCities.insert(
    //     0,
    //     CityModel(id: 0, name: 'همه شهر ها'),
    //   );
    // }
    return test;
  }
}
