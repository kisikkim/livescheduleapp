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
  int _currentTabIndex = 0;
  PageController _pageController;

  void _navAway() {
      //goto station select widget page
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new StationSelectWidget(title: "Station Select Widget", )),
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

      body:new PageView(
        controller: _pageController,
        onPageChanged: (newTabIndex) {
          setState(() {
            this._currentTabIndex = newTabIndex;
          });
        },
        children: <Widget>[
          new Center(
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
          new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.notifications),
                new Text("Alerts")
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: _navAway,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (index) {
            //.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
            print("Clicked on tab index " + index.toString());
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
          },
          items: <BottomNavigationBarItem> [
          new BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              title: new Text("!!!"),
            ),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.map),
              title: new Text("???")
            ),
          ]
        )
      );
  }
}
