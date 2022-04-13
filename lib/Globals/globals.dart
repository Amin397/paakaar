import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paakaar/Models/Auth/user.dart';
import 'package:paakaar/Models/Locations/CityModel.dart';
import 'package:paakaar/Pages/Notification/Model/notification_model.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/project_request_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserStream {
  // ignore: close_sinks
  final streamController = StreamController<UserModel>.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream<UserModel> get getStream => streamController.stream;

  UserModel? user = UserModel();

  void changeUser(UserModel user1) {
    user = null;
    user = user1;
    sync();
  }

  void sync() {
    streamController.sink.add(user!);
  }

  Future<bool> bookmark(int id) async {
    EasyLoading.show();
    ApiResult result = await ProjectRequestUtils.instance.changeBookmark(id);
    EasyLoading.dismiss();
    if (result.isDone) {
      if (result.data == 'add') {
        user?.listOfBookmarks.add(id);
      } else {
        user?.listOfBookmarks.remove(id);
      }
      sync();
      return result.data == 'add';
    }
    return false;
  }

  void addCallOut() {
    user?.callOutCount++;
    sync();
  }

  void deleteCallOut({int? count}) {
    user?.callOutCount = count!;
    sync();
  }

  void deleteProposal({int? count}) {
    user?.sentProposalCount = count!;
    sync();
  }

  void deleteAds({int? count}) {
    user?.adCount = count!;
    sync();
  }

  void changeProfileImage({XFile? image}) {
    user!.avatarFile = image!;
    sync();
  }

  void setUserScore(data) {
    user!.score = data['score'];
    user!.adCount = data['ads'];
    user!.callOutCount = data['calls'];
    user!.proposalCount = data['proposal'];
    sync();
  }

  void addAds() {
    user?.adCount ++;
    sync();
  }
}

class CityStream {
  // ignore: close_sinks
  final StreamController<CityModel> streamController =
      StreamController<CityModel>.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream<CityModel> get getStream => streamController.stream;

  CityModel? city;

  void updateCityData(CityModel city) {
    city = city;
    streamController.sink.add(city);
  }
}

class NotificationStream {
  // ignore: close_sinks
  final StreamController streamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => streamController.stream;

  int notificationNumber = 0;

  List<NotificationModel> messages = [];

  addNotification({String? title, String? body}) {
    notificationNumber++;
    messages.insert(0, NotificationModel(title: title, message: body));
    streamController.sink.add(notificationNumber);
    streamController.sink.add(messages);
  }

  deleteAllNotification() {
    notificationNumber = 0;
    messages.clear();
    streamController.sink.add(notificationNumber);
    streamController.sink.add(messages);
  }

  setNotification({int? notification, List? messagesList}) {
    notificationNumber = notification!;
    messages = NotificationModel.listFromJson(messagesList!);
    streamController.sink.add(notificationNumber);
    streamController.sink.add(messages);

  }
}


class DeveloperTeam {
  // ignore: close_sinks
  final StreamController<int> streamController =
  StreamController<int>.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream<int> get getStream => streamController.stream;

  int tapCount = 0;

  void addCount() {
    tapCount ++;
    streamController.sink.add(tapCount);
  }

  void resetCount() {
    tapCount = 0;
    streamController.sink.add(tapCount);
  }
}
class Globals {
  static UserStream userStream = UserStream();
  static CityStream city = CityStream();
  static NotificationStream notification = NotificationStream();
  static DeveloperTeam developerTeam = DeveloperTeam();
}


