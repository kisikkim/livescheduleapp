import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/home/StationWidget.dart';


class ScheduledPage extends StatefulWidget {

  final String title;
  final List<StationData> stationsDatas;
  ScheduledPage({Key key, this.title, this.stationsDatas}) : super(key: key);

  @override
  _ScheduledPageState createState() => new _ScheduledPageState(title, stationsDatas);
}

class _ScheduledPageState extends State<ScheduledPage> {
  _ScheduledPageState(this._title, this._stationDatas);

  int _stationIndex = 0;
  BidirectionalScrollViewPlugin _bidirectionalScrollViewPlugin;
  final String _title;
  List<StationData> _stationDatas;
  LiveProfileModel _liveProfileModel = new LiveProfileModel();

  @override
  void initState() {
    super.initState();

    _bidirectionalScrollViewPlugin = new BidirectionalScrollViewPlugin(
      child: _buildWidgets(),
      velocityFactor: 2.0,
    );

    

  }

  void onUpdateView(List<StationData> stationDatas) {
    setState(() {
      _stationDatas = stationDatas;
    });
  }

  void _onClicked() {
    /**
     * N/A
     */
  }

  StationData _getRandomStation() {
    final StationData stationData = _stationDatas[_stationIndex];
    _stationIndex++;
    if (_stationIndex >= _stationDatas.length) _stationIndex = 0;

    return stationData;
  }

  Column _stationColumn(List<Widget> list) {
    return new Column(
      children: list.map((widget) {
        return widget;
      }).toList(),
    );
  }

  List<Column> _stationColumns(List<Widget> list) {
    final List<Column> columns = <Column>[];
    for (int i=0 ; i< 10; i++) {
      columns.add(_stationColumn(list));
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this._title),
      ),
      body: new Center(
          child: _bidirectionalScrollViewPlugin
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _onClicked,
        child: new Icon(Icons.check_circle),
      ),
    );
  }

  Widget _buildWidgets() {
    List<Widget> list = new List();

    for (int i = 0; i < 20; i++) {
      list.add(new Container(
        padding: new EdgeInsets.all(5.0),
        color: Colors.white,
        height: 80.0,
        width: 200.0,
        child: new Container(
          color: Colors.grey,
          child: new StationWidget(_getRandomStation())
        ),
      ));
    }

    return new Row(
      children: _stationColumns(list),
    );
  }
}
