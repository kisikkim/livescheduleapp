import 'package:flutter/material.dart';
import 'package:live_schdlue_app/MyScheduleManager.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/saved/SavedProgramWidget.dart';
import 'package:intl/intl.dart';

class SavedPage extends StatefulWidget {
  final String title;

  SavedPage({Key key, this.title}) : super(key: key);

  @override
  _MySavedPageState createState() => new _MySavedPageState(title);
}

class _MySavedPageState extends State<SavedPage> {
  final String _title;
  final MyScheduleManager _myScheduleManager = new MyScheduleManager();
  List<ScheduleData> _dataList;
  List<SavedPageListItem> _listOfPageItems;

  //Assumes a list sorted by date
  void _bucketScheduleDataByDay(List<ScheduleData> scheduleData) {
    _listOfPageItems = new List<SavedPageListItem>();

    int prevDay = 0;

    scheduleData.sort((a,b) => a.compareTo(b));
    scheduleData.forEach((scheduleValue) {
      //the buckets are by day, so we generate a new DateTime to key them by with day only, no hours, minutes etc
      //could also just do a string but this way we retain a datetime to use later in building header
      int day = scheduleValue.startTime.day;
      DateTime bucketDay = new DateTime(scheduleValue.startTime.year, scheduleValue.startTime.month, day);
      if (prevDay != day) {
        _listOfPageItems.add(new DateSavedPageListItem(bucketDay));
        prevDay = day;
      }
      //if already sorted we don't have to sort again
      _listOfPageItems.add(new ProgramSavedPageListItem(scheduleValue));
    });
  }

  _MySavedPageState(this._title);

  void _handleDismiss(ScheduleData data) {
    setState(() {
      _myScheduleManager.remove(data);
      _updateDataList();
    });
  }

  void _updateDataList() {
    _dataList = _myScheduleManager.getDataList();
    _bucketScheduleDataByDay(_dataList);
  }

  @override
  void initState() {
    super.initState();
    _updateDataList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        padding: new EdgeInsets.all(16.0),
        itemCount: _listOfPageItems.length,
        itemBuilder: (_, position) {
          return _buildWidgetOrDivider(position, context);
        },
        physics: new BouncingScrollPhysics(),
      ),
    );
  }

  Widget _buildWidgetOrDivider(num index, BuildContext context) {
    final SavedPageListItem data = _listOfPageItems[index];
    if (data is ProgramSavedPageListItem) {
      return new Dismissible(
          key: new Key(data.hashCode.toString()),
          direction: DismissDirection.horizontal,
          onDismissed: (DismissDirection direction) {
            _handleDismiss(data.programData);
          },
          child: new ScheduleProgramWidget(data.programData));
    } else if (data is DateSavedPageListItem) {
      return new DateDividerWidget(data.dateTimeData);
    }
  }
}

class DateDividerWidget extends StatelessWidget {
  DateTime _dateTime;

  DateDividerWidget(this._dateTime);


  String getDisplayString() {
    return  (new DateFormat("EEE, MMM d").format(_dateTime)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDivider(getDisplayString());
  }

  Widget _buildDivider(String dt) {
    return new Container(
      child: new Text(
        dt,
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      decoration: new BoxDecoration(color: Colors.black),
    );
  }
}

abstract class SavedPageListItem {}

class ProgramSavedPageListItem implements SavedPageListItem {
  ProgramSavedPageListItem(this.programData);

  ScheduleData programData;
}

class DateSavedPageListItem implements SavedPageListItem {
  DateSavedPageListItem(this.dateTimeData);

  DateTime dateTimeData;
}