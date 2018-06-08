import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/utils/CircleThumbnail.dart';

class ScheduleProgramWidget extends StatefulWidget {
  final ScheduleData _programData;

  ScheduleProgramWidget(this._programData);

  @override
  State<StatefulWidget> createState() {
    return new ScheduleProgramWidgetState(_programData);
  }
}

class ScheduleProgramWidgetState extends State<ScheduleProgramWidget> {
  final ScheduleData _programData;

  ScheduleProgramWidgetState(this._programData);

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 100.0,
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.white30),
            color: Colors.grey[200]),
        child: new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Row(children: <Widget>[
              new Expanded(
                  child: _buildThumbNail()),
              new Expanded(
                child: new Text(
                  _programData.name,
                  textAlign: TextAlign.left,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ),
              new Expanded(
                child: new Text(
                  _programData.start + " to " + _programData.stop,
                  textAlign: TextAlign.left,
                  style: new TextStyle(fontSize: 16.0),
                ),
              )
            ]))
    );
  }

  Widget _buildThumbNail() {
    return new CircleThumbnail(_programData.destination.thumbnail, 50.0);
  }
}
