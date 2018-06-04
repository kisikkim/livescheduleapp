
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Schedule.dart';

class LiveProfileModel {

  static const String STATION_SLUG ="[[[stationslug]]]";
  static const String NUM_OF_SCHEDULE = "[[[num_of_schedule]]]";

  String scheduleApiUrl = "https://webapi.radioedit.iheart.com/graphql?query=query%20LiveProfile(%24site%3A%20SiteQuery!)%20%7B%0A%20%20site(select%3A%20%24site)%20%7B%0A%0A%20%20%20%20schedule%20%7B%0A%20%20%20%20%20%20current%20%7B%0A%20%20%20%20%20%20%20%20...scheduleFields%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20upcoming(next%3A%20[[[num_of_schedule]]])%20%7B%0A%20%20%20%20%20%20%20%20...scheduleFields%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%0A%20%20%7D%0A%7D%0A%0Afragment%20scheduleFields%20on%20ScheduleEntry%20%7B%0A%20%20name%0A%20%20core_show_id%0A%20%20start%3A%20start_time_12%0A%20%20stop%3A%20stop_time_12%0A%20%20destination%20%7B%0A%20%20%20%20href%0A%20%20%20%20thumbnail%0A%20%20%7D%0A%7D%0A&variables=%7B%0A%20%20%22site%22%3A%20%7B%0A%20%20%20%20%22slug%22%3A%20%22[[[stationslug]]]%22%0A%20%20%7D%0A%7D&operationName=LiveProfile";

  String getStationApi(String staionslug, int size) {
    var apiUrl =  scheduleApiUrl.replaceAll(STATION_SLUG, staionslug);
    return apiUrl.replaceAll(NUM_OF_SCHEDULE, size.toString());
  }

  Future<Schedule> getSchedules(final String callLetter, int size) async {
      var response = await http.get(
        this.getStationApi("whtz-fm", 10),
      );
      var data = JSON.decode(response.body);

      Schedule schedule = new Schedule.fromMap(data);

      return schedule;
  }

}
