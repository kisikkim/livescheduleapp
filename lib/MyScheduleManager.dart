import 'dart:async';

import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/utils/NotificationUtils.dart';

class MyScheduleManager {

  static final MyScheduleManager _singleton = new MyScheduleManager._internal();

  final _saved = new Map<String, ScheduleData>();
  final NotificationUtils _notificationUtils = new NotificationUtils();

  factory MyScheduleManager() {
    return _singleton;
  }

  MyScheduleManager._internal();

  List<ScheduleData> getDataList() {
    return _saved.values.toList();
  }

  bool hasSaved(ScheduleData data) {
    return _saved.containsKey(_key(data));
  }

  Future save(ScheduleData data) async {
    _saved.putIfAbsent(_key(data), () => data);
    await _notificationUtils.scheduleNotification(data);
  }

  bool remove(ScheduleData data) {
    _notificationUtils.cancelNotificationIfAny(data);
    return _saved.remove(_key(data)) != null;
  }

  void removeAll() {
    _saved.clear();
  }

  String _key(ScheduleData data) {
    String key = data.core_show_id.toString() + '_' + data.startTime.toString();
    return key;
  }
}