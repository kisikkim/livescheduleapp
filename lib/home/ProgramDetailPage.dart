import 'package:flutter/material.dart';
import 'package:live_schdlue_app/MyScheduleManager.dart';
import 'package:live_schdlue_app/animations/Animations.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';

import 'dart:ui' as ui;

import 'package:live_schdlue_app/utils/CircleThumbnail.dart';


class ProgramDetailPage extends StatefulWidget {

  final String title;
  final ScheduleData scheduleData;
  ProgramDetailPage({Key key, this.title, this.scheduleData}) : super(key: key);

  @override
  _ProgramDetailPageState createState() => new _ProgramDetailPageState(title, scheduleData);
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  _ProgramDetailPageState(this._title, this._programData);

  final MyScheduleManager _myScheduleManager = new MyScheduleManager();
  final String _title;
  ScheduleData _programData;

  @override
  void initState() {
    super.initState();
  }

  Icon buildActionIcon() {
    if (_myScheduleManager.hasSaved(_programData)) {
      return new Icon(Icons.remove);
    } else {
      return new Icon(Icons.add);
    }
  }


  Text displayDate(DateTime dateTime) {
    return new Text(
      dateTime.month.toString() + "/" + dateTime.day.toString() + " ",
      textAlign: TextAlign.left,
      style: new TextStyle(fontSize: 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_title),
      ),
      body: new Hero(
        tag: _programData.destination.thumbnail,
        child: _blurBackground(),),
      floatingActionButton: new FloatingActionButton(
        onPressed: onSaved,
        tooltip: 'Continue To Schedule Builder',
        child: buildActionIcon(),
      ),
    );
  }

  void onSaved() {
    setState(() {
      if (_myScheduleManager.hasSaved(_programData)) {
        _myScheduleManager.remove(_programData);
      } else {
        _myScheduleManager.save(_programData);
      }
    });
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
    return new SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildThumbNail(),
          _buildInfo(),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return new Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            _programData.name,
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          new Text(
            _programData.stationData.displayName,
            style: new TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
          new Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            width: 225.0,
            height: 1.0,
          ),
          new Text(
            _programData.stationData.longDesc,
            style: new TextStyle(
              color: Colors.white.withOpacity(0.85),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbNail() {
    return new CircleThumbnail(_programData.destination.thumbnail, 100.0);
  }
}
