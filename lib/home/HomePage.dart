import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/home/StationWidget.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';


class HomePage extends StatefulWidget {

  String _title;
  HomePage(this._title);

  @override
  _MyHomePageState createState() => new _MyHomePageState(_title);
}

class _MyHomePageState extends State<HomePage> {
  _MyHomePageState(this._title);

  String _title;
  List<StationData> _stationDatas = <StationData>[];

  LiveProfileModel _liveProfileModel = new LiveProfileModel();



  @override
  void initState() {
    super.initState();

    //_liveProfileModel.getSchedules("whtz-fm", 10);
    
    _liveProfileModel.getStations(LiveProfileModel.DEFAULT_ZIP_CODE, 10);

    List<StationData> datas = <StationData>[];
    datas.add(new StationData("100.3 Z100", "https://i.iheart.com/v3/re/assets.brands/59401075834e35a785184ba2"));
    datas.add(new StationData("103.5 KTU", "https://i.iheart.com/v3/re/assets.brands/59401075834e35a785184ba2"));
    datas.add(new StationData("106.1 Lite FM", "https://i.iheart.com/v3/re/assets.brands/59401075834e35a785184ba2"));
    datas.add(new StationData("104.3 Rock", "https://i.iheart.com/v3/re/assets.brands/59401075834e35a785184ba2"));
    _stationDatas = datas;
  }

  void onUpdateView(List<StationData> stationDatas) {
    setState(() {
      _stationDatas = stationDatas;
    });
  }

  Widget _listItemBuilder(num index, BuildContext context) {
    StationData stationData = _stationDatas[index];
    return new StationWidget(stationData);
  }

  void _onClicked() {
    /**
     * N/A
     */
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this._title),
      ),
      body: new ListView.builder(
        itemCount: _stationDatas.length,
        itemBuilder: (_, position) {
          return _listItemBuilder(position, context);
        },
        physics: new BouncingScrollPhysics(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _onClicked,
        child: new Icon(Icons.check_circle),
      ),
    );
  }
}
