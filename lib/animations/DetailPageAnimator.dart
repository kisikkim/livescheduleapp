import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/home/ProgramDetailPage.dart';

class DetailPageAnimator extends StatefulWidget {
   String title;
   ScheduleData scheduleData;

  DetailPageAnimator({Key key, this.title, this.scheduleData}) : super(key: key);

  @override
  _DetailPageAnimator createState() => new _DetailPageAnimator(title, scheduleData);
}

class _DetailPageAnimator extends State<DetailPageAnimator>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;
  final String title;
  final ScheduleData scheduleData;

  _DetailPageAnimator(this.title, this.scheduleData);

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new ProgramDetailPage(title: title, scheduleData: scheduleData, controller: _controller,);
  }
}