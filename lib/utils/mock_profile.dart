import 'package:flutter_chrome_app/utils/mock_data.dart';
import 'package:html/parser.dart';

void main() {
  var document = parse(mockSQL);
  var blocks = document.querySelectorAll('._2uhMtp0sIVUqJ-73kplv');

  var emailBlock = blocks[0];
  var phoneBlock = blocks[1];
  
  var allEmails = emailBlock.querySelectorAll('._1s6ahIjeybQUNlWLaOvk._2Eo_7ePJriNTmf_6Z9FA');

  String? email;

  for (var element in allEmails) {
    var currentString = element.text.trim();
    if (element.text.trim().contains('verified') && element.text.trim().contains('Direct')) {
      email = element.text.trim().extractEmail();
    }
    print('-------------------');
  }



  //similar for phone block
  String? phoneCode;
  String? phoneNumber;

  var allPhones = phoneBlock.querySelectorAll('._1s6ahIjeybQUNlWLaOvk._2Eo_7ePJriNTmf_6Z9FA');

  allPhones.forEach((element) {
    print(element.text.trim());
    if (element.text.trim().contains('verified') && element.text.trim().contains('Direct')) {
      var result = element.text.trim().extractPhone();
      phoneCode = result.$1;
      phoneNumber = result.$2;
    }
    print('-------------------');
  });

  print('Email: $email');
  print('Phone code: $phoneCode');
  print('Phone number: $phoneNumber');

}

extension on String {
  String? extractEmail() {
    RegExp emailRegex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
    final match = emailRegex.firstMatch(this);
    if (match != null) {
      return match.group(0);
    }
    return null; // No email found in the string
  }

  //record type
  (String? phoneCode, String? phoneNumber) extractPhone() {
    RegExp phoneRegex = RegExp(r'(\+\d+)\s(\d+-\d+-\d+)');
    final match = phoneRegex.firstMatch(this);
    if (match != null) {
      return (match.group(1), match.group(2)?.replaceAll('-', ''));
    }
    return (null, null); // No email found in the string
  }
}