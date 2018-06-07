// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_schdlue_app/utils/DateTimUtils.dart';

import 'package:live_schdlue_app/main.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });


  test("testing convert startTime in String DateTime Object", () {

    DateTimeUtils utils = new DateTimeUtils();


    Map map1 = {
      "name": "The Sean Hannity Show",
      "core_show_id": 243,
      "start": "12 PM",
      "stop": "6 PM",
      "destination": {
        "href": "http://710wor.iheart.com/featured/the-sean-hannity-show/",
        "thumbnail": "//i.iheart.com/v3/re/assets.brands/fea6ef787ff86eafc758e667f45902fa"
      }

    };

    Map map2 = {
      "name": "Delilah",
      "core_show_id": 239,
      "start": "8 PM",
      "stop": "12 AM",
      "destination": {
        "href": "http://litefm.iheart.com/featured/delilah/",
        "thumbnail": "//i.iheart.com/v3/re/assets.brands/53a49943778f9c8fe055f7add803778f"
      }

    };

    Map map3 = {
      "name": "Delilah",
      "core_show_id": 239,
      "start": "12 AM",
      "stop": "1 AM",
      "destination": {
        "href": "http://litefm.iheart.com/featured/delilah/",
        "thumbnail": "//i.iheart.com/v3/re/assets.brands/53a49943778f9c8fe055f7add803778f"
      }
    };


    Data data1 = new Data.fromMap(map1);
    Data data2 = new Data.fromMap(map2);
    Data data3 = new Data.fromMap(map3);


    ScheduleData scheduleData1 = new ScheduleData(data1, new StationData.empty());
    ScheduleData scheduleData2 = new ScheduleData(data2, new StationData.empty());
    ScheduleData scheduleData3 = new ScheduleData(data3, new StationData.empty());



    List<ScheduleData> listData = new List();
    listData.add(scheduleData1);
    listData.add(scheduleData2);
    listData.add(scheduleData3);

    List<ScheduleData> result = utils.convertStringToDate(listData);

    DateTime now = new DateTime.now();
    expect(result[0].startTime.day, now.day);
    expect(result[0].startTime.hour, 12);
    expect(result[1].startTime.day, now.day);
    expect(result[1].startTime.hour, 20);
    expect(result[2].startTime.day, now.day + 1);
    expect(result[2].startTime.hour, 0);

    expect(result[0].endTime.day, now.day);
    expect(result[0].endTime.hour, 18);
    expect(result[1].endTime.day, now.day+1);
    expect(result[1].endTime.hour, 0);
    expect(result[2].endTime.day, now.day + 1);
    expect(result[2].endTime.hour, 1);

  });

}
