import 'dart:io';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:dispatch/view/personal/worker/oem_detail_page.dart';
import 'package:dispatch/view/personal/worker/oem_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _onDidReceiveNotificationResponse(
    NotificationResponse details) async {
  print("[FCM_DEBUG] onDidReceiveNotificationResponse: ${details.payload}");
}

@pragma('vm:entry-point')
Future<void> _onDidReceiveBackgroundNotificationResponse(
    NotificationResponse details) async {
  print(
      "[FCM_DEBUG] onDidReceiveBackgroundNotificationResponse: ${details.payload}");
}

class PushNotificationManager {
  static Future<void> init() async {
    await requestPermission();
    await getToken();
    await setupFlutterNotifications();

    //從關掉狀態點開推播
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("從關掉狀態點開推播");
        print('on Resume(getInitial): $message');
        pushToPage(message);
      }
    });

    //App打開在前景時
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        UserDefault.instance.notification_count++;
        print("-------收到前景推播--------");
        print(message.notification!.body);
        print(message.notification!.title);
        print(message.data);
        print(message.toMap());
        if (Platform.isAndroid) {
          showFlutterNotification(message);
        }
      }
    });

    //App退到背景,當回到App後 或是點了推播通知後
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //AndroidNotification? android = message.notification?.android;
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      print("App退到背景,當回到App後 或是點了推播通知後");
      print(message.data);
      print(message.toMap());
      pushToPage(message);
    });

    ///後台消息
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static Future<void> setupFlutterNotifications() async {
    print("[FCM_DEBUG] setupFlutterNotifications");
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    }

    const InitializationSettings initSettings = InitializationSettings(
        android: AndroidInitializationSettings("ic_launcher"),
        iOS: DarwinInitializationSettings());

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //iOS禁用前台通知
    if (Platform.isIOS) {
      // Required to display a heads up 收到前景推播
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  static getToken() async {
     if(Platform.isIOS) {
      String apnstoken = await FirebaseMessaging.instance.getAPNSToken() ?? "";
      print("APNSToken: $apnstoken");
    }
    String fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    print("FCMToken: $fcmToken");
    UserDefault().fcmToken = fcmToken;
  }

  static requestPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print('User granted permission: ${settings.authorizationStatus}');
    }
  }
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  UserDefault.instance.notification_count++;
  print("收到後臺訊息(onBackground): ${message.messageId}");
  print("後臺訊息title: ${message.notification!.title}");
  print("後臺訊息data: ${message.data.toString()}");
  await Firebase.initializeApp();
  pushToPage(message);
}

pushToPage(RemoteMessage message) {
  //這邊主要處理, 點開系統的推播通知後, 要push進哪一頁
  Map<String, dynamic> data = message.data;
  String type = data['type'];
  if (type == 'oem_confirm') {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => OemListPage(tab_index: 2),
      ),
    );
  } else if (type == 'oem_request') {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => OemListPage(tab_index: 0),
      ),
    );
  } else if (type == 'oem_matching') {}
}

///安卓在App打開(前景)的時候系統不會有推播通知
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  //AndroidNotification? android = message.notification?.android;
  print("[FCM_DEBUG] setupFlutterNotifications");
  if (notification != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          playSound: true,
          icon: 'ic_launcher',
        ),
      ),
    );
  }
}
