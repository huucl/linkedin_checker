import 'package:flutter_chrome_app/model/custom_datetime_model.dart';

extension ParseDateRange on String {
  CustomDatetime parseDateRange() {
    var parts = split(' - ');

    var from = parts[0].split(' ');
    var fromMonth = getMonthNumber(from[0]);
    var fromYear = int.parse(from[1]);

    var to = parts[1].split(' ');
    var toMonth = getMonthNumber(to[0]);
    var toYear = int.parse(to[1]);

    return CustomDatetime(
      fromMonth: fromMonth,
      fromYear: fromYear,
      toMonth: toMonth,
      toYear: toYear,
    );
  }

  CustomDatetime parseDateRangeForDotted() {
    var firstPart = split(' · ')[0];
    var parts = firstPart.split(' - ');

    var from = parts[0].split(' ');
    var fromMonth = getMonthNumber(from[0]);
    var fromYear = int.tryParse(from[1]);

    try {
      var to = parts[1].split(' ');
      var toMonth = getMonthNumber(to[0]);
      var toYear = int.tryParse(to[1]);

      return CustomDatetime(
        fromMonth: fromMonth,
        fromYear: fromYear,
        toMonth: toMonth,
        toYear: toYear,
      );
    } catch (_) {}

    return CustomDatetime(
      fromMonth: fromMonth,
      fromYear: fromYear,
      toMonth: null,
      toYear: null,
      isPresent: contains('Present'),
    );
  }

  int getMonthNumber(String month) {
    switch (month) {
      case 'Jan':
        return 1;
      case 'Feb':
        return 2;
      case 'Mar':
        return 3;
      case 'Apr':
        return 4;
      case 'May':
        return 5;
      case 'Jun':
        return 6;
      case 'Jul':
        return 7;
      case 'Aug':
        return 8;
      case 'Sep':
        return 9;
      case 'Oct':
        return 10;
      case 'Nov':
        return 11;
      case 'Dec':
        return 12;
      default:
        return 0;
    }
  }
}
