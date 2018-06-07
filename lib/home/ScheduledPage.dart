import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/home/ScheduleProgramWidget.dart';
import 'package:side_header_list_view/side_header_list_view.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';



class ScheduledPage extends StatefulWidget {

  final String title;
  final List<StationData> stationsDatas;
  ScheduledPage({Key key, this.title, this.stationsDatas}) : super(key: key);

  @override
  _ScheduledPageState createState() => new _ScheduledPageState(title, stationsDatas);
}

class _ScheduledPageState extends State<ScheduledPage> {
  _ScheduledPageState(this._title, this._stationDatas);

  final String _title;
  List<StationData> _stationDatas;
  List<ScheduleData> _programDatas;
  List<ScheduleData> _sortedProgramDatas = <ScheduleData>[];

  LiveProfileModel _liveProfileModel = new LiveProfileModel();
  HashMap<DateTime, List<ScheduleData>> _timeMap = new HashMap();

  @override
  void initState() {
    super.initState();
    _programDatas = _liveProfileModel.getScheduleDataByStations(_stationDatas);

    _programDatas.forEach((value) {
      if (_timeMap.containsKey(value.startTime)) {
        List<ScheduleData> datas = _timeMap[value.startTime];
        datas.add(value);
      } else {
        List<ScheduleData> datas = <ScheduleData>[];
        datas.add(value);
        _timeMap.putIfAbsent(value.startTime, () => datas);
      }
    });

    List<DateTime> timeKeys = _timeMap.keys.toList();
    timeKeys.sort((a, b) => a.compareTo(b));

    timeKeys.forEach((dateKey) => _sortedProgramDatas.addAll(_timeMap[dateKey]));
  }

  void onUpdateView(List<StationData> stationDatas) {
    setState(() {
      _stationDatas = stationDatas;
    });
  }

  Text displayDate(DateTime dateTime) {
    return new Text(
      dateTime.month.toString() + "/" + dateTime.day.toString() + " ",
      textAlign: TextAlign.left,
      style: new TextStyle(fontSize: 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SideHeaderListView(
        itemCount: _sortedProgramDatas.length,
        padding: new EdgeInsets.all(16.0),
        itemExtend: 116.0,
        headerBuilder: (BuildContext context, int index) {
          final String startTime =_sortedProgramDatas[index].start;
          final DateTime dateTime = _sortedProgramDatas[index].startTime;

          return new SizedBox(
              width: 50.0,
              child: new Container(
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.blueGrey),
                      color: Colors.grey),
                  child: new Row(children: <Widget>[
                    //Looks cleaner without date
                    //displayDate(dateTime),
                    new Text(startTime,
                      textAlign: TextAlign.left,
                      style: new TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),),
                  ])
              ));
        },
        itemBuilder: (BuildContext context, int index) {
          return new ScheduleProgramWidget(_sortedProgramDatas[index]);
        },
        hasSameHeader: (int a, int b) {
          return _sortedProgramDatas[a].startTime.isAtSameMomentAs(
              _sortedProgramDatas[b].startTime);
        },
      ),
    );
  }
}
