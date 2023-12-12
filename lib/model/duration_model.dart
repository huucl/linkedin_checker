import 'package:flutter_chrome_app/utils/string_extension.dart';

class DurationModel {
  int year;
  int month;
  int? fromMonth;
  int? fromYear;
  int? toMonth;
  int? toYear;
  bool? isNew;

  DurationModel({
    required this.year,
    required this.month,
    this.isNew,
    this.fromMonth,
    this.fromYear,
    this.toMonth,
    this.toYear,
  });

  //parser
  DurationModel.fromString(String duration)
      : year = 0,
        month = 0,
        isNew = false {
    if (duration.contains('Present')) {
      isNew = true;
    } else {
      isNew = false;
    }
    var firstPart = duration.split(' · ')[0];
    duration = duration.split(' · ')[1];
    if (duration.contains('yr')) {
      year = int.parse(duration.split('yr')[0].trim());
      if (duration.contains('yrs')) {
        duration = duration.split('yrs')[1];
      } else {
        duration = duration.split('yr')[1];
      }
    }
    if (duration.contains('mos')) {
      month = int.parse(duration.split('mo')[0].trim());
    }
    try {
      if (isNew == false) {
        var from = firstPart.split(' - ')[0];
        var to = firstPart.split(' - ')[1];
        fromMonth = from.split(' ')[0].getMonthNumber();
        fromYear = int.parse(from.split(' ')[1]);
        toMonth = to.split(' ')[0].getMonthNumber();
        toYear = int.parse(to.split(' ')[1]);
      } else {
        var from = firstPart.split(' – ')[0];
        fromMonth = from.split(' ')[0].getMonthNumber();
        fromYear = int.parse(from.split(' ')[1]);
      }
    } catch (e) {
      print('e: $e');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'isNew': isNew,
      'fromMonth': fromMonth,
      'fromYear': fromYear,
      'toMonth': toMonth,
      'toYear': toYear,
    };
  }

  factory DurationModel.fromMap(Map<String, dynamic> map) {
    return DurationModel(
      year: map['year'] as int,
      month: map['month'] as int,
      isNew: map['isNew'] as bool,
      fromMonth: map['fromMonth'] as int?,
      fromYear: map['fromYear'] as int?,
      toMonth: map['toMonth'] as int?,
      toYear: map['toYear'] as int?,
    );
  }
}