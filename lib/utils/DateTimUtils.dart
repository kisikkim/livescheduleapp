import 'package:live_schdlue_app/datamodel/Schedule.dart';

class DateTimeUtils {

  static const String dateStart = "dateStart";
  static const String dateEnd = "dateEnd";



  int convertToHour(String data) {


    List<String> info = data.split(" ");
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

  List<ScheduleData> convertStringToDate(List<ScheduleData> data) {
    List<ScheduleData> list = covertDataTme(data, dateStart);
    return covertDataTme(list, dateEnd);
  }


  List<ScheduleData> covertDataTme(List<ScheduleData> list, String dateField) {
    ScheduleData previous = null;
    DateTime now = new DateTime.now();
    int day = 0;

    for(ScheduleData data in list) {

      int hour = convertToHour(getConvertDateField(data, dateField));

      if(previous != null) {
        int previousHour = convertToHour(getConvertDateField(previous, dateField));

        if(hour < previousHour) {
          day = day +1;
        }
      }

      DateTime newDateTime = new DateTime(
          now.year,
          now.month,
          now.day + day,
          hour);

      setDateTimeField(data, newDateTime, dateField);
      previous = data;


    }

    return list;
  }

  String getConvertDateField(ScheduleData data, String dateField) {
    if(dateField == dateStart) {
      return data.start;
    } else {
      return data.stop;
    }
  }

  void setDateTimeField(ScheduleData data, DateTime newDateTime, String dateField) {
    if(dateField == dateStart) {
      data.startTime = newDateTime;
    } else {
      data.endTime = newDateTime;
    }
  }

}