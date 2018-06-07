import 'package:flutter/material.dart';
import 'package:live_schdlue_app/MyScheduleManager.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/saved/SavedProgramWidget.dart';

class SavedPage extends StatefulWidget {

  final String title;
  SavedPage({Key key, this.title}) : super(key: key);

  @override
  _MySavedPageState createState() => new _MySavedPageState(title);
}

class _MySavedPageState extends State<SavedPage> {

  final String _title;
  final MyScheduleManager _myScheduleManager = new MyScheduleManager();
  List<Data> _dataList;

  _MySavedPageState(this._title);

  void _handleDismiss(Data data) {
    setState(() {
      _myScheduleManager.remove(data);
      _updateDataList();
    });
  }

  void _updateDataList() {
    _dataList = _myScheduleManager.getDataList();
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
        itemCount: _dataList.length,
        itemBuilder: (_, position) {
          return _buildListItem(position, context);
        },
        physics: new BouncingScrollPhysics(),
      ),
    );
  }

  Widget _buildListItem(num index, BuildContext context) {
    final Data data = _dataList[index];
    return new Dismissible(
        key: new Key(data.hashCode.toString()),
        direction: DismissDirection.horizontal,
        onDismissed: (DismissDirection direction) {
          _handleDismiss(data);
        },
        child: new ScheduleProgramWidget(data)
    );
  }
}
