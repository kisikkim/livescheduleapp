import 'package:flutter/material.dart';
import 'package:live_schdlue_app/ListOfStationsManager.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/saved/SavedProgramWidget.dart';

class SavedPage extends StatefulWidget {

  final String title;
  SavedPage({Key key, this.title}) : super(key: key);

  @override
  _MySavedPageState createState() => new _MySavedPageState(title);
}

class _MySavedPageState extends State<SavedPage> {
  _MySavedPageState(this._title);

  final String _title;
  List<StationData> _stationDatas;
  ListOfStationsManager _listOfStationsManager = new ListOfStationsManager();

  @override
  void initState() {
    super.initState();
    _stationDatas = _listOfStationsManager.stations;
  }

  void onUpdateView(List<StationData> stationDatas) {
    setState(() {
      _stationDatas = stationDatas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: _stationDatas.length,
        itemBuilder: (_, position) {
          return _listItemBuilder(position, context);
        },
        physics: new BouncingScrollPhysics(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        child: new Icon(Icons.check_circle),
      ),
    );
  }

  Widget _listItemBuilder(num index, BuildContext context) {
    return new SavedProgramWidget(_stationDatas[index]);
  }
}
