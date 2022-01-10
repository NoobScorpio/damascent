// import 'dart:io';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';

// class LocalNotificationController {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   var initSetting;
//   BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
//       BehaviorSubject<ReceiveNotification>();
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//     'ID_local',
//     'NAME_local',
//     channelDescription: 'DESCRIPTION_local',
//     playSound: true,
//     enableVibration: true,
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

//   LocalNotificationController.init() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     if (Platform.isIOS) {
//       requestIOSPermission();
//     }
//     initializePlatform();
//   }
//   requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()!
//         .requestPermissions(alert: true, badge: true, sound: true);
//   }

//   initializePlatform() {
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings('ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification: (id, title, body, payload) async {
//           ReceiveNotification notification =
//               ReceiveNotification(id, title!, body!, payload!);
//           didReceiveLocalNotificationSubject.add(notification);
//         });
//     initSetting = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   }

//   setOnNotificationClick(Function onNotificationClick) {
//     flutterLocalNotificationsPlugin.initialize(initSetting,
//         onSelectNotification: (payload) async {
//       onNotificationClick(payload);
//     });
//   }

//   setOnNotificationReceive(Function onNotificationReceive) async {
//     didReceiveLocalNotificationSubject.listen((value) {
//       onNotificationReceive(value);
//     });
//   }

//   Future<void> showNotification() async {
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin
//         .show(0, "Test", "body", platformChannelSpecifics, payload: "Payload");
//   }

//   Future<void> showScheduleNotification(title, body, {dateTime}) async {
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.schedule(
//         0, "$title", "$body", dateTime, platformChannelSpecifics,
//         payload: "Payload");
//   }
// }

// LocalNotificationController controller = LocalNotificationController.init();

// class ReceiveNotification {
//   final int id;
//   final String title, body, payload;

//   ReceiveNotification(this.id, this.title, this.body, this.payload);
// }
