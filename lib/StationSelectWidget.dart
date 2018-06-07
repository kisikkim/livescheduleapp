import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/ListOfStationsManager.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/StationGridEntryWidget.dart';
import 'package:live_schdlue_app/home/PageContainer.dart';
import 'package:live_schdlue_app/home/ScheduledPage.dart';

class StationSelectWidget extends StatefulWidget {
  StationSelectWidget({Key key, this.title, this.zipCode}) : super(key: key);

  final String title;
  final String zipCode;

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
          child: new FutureBuilder<List<StationData>>(
            future: manager.getStationsByZipCode(widget.zipCode),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(10.0),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    children: _buildStationList(snapshot.data)
                );
              }

              return new CircularProgressIndicator();
            },)
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: continueToScheduleView,
        tooltip: 'Continue To Schedule Builder',
        child: new Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<StationGridEntryWidget> _buildStationList(List<StationData> stations) {
    return stations.map((stationData) => new StationGridEntryWidget(stationData, toggledStationCallback)).toList();
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
    final List<StationData> stationDatas = selectedStations.values.toList();

    if (stationDatas.isNotEmpty) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new PageContainer(title: "Station Select Widget", stationsDatas: stationDatas,)),
      );
    }

  }
}





