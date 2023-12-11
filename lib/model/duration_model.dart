class DurationModel {
  int year;
  int month;
  bool? isNew;

  DurationModel({
    required this.year,
    required this.month,
    this.isNew,
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
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'isNew': isNew,
    };
  }

  factory DurationModel.fromMap(Map<String, dynamic> map) {
    return DurationModel(
      year: map['year'] as int,
      month: map['month'] as int,
      isNew: map['isNew'] as bool,
    );
  }
}