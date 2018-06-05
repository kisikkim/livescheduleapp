
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Schedule.dart';
import 'Station.dart';

class LiveProfileModel {

  static const String STATION_SLUG ="[[[stationslug]]]";
  static const String NUM_OF_SCHEDULE = "[[[num_of_schedule]]]";
  static const String LIMIT = "[[[LIMIT]]]";
  static const String MARKET_ID = "[[[MARKET_ID]]]";
  static const String ZIP_CODE = "[[[ZIP_CODE]]]";


  static const String DEFAULT_ZIP_CODE = "10012";

  String _scheduleApiUrl = "https://webapi.radioedit.iheart.com/graphql?query=query%20LiveProfile(%24site%3A%20SiteQuery!)%20%7B%0A%20%20site(select%3A%20%24site)%20%7B%0A%0A%20%20%20%20schedule%20%7B%0A%20%20%20%20%20%20current%20%7B%0A%20%20%20%20%20%20%20%20...scheduleFields%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20upcoming(next%3A%20[[[num_of_schedule]]])%20%7B%0A%20%20%20%20%20%20%20%20...scheduleFields%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%0A%20%20%7D%0A%7D%0A%0Afragment%20scheduleFields%20on%20ScheduleEntry%20%7B%0A%20%20name%0A%20%20core_show_id%0A%20%20start%3A%20start_time_12%0A%20%20stop%3A%20stop_time_12%0A%20%20destination%20%7B%0A%20%20%20%20href%0A%20%20%20%20thumbnail%0A%20%20%7D%0A%7D%0A&variables=%7B%0A%20%20%22site%22%3A%20%7B%0A%20%20%20%20%22slug%22%3A%20%22[[[stationslug]]]%22%0A%20%20%7D%0A%7D&operationName=LiveProfile";
  String _localStations ="https://api.iheart.com/api/v2/content/liveStations?allMarkets=false&="+LIMIT+"&offset=0&zipCode="+ZIP_CODE;

  Map<String,Schedule> availiableSchedules = new Map();

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
        this._getScheduleApi(callLetter.toLowerCase(), 10),
      );
      var data = JSON.decode(response.body);


      Schedule schedule = new Schedule.fromMap(data);

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

  void getSchedulesByZip(final String zipcode, int size) async {
    List<Schedule> list = new List();

    Future<LiveStationResponse> stations = getStations(zipcode, size);


    LiveStationResponse liveStationResponse;

    stations.then((onValue) {
      liveStationResponse = onValue;

      List<String> callLetters = new List();
      
      callLetters.add("WLTW-FM");
      callLetters.add("WHTZ-FM");
      callLetters.add("WWPR-FM");

      
      for(String callLetter in callLetters )
        getSchedules(callLetter.toLowerCase(), 10)
            .then((onValue) => availiableSchedules[callLetter] = onValue)
            .catchError((onError) {
          print(onError.toString());
      });

    });


  }


  void printlinData() {

    availiableSchedules.forEach((k,v) => print('${k}: ${v}'));
  }
}





