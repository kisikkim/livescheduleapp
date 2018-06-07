import 'package:live_schdlue_app/datamodel/Schedule.dart';

class DateTimeUtils {

  int convertToHour(Data data) {

    List<String> info = data.start.split(" ");
    int hour = int.parse(info[0].trim());
    String amorPm = info[1].toLowerCase().trim();

    if(hour == 12) {
      hour = 0;
    }

    if(amorPm == "pm") {
      hour = hour + 12;
    }

    return hour;

  }

  List<Data> covertDataTme(List<Data> list) {
    Data previous = null;
    DateTime now = new DateTime.now();
    int day = 0;

    for(Data data in list) {

      int hour = convertToHour(data);

      if(previous != null) {
        int previousHour = convertToHour(previous);

        if(hour < previousHour) {
          day = day +1;
        }
      }

      DateTime dateTime = new DateTime(
          now.year,
          now.month,
          now.day + day,
          hour);

      data.setStartTime(dateTime);
      previous = data;


    }

    return list;
  }

}