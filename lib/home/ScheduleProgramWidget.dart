import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/MyScheduleManager.dart';

import 'dart:ui' as ui;


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

  Widget _buildThumbNail() {
    return new Container(
      width: 200.0,
      height: 200.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(color: Colors.white30),
      ),
      margin: const EdgeInsets.only(top: 32.0, left: 16.0),
      padding: const EdgeInsets.all(3.0),
      child: new ClipOval(
        child: new Image.asset(_programData.destination.thumbnail),
      ),
    );
  }

  Widget _blurBackground() {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Image.network(_programData.destination.thumbnail, fit: BoxFit.cover),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.white30),
            color: _myScheduleManager.hasSaved(_programData) ? Colors
                .lightGreen[700] : Colors.transparent),
        child: new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Row(children: <Widget>[
              _disPlayText(),
              new Expanded(
                  child: _buildThumbNail()),
            ]))
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: _handleTap,
        child: _blurBackground());
  }

  Column _disPlayText() {
    return new Column(children: <Widget>[
      new Expanded(
        child: new Text(
          _programData.name,
          textAlign: TextAlign.left,
          style: _textStyle(),
        ),
      ),
      new Expanded(
        child: new Text(
          _programData.start + " to " + _programData.stop,
          textAlign: TextAlign.left,
          style: _textStyle(),
        ),
      ),
    ]);
  }

  TextStyle _textStyle() {
    return new TextStyle(fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

}
