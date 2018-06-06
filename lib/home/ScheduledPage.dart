import 'package:flutter/material.dart';
import 'package:live_schdlue_app/datamodel/LiveProfileModel.dart';
import 'package:live_schdlue_app/datamodel/StationData.dart';
import 'package:side_header_list_view/side_header_list_view.dart';
import 'package:live_schdlue_app/home/StationWidget.dart';
import 'package:live_schdlue_app/datamodel/Schedule.dart';



class ScheduledPage extends StatefulWidget {

  final String title;
  final List<StationData> stationsDatas;
  ScheduledPage({Key key, this.title, this.stationsDatas}) : super(key: key);

  @override
  _ScheduledPageState createState() => new _ScheduledPageState(title, stationsDatas);
}

class _ScheduledPageState extends State<ScheduledPage> {
  _ScheduledPageState(this._title, this._stationDatas);

  final String _title;
  List<StationData> _stationDatas;
  List<String> _genreHeader;
  LiveProfileModel _liveProfileModel = new LiveProfileModel();

  @override
  void initState() {
    super.initState();
    _genreHeader = <String>[];
    _stationDatas.forEach((value) {
      String genre = value.genre;
      if (!_genreHeader.contains(genre))
        _genreHeader.add(genre);
    });
  }

  void onUpdateView(List<StationData> stationDatas) {
    setState(() {
      _stationDatas = stationDatas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SideHeaderListView(
        itemCount: names.length,
        padding: new EdgeInsets.all(16.0),
        itemExtend: 48.0,
        headerBuilder: (BuildContext context, int index) {
          return new SizedBox(width: 32.0,child: new Text(names[index].substring(0, 1), style: Theme.of(context).textTheme.headline,));
        },
        itemBuilder: (BuildContext context, int index) {
          return new Text(names[index], style: Theme.of(context).textTheme.headline,);
        },
        hasSameHeader: (int a, int b) {
          return names[a].substring(0, 1) == names[b].substring(0, 1);
        },
      ),
    );
  }
}

const names = const <String>[
  'Annie',
  'Arianne',
  'Bertie',
  'Bettina',
  'Bradly',
  'Caridad',
  'Carline',
  'Cassie',
  'Chloe',
  'Christin',
  'Clotilde',
  'Dahlia',
  'Dana',
  'Dane',
  'Darline',
  'Deena',
  'Delphia',
  'Donny',
  'Echo',
  'Else',
  'Ernesto',
  'Fidel',
  'Gayla',
  'Grayce',
  'Henriette',
  'Hermila',
  'Hugo',
  'Irina',
  'Ivette',
  'Jeremiah',
  'Jerica',
  'Joan',
  'Johnna',
  'Jonah',
  'Joseph',
  'Junie',
  'Linwood',
  'Lore',
  'Louis',
  'Merry',
  'Minna',
  'Mitsue',
  'Napoleon',
  'Paris',
  'Ryan',
  'Salina',
  'Shantae',
  'Sonia',
  'Taisha',
  'Zula',
];
