import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/Notification/Model/notification_model.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Plugins/neu/flutter_neumorphic.dart';
import 'package:paakaar/Utils/color_utils.dart';

class NotificationModalScreen extends StatelessWidget {
  NotificationModalScreen({Key? key}) : super(key: key);

  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: Get.height * .65,
        width: Get.width,
        padding: EdgeInsets.all(
          Get.width * .02,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Globals.notification.deleteAllNotification();
                    box.write('notif', Globals.notification.notificationNumber);
                    box.write('notifList', null);
                    Get.back();
                  },
                  icon: const Icon(
                    Ionicons.close,
                    size: 20.0,
                  ),
                ),
                const Text(
                  'رویداد ها',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.close,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream: Globals.notification.getStream,
              builder: (context, i) {
                return Expanded(
                  child: Container(
                    width: Get.width,
                    height: double.maxFinite,
                    child: (Globals.notification.notificationNumber == 0)
                        ? Center(
                            child: Text(
                              'رویداد جدید وجود ندارد',
                              style: TextStyle(
                                color: ColorUtils.textColor,
                                fontSize: 12.0,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (BuildContext context, int index) =>
                                _buildMessages(
                                    message:
                                        Globals.notification.messages[index]),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: Globals.notification.messages.length,
                          ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _buildMessages({NotificationModel? message}) {
    print(message);
    print(Globals.notification.messages.first.title);
    print(Globals.notification.messages.first.message);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      ),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message!.title ?? '',
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            message.message ?? '',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: ColorUtils.textColor,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
