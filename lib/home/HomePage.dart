import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/home/StationWidget.dart';

class HomePage extends StatefulWidget {

  String _title;
  HomePage(this._title);

  @override
  _MyHomePageState createState() => new _MyHomePageState(_title);
}

class _MyHomePageState extends State<HomePage> {
  _MyHomePageState(this._title);

  int _stationIndex = 0;
  BidirectionalScrollViewPlugin _bidirectionalScrollViewPlugin;
  String _title;
  List<StationData> _stationDatas = <StationData>[];

  LiveProfileModel _liveProfileModel = new LiveProfileModel();



  @override
  void initState() {
    super.initState();
    _stationDatas.add(new StationData("100.3 Z100", "https://i.iheart.com/v3/re/assets.brands/59401075834e35a785184ba2"));
    _stationDatas.add(new StationData("103.5 KTU", "https://i.iheart.com/v3/re/assets.brands/5bef470386f6ec0a7829dc02504cce41"));
    _stationDatas.add(new StationData("106.1 Lite FM", "https://i.iheart.com/v3/re/assets.brands/5a4bd7d83192e41c9d339ce0"));
    _stationDatas.add(new StationData("104.3 Rock", "https://i.iheart.com/v3/re/assets.brands/58305e4f6c152946f5f60552b4a5da58"));
    _stationDatas.add(new StationData("105.1 Power", "https://i.iheart.com/v3/re/assets.brands/01f0a9e29f9a966e93ab789d774e87d4"));

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
