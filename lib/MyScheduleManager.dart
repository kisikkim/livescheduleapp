import 'package:live_schdlue_app/datamodel/Schedule.dart';

class MyScheduleManager {

  static final MyScheduleManager _singleton = new MyScheduleManager._internal();

  final _saved = new Map<String, ScheduleData>();

  factory MyScheduleManager() {
    return _singleton;
  }

  MyScheduleManager._internal();

  List<ScheduleData> getDataList() {
    return _saved.values.toList();
  }

  bool hasSaved(ScheduleData data) {cl
    return _saved.containsKey(_key(data));
  }

  void save(ScheduleData data) {
    _saved.putIfAbsent(_key(data), () => data);
  }

  bool remove(ScheduleData data) {
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