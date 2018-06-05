import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/StationData.dart';

typedef void ToggledStationButtonCallback(StationData stationData, bool newState);

class StationGridEntryWidget extends StatefulWidget {

  final ToggledStationButtonCallback toggledStationButtonCallback;
  final StationData _stationData;

  StationGridEntryWidget(this._stationData, this.toggledStationButtonCallback);

  @override
  StationGridEntryWidgetState createState() => new StationGridEntryWidgetState.fromStationData(_stationData, this.toggledStationButtonCallback);
}

class StationGridEntryWidgetState extends State<StationGridEntryWidget> {


  ToggledStationButtonCallback _toggledStationButtonCallback;


  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
    if(this._toggledStationButtonCallback != null) {
      this._toggledStationButtonCallback(_stationData, _active);
    } else {
      print("NULL CALLBACK HANDLER FOR " + _stationData.id);
    }

  }

  StationData _stationData;

  StationGridEntryWidgetState() {
    _stationData = new StationData.empty();
    _toggledStationButtonCallback = defaultHandler;
  }

  void defaultHandler(StationData s, bool b) { print("ping"); }

  StationGridEntryWidgetState.fromStationData(StationData stationData, ToggledStationButtonCallback toggledStationButtonCallback) {
    _stationData = stationData;
    _toggledStationButtonCallback = toggledStationButtonCallback;
  }

  @override
  Widget build(BuildContext context) {

  return new GestureDetector(
  onTap: _handleTap,
  child: new Container(
    child: new Column(
      children: <Widget>[
        new Image.asset(
            _stationData.imageUrl,
          width:100.0,
          height:100.0,
          fit:BoxFit.cover
        ),
        new Text(_stationData.displayName),
        new Text(_stationData.shortDesc),
      ],
    ),
      decoration: new BoxDecoration(color: _active ? Colors.lightGreen[700] : Colors.grey[600])
  )
  );

  }

}