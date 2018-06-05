import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:live_schdlue_app/home/ScheduledPage.dart';
import 'package:live_schdlue_app/saved/SavedPage.dart';

class PageContainer extends StatefulWidget {
  PageContainer({Key key, this.title, this.stationsDatas}) : super(key: key);

  final String title;
  final List<StationData> stationsDatas;

  @override
  _PageContainerState createState() => new _PageContainerState(stationsDatas);
}

class _PageContainerState extends State<PageContainer> {
  int _currentTabIndex = 0;
  PageController _pageController;

  List<StationData> stationsDatas;
  _PageContainerState(this.stationsDatas);

  @override
  void initState() {
    // TODO: implement initState
    _pageController = new PageController(initialPage: _currentTabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),

        body:new PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (newTabIndex) {
            setState(() {
              this._currentTabIndex = newTabIndex;
            });
          },
          children: <Widget>[
            new ScheduledPage(title: "Schedule Builder", stationsDatas:stationsDatas),
            new SavedPage(title: "My Saved program"),
          ],
        ),
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _currentTabIndex,
            onTap: (index) {
              print("Clicked on tab index " + index.toString());
              _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
            },
            items: <BottomNavigationBarItem> [
              new BottomNavigationBarItem(
                icon: const Icon(Icons.ac_unit),
                title: new Text("Schedule Builder"),
              ),
              new BottomNavigationBarItem(
                  icon: const Icon(Icons.map),
                  title: new Text("My Schedule")
              ),
            ]
        )
    );
  }
}
