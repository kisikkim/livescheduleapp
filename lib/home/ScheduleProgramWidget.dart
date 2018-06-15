import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/animations/Animations.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/MyScheduleManager.dart';
import 'package:live_schdlue_app/home/DetailPageRoute.dart';

import 'dart:ui' as ui;

import 'package:live_schdlue_app/utils/CircleThumbnail.dart';


class ScheduleProgramWidget extends StatefulWidget {

  final ScheduleData _programData;
  final void Function(int, int, bool) _onRecurringSelected;

  ScheduleProgramWidget(this._programData, this._onRecurringSelected);

  @override
  State<StatefulWidget> createState() {
    return new ScheduleProgramWidgetState(_programData, _onRecurringSelected);
  }
}

class ScheduleProgramWidgetState extends State<ScheduleProgramWidget> with TickerProviderStateMixin {

  final MyScheduleManager _myScheduleManager = new MyScheduleManager();
  final ScheduleData _programData;
  final void Function(int, int, bool) _onRecurringSelected;

  ScheduleProgramWidgetState(this._programData, this._onRecurringSelected);

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
        _animationController._triggerSelectionAnimation(false);
      } else {
        _myScheduleManager.save(_programData);
        _animationController._triggerSelectionAnimation(true);
      }
    });
    //Animate the selected or unselected cell

  }

  void _handleLongPress() {
    Navigator
        .of(context)
        .push(new DetailPageRoute(_programData.displayName, _programData));
  }

  void _handleDoubleTap() {
    _selectRecurring();
  }

  void _selectRecurring() {
    //find other entries in the schedule with this programId and start hour and select them
    //indicate recurring, find all the other programs at same hour time and select them
    bool shouldSave = !_myScheduleManager.hasSaved(_programData);
    _onRecurringSelected(_programData.core_show_id, _programData.startTime.hour, shouldSave);

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
                .lightBlue[200] : Colors.transparent),
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
        onLongPress: _handleLongPress,
        onDoubleTap: _handleDoubleTap,
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
    print("Triggering anim : " + active.toString());
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