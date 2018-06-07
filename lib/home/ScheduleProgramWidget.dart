import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/MyScheduleManager.dart';

class ScheduleProgramWidget extends StatefulWidget {

  final Data _programData;

  ScheduleProgramWidget(this._programData);

  @override
  State<StatefulWidget> createState() {
    return new ScheduleProgramWidgetState(_programData);
  }
}

class ScheduleProgramWidgetState extends State<ScheduleProgramWidget> {

  final MyScheduleManager _myScheduleManager = new MyScheduleManager();
  final Data _programData;

  ScheduleProgramWidgetState(this._programData);

  void _handleTap() {
    setState(() {
      if (_myScheduleManager.hasSaved(_programData)) {
        _myScheduleManager.remove(_programData);
      } else {
        _myScheduleManager.save(_programData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: _handleTap,
        child: new Container(
          decoration: new BoxDecoration(color: _myScheduleManager.hasSaved(_programData) ? Colors.lightGreen[700] : Colors.white),
          child: new Padding(
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
              ])),
        ));
  }

}
