import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/animations/Animations.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/MyScheduleManager.dart';

import 'dart:ui' as ui;


class ScheduleProgramWidget extends StatefulWidget {

  final ScheduleData _programData;

  ScheduleProgramWidget(this._programData);

  @override
  State<StatefulWidget> createState() {
    return new ScheduleProgramWidgetState(_programData);
  }
}

class ScheduleProgramWidgetState extends State<ScheduleProgramWidget> with TickerProviderStateMixin {

  final MyScheduleManager _myScheduleManager = new MyScheduleManager();
  final ScheduleData _programData;

  ScheduleProgramWidgetState(this._programData);

  ScheduleProgramWidgetAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new ScheduleProgramWidgetAnimationController();
    _animationController.init(this, this);
  }


  void _handleTap() {
    setState(() {
      if (_myScheduleManager.hasSaved(_programData)) {
        _myScheduleManager.remove(_programData);
      } else {
        _myScheduleManager.save(_programData);
      }
    });

    //Animate the selected or unselected cell
    _animationController._triggerSelectionAnimation(_myScheduleManager.hasSaved(_programData));
  }

  Widget _buildThumbNail() {
    return new Container(
      width: 50.0 * _animationController.getPortraitSizeValue(),
      height: 50.0 *  _animationController.getPortraitSizeValue(),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(color: Colors.white30),
      ),
      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 16.0),
      padding: const EdgeInsets.all(3.0),
      child: new ClipOval(
        child: new Image.network(_programData.destination.thumbnail),
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
    return _displayContainer();
  }

  Container _displayContainer() {
    return new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.white30),
            color: _myScheduleManager.hasSaved(_programData) ? Colors
                .lightGreen[700] : Colors.transparent),
        child: new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Row(children: <Widget>[
              _buildThumbNail(),
              new Expanded(child:_disPlayText()),
              new Divider(height: 15.0,color: Colors.white,),
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
          _displayProgramName(),
          textAlign: TextAlign.left,
          style: _textStyle(),
        ),
      ),
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

  String _displayProgramName() {
    return "[" + _programData.stationData.displayName + "]";
  }

}

class ScheduleProgramWidgetAnimationController {
  GenericCurvesAnimationController _growPortraitController;

  Duration animDuration = const Duration(milliseconds: 150);

  void init(State state, TickerProvider tp) {
    initGrowAnim(state, tp);
  }

  void initGrowAnim(State state, TickerProvider tp) {
    _growPortraitController =
    new GenericCurvesAnimationController(animDuration, tp, state, false, 1.0 , 1.5);
  }

  double getPortraitSizeValue() {
    return _growPortraitController.getAnimation().getValue();
  }

  void _triggerSelectionAnimation(bool active) {
    print("Triggering anim");
    TickerFuture tf; //listener for anim done
    if (active) {
      print("Grow");
      tf = _growPortraitController.forward();
    } else {
      print("Shrink");
      tf = _growPortraitController.reverse();
    }
    tf.whenCompleteOrCancel(() {
      _animDone(active);
    });
  }

  void _animDone(bool active) {
    print("Anim is done : " + active.toString());
  }
}