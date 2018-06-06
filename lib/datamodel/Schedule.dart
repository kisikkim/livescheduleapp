
class Schedule {
  Data current;
  List<Data> upcoming;

  Schedule.fromMap(Map<String, dynamic> jsonMap) {
    Map dataMap = jsonMap["data"];
    Map siteMap = dataMap["site"];
    Map scheduleMap = siteMap["schedule"];
    Map currentMap = scheduleMap["current"];

    current = new Data.fromMap(currentMap);
    List upcomingMap = scheduleMap["upcoming"];
    this.upcoming = new List<Data>();

    for(Map item in upcomingMap) {
      Data data = new Data.fromMap(item);
      this.upcoming.add(data);
    }
  }

}

class Destination {
  String href;
  String thumbnail;

  Destination.fromMap(Map dataMap) {
    Map destination = dataMap["destination"];
    this.href = destination["href"];
    this.thumbnail = destination["thumbnail"];

    if(!this.thumbnail.startsWith("http")) {
      this.thumbnail = "http:"+this.thumbnail;
    }
  }
}


class Data {
  String name;
  int core_show_id;
  String start;
  String stop;
  Destination destination;

  Data.fromMap(Map dataMap) {
    name = dataMap["name"];
    core_show_id = dataMap["core_show_id"];
    start = dataMap["start"];
    stop = dataMap["stop"];
    destination = new Destination.fromMap(dataMap);
  }


}