import 'package:live_schdlue_app/datamodel/Schedule.dart';

class MyScheduleManager {

  static final MyScheduleManager _singleton = new MyScheduleManager._internal();

  final _saved = new Set<ScheduleData>();

  factory MyScheduleManager() {
    return _singleton;
  }

  MyScheduleManager._internal();

  List<ScheduleData> getDataList() {
    return _saved.toList();
  }

  bool hasSaved(ScheduleData data) {
    return _saved.contains(data);
  }

  void save(ScheduleData data) {
    _saved.add(data);
  }

  bool remove(ScheduleData data) {
    return _saved.remove(data);
  }

  void removeAll() {
    _saved.clear();
  }
}