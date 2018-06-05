import 'package:live_schdlue_app/COLIN_StationData.dart';

class ListOfStationsManager {

  List<COLIN_StationData> _stations;

  List<COLIN_StationData> get stations => _stations;

  ListOfStationsManager() {

    fakeListOfStations();

  }



  void fakeListOfStations() {
    _stations = new List(5);

    _stations[0] = new COLIN_StationData("1_z100", "Z-100", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "assets/images/bang.jpg", "Pop", "New York, NY");
    _stations[1] = new COLIN_StationData("2_q1403", "Q-104.3", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "assets/images/bang.jpg", "Pop", "New York, NY");
    _stations[2] = new COLIN_StationData("3_default", "Radio Station", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "assets/images/bang.jpg", "Pop", "New York, NY");
    _stations[3] = new COLIN_StationData("4_country", "All Country", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "assets/images/bang.jpg", "Pop", "New York, NY");
    _stations[4] = new COLIN_StationData("5_hip_hop", "Hip Hop", "Popular Hits of NYC", "Long desc of z100 fiewnofeiwn fwiof ewoif ioew fioewoifewof", "assets/images/bang.jpg", "Pop", "New York, NY");

    //_stations[0] = new StationData("z100", "Z100", "Popular Hits", "This is the long desc for z100", "assets/images/bang.jpg", );


//    _stations[1] = new StationData("q1043");
//    _stations[2] = new StationData("another1");
//    _stations[3] = new StationData("another2");
//    _stations[4] = new StationData("another3");
  }


}