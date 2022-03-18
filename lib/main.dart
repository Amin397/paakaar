//
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Pages/Notification/Model/notification_model.dart';

import 'Pages/Splash/splash_screen.dart';
import 'Plugins/get/get.dart';
import 'Utils/Api/Base/base_request_util.dart';
import 'Utils/color_utils.dart';
import 'Utils/routing_utils.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
    appId: '1:448618578101:ios:2bc5c1fe2ec336f8ac3efc',
    messagingSenderId: '448618578101',
    projectId: 'react-native-firebase-testing',
  ));
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
//
//   try {
//
// // you can also assign this app to a FirebaseApp variable
// // for example app = await FirebaseApp.initializeApp...
//
//     if (Firebase.apps.length != 0) {
//       await Firebase.initializeApp(
//           options: const FirebaseOptions(
//             apiKey: 'AAAAsl1TTIA:APA91bFi0g0xtYWaRhJ0kEAsIr3faYa8blKacZuB0skVg6kT7Yocld11OeIrQXJz-CTtoH7U2htciYVNOCzjXDUFtj1i7yJrOhJ-fA9_lauiitGjS595IE9k06yauBjzWYmxKmQ0ojxq',
//             appId: '1:448618578101:ios:2bc5c1fe2ec336f8ac3efc',
//             messagingSenderId: '448618578101',
//             projectId: 'react-native-firebase-testing',
//           ));
//     }
//   } on FirebaseException catch (e) {
//     if (e.code == 'duplicate-app') {
// // you can choose not to do anything here or either
// // In a case where you are assigning the initializer instance to a FirebaseApp variable, // do something like this:
// //
// //   app = Firebase.app('SecondaryApp');
// //
//     } else {
//       throw e;
//     }
//   } catch (e) {
//     rethrow;
//   }

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
        appId: '1:448618578101:ios:2bc5c1fe2ec336f8ac3efc',
        messagingSenderId: '448618578101',
        projectId: 'react-native-firebase-testing',
      ));  await GetStorage.init();
  RequestsUtil.token = 'test';
  RequestsUtil.baseRequestUrl = 'https://paakaar.com/admin';
  final box = GetStorage();

  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // _firebaseMessagingBackgroundHandler(messaging.app.re);
    String? token = await messaging.getToken();
    log(token ?? '');
  } catch (e) {}
  log('firebase start');
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      log('new message');
      if (message is RemoteMessage) {
        Get.snackbar(
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          backgroundColor: Colors.white.withOpacity(0.9),
        );

        Globals.notification.addNotification(
            title: notification!.title, body: notification.body);
        box.write('notif', Globals.notification.notificationNumber);
        box.write(
            'notifList',
            jsonEncode(
                Globals.notification.messages.map((e) => e.toJson()).toList()));
      }
    },
  );

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'iranSans',
      unselectedWidgetColor: Colors.white,
      scrollbarTheme: ScrollbarThemeData(
        isAlwaysShown: true,
        radius: const Radius.circular(10.0),
        thumbColor: MaterialStateProperty.all(
          ColorUtils.yellow.withOpacity(0.5),
        ),
        thickness: MaterialStateProperty.all(5.0),
        minThumbLength: 100,
      ),
      canvasColor: ColorUtils.mainRed,
      primarySwatch: ColorUtils.mainRed,
    ),
    getPages: [
      RoutingUtils.splash,
      RoutingUtils.loginRegister,
      RoutingUtils.chatSingle,
      RoutingUtils.viewProposal,
      RoutingUtils.myCallOutSingle,
      RoutingUtils.myCallOuts,
      RoutingUtils.myAds,
      RoutingUtils.support,
      RoutingUtils.getFieldAndGroupDialog,
      RoutingUtils.participateForCallOut,
      RoutingUtils.appIntroScreen,
      RoutingUtils.dashboard,
      RoutingUtils.requestService,
      RoutingUtils.expertList,
      RoutingUtils.addCallOut,
      RoutingUtils.upgradePlan,
      RoutingUtils.userDashboard,
      RoutingUtils.userScore,
      RoutingUtils.completeProfile,
      RoutingUtils.callOutSingle,
      RoutingUtils.newReport,
      RoutingUtils.adAdd,
      RoutingUtils.showSingleTicket,
      RoutingUtils.myBookmarks,
      RoutingUtils.reportFromUser,
      RoutingUtils.ticketSingle,
      RoutingUtils.allAds,
      RoutingUtils.sendNewTicket,
      RoutingUtils.myProposals,
      ClubRoutingUtils.clubDashboard,
      ClubRoutingUtils.charge,
      ClubRoutingUtils.cards,
      ClubRoutingUtils.qrScanner,
      ClubRoutingUtils.charity,
      ClubRoutingUtils.internet,
      ClubRoutingUtils.voucherCodes,
      ClubRoutingUtils.workGroups,
      ClubRoutingUtils.mainInsuranceScreen,
      ClubRoutingUtils.thirdPersonInsurance,
      // RoutingUtils.negaWallet,
      // ClubRoutingUtils.charge,
      // ClubRoutingUtils.cards,
      // ClubRoutingUtils.qrScanner,
      // ClubRoutingUtils.charity,
      // ClubRoutingUtils.internet,
      // ClubRoutingUtils.voucherCodes,
      // ClubRoutingUtils.workGroups,
      // ClubRoutingUtils.mainInsuranceScreen,
      // ClubRoutingUtils.thirdPersonInsurance,
    ],
    builder: EasyLoading.init(),
    color: ColorUtils.mainRed,
    home: SplashScreen(),
  ));
}
