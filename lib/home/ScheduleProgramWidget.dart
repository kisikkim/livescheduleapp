import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';

class ScheduleProgramWidget extends StatelessWidget {

  final  Data programData;

  ScheduleProgramWidget(this.programData);

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
                  programData.destination.thumbnail,
                  height: 40.0,
                  width: 40.0,
                )
            ),
            new Expanded(
              child: new Text(
                programData.name,
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 12.0),
              ),
            ),
            new Expanded(
              child: new Text(
                programData.start +" to "+ programData.stop,
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 12.0),
              ),
            )
          ]
      ),
    );
  }
}