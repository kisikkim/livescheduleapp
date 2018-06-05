import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/ListOfStationsManager.dart';
import 'package:live_schdlue_app/StationData.dart';
import 'package:live_schdlue_app/StationGridEntryWidget.dart';

class StationSelectWidget extends StatefulWidget {
  StationSelectWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StationSelectWidgetState createState() => new _StationSelectWidgetState();
}

class _StationSelectWidgetState extends State<StationSelectWidget> {
  final ListOfStationsManager manager = new ListOfStationsManager();
  HashMap<String, StationData> selectedStations = new HashMap();


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
          child: new GridView.count(
              primary: false,
              padding: const EdgeInsets.all(5.0),
              crossAxisSpacing: 5.0,
              crossAxisCount: 2,
              children: _buildStationList()
          )
      ),



      /*

      body: new Center(
        child: new GridView.count(
          primary: false,
          padding: const EdgeInsets.all(5.0),
          crossAxisSpacing: 5.0,
          crossAxisCount: 2,
          children: _buildStationList()
        )
      ),



      */

      floatingActionButton: new FloatingActionButton(
        onPressed: continueToScheduleView,
        tooltip: 'Continue To Schedule Builder',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<StationGridEntryWidget> _buildStationList() {
    return manager.stations.map((stationData) => new StationGridEntryWidget(stationData, toggledStationCallback)).toList();
  }

  void toggledStationCallback(StationData stationData, bool newState)
  {
    print("toggled : " + stationData.id + " : " + newState.toString());
    if(newState) {
      selectedStations.putIfAbsent(stationData.id, () => stationData);
    } else {
      selectedStations.remove(stationData.id);
    }

  }



  void continueToScheduleView() {
    //pass the selected items data to the next screen
    print("going to scheduler");
    selectedStations.forEach((key, value) {
      print("station passed : " + key);
    });


}


//    Navigator.push(
//      context,
//
//      //new MaterialPageRoute(builder: (context) => new StationSelectWidget(title: "Station Select Widget", )),
//    );


}