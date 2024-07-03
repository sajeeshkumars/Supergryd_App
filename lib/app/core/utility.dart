import 'package:intl/intl.dart';

class Utility {
  static countConverter(int count) {
    if ((count > 999) && count < 99999) {
      return '${(count / 1000).toStringAsFixed(1)} K';
    } else if (count > 99999 && count < 999999) {
      return '${(count / 1000).toStringAsFixed(0)} K';
    } else if (count > 999999 && count < 999999999) {
      return '${(count / 1000000).toStringAsFixed(1)} M';
    } else if (count > 999999999) {
      return '${(count / 1000000000).toStringAsFixed(1)} B';
    } else {
      return count.toString();
    }
  }

  static dateAndTime(String date){

    DateTime dateTime = DateTime.parse(date);

    String formattedDateTime = DateFormat('dd MMM yyyy hh:mm a').format(dateTime.toLocal());

    return formattedDateTime;
  }

  // static takeLocalDateFrom(String date) {
  //   DateTime dateTime = DateTime.parse(date);
  //
  //   String formattedTime = DateFormat('hh:mm a').format(dateTime.toLocal());
  //
  //   return formattedTime;
  // }
  //
  // static takeDateOnly(String date){
  //
  //   DateTime dateTime = DateTime.parse(date);
  //
  //   String formattedDate = DateFormat('dd MMM yyy').format(dateTime.toLocal());
  //
  //   return formattedDate;
  // }
  }
