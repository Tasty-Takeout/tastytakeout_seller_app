import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import '../data_sources/hardcode.dart' as data;

class firebaseMessagingApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final BASE_URL = 'http://10.0.2.2:8000/users/fcm_token';
  static final token = data.accessKey;
  // request notification permission

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // get the device fcm token
    final token = await _firebaseMessaging.getToken();
    print("device token: $token");
    postFCMToken(token!);
  }

  static void onNotificationClick(NotificationResponse response) {
    print('onNotificationClick');
    print(response);
  }

// initalize local notifications
  static Future localNotiInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('tasty_takeout_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationClick,
        onDidReceiveBackgroundNotificationResponse: onNotificationClick);
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'high_importance_channel', 'your channel name',
        channelDescription: 'your channel description',
        icon: 'tasty_takeout_icon',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation('',
            htmlFormatBigText: true,
            htmlFormatTitle: true,
            htmlFormatContentTitle: true,
            htmlFormatSummaryText: true),
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, '<b>' + title + '</b>', body, notificationDetails, payload: payload);
  }

  static Future<void> postFCMToken(String message) async {
    final url = Uri.parse(BASE_URL);
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer ' + token
    };
    final jsonBody = json.encode({
      'token': message,
    });

    try {
      final response = await post(url, headers: headers, body: jsonBody);
      if (response.statusCode != 200) {
        throw Exception('Error posting chat message');
      } else {
        print(response.body);
      }
    } catch (e) {
      print('Error in postChatMessage ' + e.toString());
    }
  }
}
