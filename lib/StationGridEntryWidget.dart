import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/StationData.dart';

class StationGridEntryWidget extends StatefulWidget {

  StationData _stationData;
  StationGridEntryWidget(this._stationData);

  @override
  StationGridEntryWidgetState createState() => new StationGridEntryWidgetState.fromStationData(_stationData);
}

class StationGridEntryWidgetState extends State<StationGridEntryWidget> {

  
  
  
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }


  String _title;
  String _shortDesc;
  String _imageUrl;

  StationGridEntryWidgetState() {
    _title ="Default Title";
    _shortDesc="Default Short Description";
    if(this._imageUrl.isEmpty) {
      _imageUrl = 'assets/images/defaultStation.jpg';
    }
  }

  StationGridEntryWidgetState.fromStationData(StationData stationData) {
    _title = stationData.displayName;
    _shortDesc = stationData.shortDesc;
    _imageUrl = stationData.imageUrl;
    if(this._imageUrl.isEmpty) {
      _imageUrl = 'assets/images/defaultStation.jpg';
    }
  }


  @override
  Widget build(BuildContext context) {

  return new GestureDetector(
  onTap: _handleTap,
  child: new Container(
    child: new Column(
      children: <Widget>[
        new Image.asset(
          _imageUrl,
          width:100.0,
          height:100.0,
          fit:BoxFit.cover
        ),
        new Text(_title),
        new Text(_shortDesc),
      ],
    ),
      decoration: new BoxDecoration(color: _active ? Colors.lightGreen[700] : Colors.grey[600])
  )
  );

  }

}