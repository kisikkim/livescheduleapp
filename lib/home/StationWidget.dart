import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_schdlue_app/datamodel/Data.dart';

class StationWidget extends StatelessWidget {

   final Data data;

   StationWidget(this.data);

  void onClicked(String value) {
//    data.value = value;
//    clickListener(data, position, null);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                data.name,
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 18.0),
              ),
            ),
            new Expanded(
                child: new TextField(
                  //controller: controller,
                  onSubmitted: onClicked,
                )
            ),
          ]
      ),
    );
  }
}