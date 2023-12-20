import 'package:flutter_chrome_app/utils/string_extension.dart';

class DurationModel {
  int? fromMonth;
  int? fromYear;
  int? toMonth;
  int? toYear;
  bool? isNew;

  DurationModel({
    this.isNew,
    this.fromMonth,
    this.fromYear,
    this.toMonth,
    this.toYear,
  });

  //parser
  DurationModel.fromString(String duration) : isNew = false {
    if (duration.contains('Present')) {
      isNew = true;
    } else {
      isNew = false;
    }
    var firstPart = duration.split(' · ')[0];
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
      'isNew': isNew,
      'fromMonth': fromMonth,
      'fromYear': fromYear,
      'toMonth': toMonth,
      'toYear': toYear,
    };
  }

  factory DurationModel.fromMap(Map<String, dynamic> map) {
    return DurationModel(
      isNew: map['isNew'] as bool,
      fromMonth: map['fromMonth'] as int?,
      fromYear: map['fromYear'] as int?,
      toMonth: map['toMonth'] as int?,
      toYear: map['toYear'] as int?,
    );
  }
}
