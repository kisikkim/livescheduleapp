import 'package:flutter/material.dart';
import 'package:live_schdlue_app/StationSelectWidget.dart';
import 'package:live_schdlue_app/home/HomePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'iHeartRadio Live Schedule'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _zipCodeTextController = new TextEditingController();

  void _showStationSelect(String zipCode) {
      //goto station select widget page
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new StationSelectWidget(title: "Station Select Widget", zipCode: zipCode,)),
      );
  }

  _showZipCodeDialog() async {
    await showDialog<String>(
        context: context,
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    controller: _zipCodeTextController,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: 'Zip Code',
                      hintText: 'e.g. 10013'
                    ),
                  )
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCEL')),
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showStationSelect(_zipCodeTextController.text);
                  },
                child: const Text('OK'))
          ],
        ));

  }

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
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Click button to pick stations',
            ),
            new Text(
              'Welcome to iHR',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _showZipCodeDialog,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
