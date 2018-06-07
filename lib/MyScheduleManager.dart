import 'package:live_schdlue_app/datamodel/Schedule.dart';

class MyScheduleManager {

  static final MyScheduleManager _singleton = new MyScheduleManager._internal();

  final _saved = new Set<Data>();

  factory MyScheduleManager() {
    return _singleton;
  }

  MyScheduleManager._internal();

  List<Data> getDataList() {
    return _saved.toList();
  }

  bool hasSaved(Data data) {
    return _saved.contains(data);
  }

  void save(Data data) {
    _saved.add(data);
  }

  bool remove(Data data) {
    return _saved.remove(data);
  }

  void removeAll() {
    _saved.clear();
  }
}