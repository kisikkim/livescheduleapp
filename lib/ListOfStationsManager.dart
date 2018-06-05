import 'dart:async';

import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/datamodel/Station.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';

class ListOfStationsManager {

  static final ListOfStationsManager _singleton = new ListOfStationsManager._internal();

  final LiveProfileModel _liveProfileModel = new LiveProfileModel();

  factory ListOfStationsManager() {
    return _singleton;
  }

  ListOfStationsManager._internal();

  Future<List<StationData>> getStationsByZipCode(String zipCode) async {
    final LiveStationResponse response = await _liveProfileModel.getStations(zipCode, 60);
    return response.stations.map(_convert).toList();
  }

  StationData _convert(LiveStation liveStation) {
    return new StationData(
        liveStation.id.toString(),
        liveStation.name,
        liveStation.callLetters,
        liveStation.description,
        liveStation.logo,
        liveStation.genres != null && liveStation.genres.length > 0 ? liveStation.genres.elementAt(0).name : "UNKNOWN",
        liveStation.markets != null && liveStation.markets.length > 0 ? liveStation.markets.elementAt(0).name : "UNKNOWN");
  }
}