
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:live_schdlue_app/MyScheduleManager.dart';
import 'Schedule.dart';
import 'Station.dart';
import 'package:live_schdlue_app/utils/DateTimUtils.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';

class LiveProfileModel {

  static const String STATION_SLUG ="[[[stationslug]]]";
  static const String NUM_OF_SCHEDULE = "[[[num_of_schedule]]]";
  static const String LIMIT = "[[[LIMIT]]]";
  static const String MARKET_ID = "[[[MARKET_ID]]]";
  static const String ZIP_CODE = "[[[ZIP_CODE]]]";

  DateTimeUtils _dateTimeUtils = new DateTimeUtils();

  static const String DEFAULT_ZIP_CODE = "10012";

  String _scheduleApiUrl = "https://webapi.radioedit.iheart.com/graphql?query=query%20LiveProfile(%24site%3A%20SiteQuery!)%20%7B%0A%20%20site(select%3A%20%24site)%20%7B%0A%0A%20%20%20%20schedule%20%7B%0A%20%20%20%20%20%20current%20%7B%0A%20%20%20%20%20%20%20%20...scheduleFields%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20upcoming(next%3A%20[[[num_of_schedule]]])%20%7B%0A%20%20%20%20%20%20%20%20...scheduleFields%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%0A%20%20%7D%0A%7D%0A%0Afragment%20scheduleFields%20on%20ScheduleEntry%20%7B%0A%20%20name%0A%20%20core_show_id%0A%20%20start%3A%20start_time_12%0A%20%20stop%3A%20stop_time_12%0A%20%20destination%20%7B%0A%20%20%20%20href%0A%20%20%20%20thumbnail%0A%20%20%7D%0A%7D%0A&variables=%7B%0A%20%20%22site%22%3A%20%7B%0A%20%20%20%20%22slug%22%3A%20%22[[[stationslug]]]%22%0A%20%20%7D%0A%7D&operationName=LiveProfile";
  String _localStations ="https://api.iheart.com/api/v2/content/liveStations?allMarkets=false&="+LIMIT+"&offset=0&zipCode="+ZIP_CODE;

  static Map<String,Schedule> availiableSchedules = new Map();

  final MyScheduleManager _myScheduleManager = new MyScheduleManager();

  String _getScheduleApi(String staionslug, int size) {
    var apiUrl =  _scheduleApiUrl.replaceAll(STATION_SLUG, staionslug);
    String url =  apiUrl.replaceAll(NUM_OF_SCHEDULE, size.toString());

    print(url+"\n\n");
    return url;
  }

  String _getStationApi(String zipcode, int size) {
    var apiUrl =  _localStations.replaceAll(LIMIT, size.toString());
    String url =  apiUrl.replaceAll(ZIP_CODE, zipcode);

    print(url);
    return url;
  }



  Future<Schedule> getSchedules(final String callLetter, int size) async {
      var response = await http.get(
        this._getScheduleApi(callLetter.toLowerCase(), size),
      );
      var data = JSON.decode(response.body);

      Schedule schedule;
      try {
        schedule = new Schedule.fromMap(data);
      } catch(e) {
        return null;
      }

      return schedule;
  }

  Future<LiveStationResponse> getStations(final String zipcode, int size) async {
    var response = await http.get(
      this._getStationApi(zipcode, size)
    );
    var data = JSON.decode(response.body);

    LiveStationResponse result = new LiveStationResponse.fromMap(data);

    return result;
  }


  void getSchedulesByCallLetters(List<String> callLetters, int size) {

    availiableSchedules.clear();

    // disable the line for now, this causes remove all users' saved data from page to other page
    //_myScheduleManager.removeAll();

    for(String callLetter in callLetters )
      getSchedules(callLetter.toLowerCase(), size)
          .then((onValue) {
              if (onValue != null) {
                availiableSchedules.putIfAbsent(callLetter, () => onValue);
              }
          })
          .catchError((onError) {
        print(onError.toString());
      });
  }



  List<Data> getAllScheduleData() {

    List<Data> data = new List();

    availiableSchedules.forEach((key,schedule) {

      data.addAll(schedule.upcoming);

    });

    return data;
  }


  List<Data> getScheduleDataByCallLetter(List<String> callLetters) {
    List<Data> data = new List();
    callLetters.forEach((key){
           if(availiableSchedules.containsKey(key)) {
             data.add(availiableSchedules[key].current);
             data.addAll(availiableSchedules[key].upcoming);
           }

    });

    return null;//_dateTimeUtils.convertStringToDate(data);
  }

  List<ScheduleData> getScheduleDataByStations(List<StationData> stationData) {
    List<ScheduleData> convertedSchedules = new List();

    stationData.forEach((station) {

      String key = station.shortDesc;
      if(availiableSchedules.containsKey(key)) {
        List<ScheduleData> schedules = new List();
        schedules.add(_convertToScheduleData(availiableSchedules[key].current, station));
        schedules.addAll(_convertToList(availiableSchedules[key].upcoming, station));
        _dateTimeUtils.convertStringToDate(schedules);
        convertedSchedules.addAll(schedules);
      }

    });

    return convertedSchedules;
  }

  List<ScheduleData> _convertToList(List<Data> data, StationData stationData) {

    return data.map((data) => _convertToScheduleData(data, stationData)).toList();
  }

  ScheduleData _convertToScheduleData(Data data, StationData stationData) {
    return new ScheduleData(data, stationData);
  }
}





