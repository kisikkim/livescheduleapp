import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:android_intent/android_intent.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/initialization_settings.dart';
import 'package:flutter_local_notifications/notification_details.dart';
import 'package:flutter_local_notifications/platform_specifics/android/initialization_settings_android.dart';
import 'package:flutter_local_notifications/platform_specifics/android/notification_details_android.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/initialization_settings_ios.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/notification_details_ios.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:platform/platform.dart';

class NotificationUtils {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static final NotificationUtils _singleton = new NotificationUtils._internal();

  factory NotificationUtils() {
    return _singleton;
  }

  NotificationUtils._internal() {
    _initPlugin();
  }

  void _initPlugin() {
    var initializationSettingsAndroid =
        new InitializationSettingsAndroid('mipmap/ic_launcher');
    var initializationSettingsIOS = new InitializationSettingsIOS();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        selectNotification: onSelectNotification);
  }

  Future scheduleNotification(ScheduleData data) async {
    _scheduleNotification(data);
  }

  void cancelNotificationIfAny(ScheduleData data) async {
    await flutterLocalNotificationsPlugin.cancel(data.core_show_id);
  }

  /// Schedules a notification that specifies a different icon, sound and vibration pattern
  Future _scheduleNotification(ScheduleData data) async {
    var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 10));
    var vibrationPattern = new Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = new NotificationDetailsAndroid(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        icon: 'mipmap/ic_launcher',
        sound: 'slow_spring_board',
        vibrationPattern: vibrationPattern,
        //color: const Color.fromARGB(255, 255, 0, 0)
    );
    var iOSPlatformChannelSpecifics =
        new NotificationDetailsIOS(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        data.core_show_id,
        'ON AIR: ' + data.stationData.displayName + ' - ' + data.name,
        'TAP TO LISTEN',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: 'ihr://play/live/' + data.stationData.id);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);

      if (const LocalPlatform().isAndroid) {
        AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: payload,
        );
        await intent.launch();
      }
    }
  }
}
