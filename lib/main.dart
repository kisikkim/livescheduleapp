import 'package:flutter/material.dart';
import 'package:live_schdlue_app/StationSelectWidget.dart';

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
  int _currentTabIndex = 0;
  PageController _pageController;
  final _zipCodeTextController = new TextEditingController(text: '10013');
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _showStationSelect(String zipCode) {
      //goto station select widget page
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new StationSelectWidget(title: "Station Select Widget", zipCode: zipCode,)),
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = new PageController(initialPage: _currentTabIndex);
    super.initState();
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
              'Welcome to iHR',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
            new Form(
              key: _formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: new TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.trim().length != 5) {
                            return 'Please enter a valid zip code';
                          }
                        },
                        controller: _zipCodeTextController,
                        decoration: new InputDecoration(
                          labelText: 'Enter zip code to see list of stations',
                          hintText: 'e.g. 10013',
                        ),
                      )
                  ),
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: new RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _showStationSelect(_zipCodeTextController.text);
                        }
                      },
                      child: new Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
