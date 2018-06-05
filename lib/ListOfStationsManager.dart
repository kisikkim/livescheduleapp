import 'package:live_schdlue_app/datamodel/StationData.dart';

class ListOfStationsManager {

  List<StationData> _stations;

  List<StationData> get stations => _stations;

  ListOfStationsManager() {

    fakeListOfStations();

  }



  void fakeListOfStations() {
    _stations = new List(5);

    _stations[0] = new StationData("1_z100", "Z-100", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "https://i.iheart.com/v3/re/assets.brands/59401075834e35a785184ba2", "Pop", "New York, NY");
    _stations[1] = new StationData("2_q1403", "Q-104.3", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "https://i.iheart.com/v3/re/assets.brands/58305e4f6c152946f5f60552b4a5da58", "Pop", "New York, NY");
    _stations[2] = new StationData("3_default", "Radio Station", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "https://i.iheart.com/v3/re/assets.brands/5a4bd7d83192e41c9d339ce0", "Pop", "New York, NY");
    _stations[3] = new StationData("4_country", "All Country", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "https://i.iheart.com/v3/re/assets.brands/5bef470386f6ec0a7829dc02504cce41", "Pop", "New York, NY");
    _stations[4] = new StationData("5_hip_hop", "Hip Hop", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "https://i.iheart.com/v3/re/assets.brands/01f0a9e29f9a966e93ab789d774e87d4", "Pop", "New York, NY");

  }

}