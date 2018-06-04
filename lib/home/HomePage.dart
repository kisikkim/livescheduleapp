import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/Data.dart';
import 'package:live_schdlue_app/home/StationWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.json}) : super(key: key);

  final List<String> title;
  Map<String, Object> json = new Map();

  @override
  _MyHomePageState createState() => new _MyHomePageState(title, json);
}

class _MyHomePageState extends State<HomePage> {
  _MyHomePageState(this.title, this.json);

  Map<String, Object> json = new Map();
  bool isSelected = true;
  List<String> title;

  List<Data> _data = <Data>[];

  @override
  void initState() {
    super.initState();
  }

  void onUpdateView(List<Data> data) {
    setState(() {
      _data = data;
    });
  }

  Widget _listItemBuilder(num index, BuildContext context) {
    Data data = _data[index];
    return new StationWidget(data);
  }

  void _onClicked() {
    /**
     * N/A
     */
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Program"),
      ),
      body: new ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, position) {
          return _listItemBuilder(position, context);
        },
        physics: new BouncingScrollPhysics(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _onClicked,
        child: new Icon(Icons.check_circle),
      ),
    );
  }
}
