import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/home/ProgramDetailPage.dart';

class DetailPageRoute extends MaterialPageRoute {
  DetailPageRoute(String title, ScheduleData scheduleData)
      : super(
      builder: (context) =>
      new ProgramDetailPage(
        title: title, scheduleData: scheduleData,
      ));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}