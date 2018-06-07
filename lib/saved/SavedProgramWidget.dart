import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';

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
    return new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Row(children: <Widget>[
          new Expanded(
              child: new Image.network(
            _programData.destination.thumbnail,
            height: 40.0,
            width: 40.0,
          )),
          new Expanded(
            child: new Text(
              _programData.name,
              textAlign: TextAlign.left,
              style: new TextStyle(fontSize: 12.0),
            ),
          ),
          new Expanded(
            child: new Text(
              _programData.start + " to " + _programData.stop,
              textAlign: TextAlign.left,
              style: new TextStyle(fontSize: 12.0),
            ),
          )
        ]));
  }
}
