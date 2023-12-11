import 'package:flutter_chrome_app/model/education_model.dart';
import 'package:flutter_chrome_app/utils/string_extension.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

List<EducationModel> parseEducations({required String educationHTML}) {
  List<EducationModel> result = [];
  var document = parse(educationHTML);

  var scaffoldMain = document.getElementsByClassName('scaffold-layout__main');

  List<Element> educationBlocks = scaffoldMain.first.querySelectorAll('.pvs-list__item--line-separated');

  for (var education in educationBlocks) {
    var schoolName = education.querySelector('.hoverable-link-text span')?.text;

    var degree = education.querySelector('.t-14.t-normal span')?.text;

    var dates = education.querySelector('.t-14.t-normal.t-black--light span')?.text;
    var educationModel = EducationModel(
      schoolName: schoolName,
      degree: degree,
      dateRange: dates?.parseDateRange(),
    );
    result.add(educationModel);
  }

  return result;
}
