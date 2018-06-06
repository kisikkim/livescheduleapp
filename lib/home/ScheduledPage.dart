import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
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
  List<Data> _programDatas;
  List<Data> _sortedProgramDatas = <Data>[];

  LiveProfileModel _liveProfileModel = new LiveProfileModel();
  HashMap<String, List<Data>> _timeMap = new HashMap();

  @override
  void initState() {
    super.initState();
    _programDatas = _liveProfileModel.getScheduleDataByCallLetter(_stationDatas.map((data) => data.shortDesc).toList());
    _programDatas.forEach((value) {
      if (_timeMap.containsKey(value.start)) {
        List<Data> datas = _timeMap[value.start];
        datas.add(value);
      } else {
        List<Data> datas = <Data>[];
        datas.add(value);
        _timeMap.putIfAbsent(value.start, () => datas);
      }
    });

    _timeMap.values.forEach((datas) => _sortedProgramDatas.addAll(datas));

  }

  void onUpdateView(List<StationData> stationDatas) {
    setState(() {
      _stationDatas = stationDatas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SideHeaderListView(
        itemCount: _sortedProgramDatas.length,
        padding: new EdgeInsets.all(16.0),
        itemExtend: 116.0,
        headerBuilder: (BuildContext context, int index) {
          return new SizedBox(width: 100.0,child: new Text(_sortedProgramDatas[index].start, style: Theme.of(context).textTheme.headline,));
        },
        itemBuilder: (BuildContext context, int index) {
          return new Text(_sortedProgramDatas[index].name, style: Theme.of(context).textTheme.headline,);
        },
        hasSameHeader: (int a, int b) {
          return _sortedProgramDatas[a].start == _sortedProgramDatas[b].start;
        },
      ),
    );
  }
}
