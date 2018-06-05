import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';

class StationWidget extends StatelessWidget {

  final StationData stationData;

  StationWidget(this.stationData);

  void onClicked(String value) {
    /**
     *
     */
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Row(
          children: <Widget>[
            new Expanded(
                child: new Image.network(
                  stationData.imageUrl,
                  height: 40.0,
                  width: 40.0,
                )
            ),
            new Expanded(
              child: new Text(
                stationData.displayName,
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 12.0),
              ),
            ),
          ]
      ),
    );
  }
}