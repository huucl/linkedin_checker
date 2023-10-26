import 'package:html/parser.dart';

class SaleQLParser {
  static (String? email, String? phoneCode, String? phoneNumber) getData({required String doc}) {
    try {
      var document = parse(doc);
      var blocks = document.querySelectorAll('._2uhMtp0sIVUqJ-73kplv');

      var emailBlock = blocks[0];
      var phoneBlock = blocks[1];

      var allEmails = emailBlock.querySelectorAll('._1s6ahIjeybQUNlWLaOvk._2Eo_7ePJriNTmf_6Z9FA');

      String? email;
      String? verifiedEmail;

      for (var element in allEmails) {
        if (element.text.trim().contains('verified') && element.text.trim().contains('Direct')) {
          email = element.text.trim().extractEmail();
        }
        if (element.text.trim().contains('verified')){
          verifiedEmail = element.text.trim().extractEmail();
        }
      }

      email ??= verifiedEmail;

      //similar for phone block
      String? phoneCode;
      String? phoneNumber;

      var allPhones = phoneBlock.querySelectorAll('._1s6ahIjeybQUNlWLaOvk._2Eo_7ePJriNTmf_6Z9FA');

      for (var element in allPhones) {
        if (element.text.trim().contains('verified') && element.text.trim().contains('Direct')) {
          var result = element.text.trim().extractPhone();
          phoneCode = result.$1;
          phoneNumber = result.$2;
        }
      }

      return (email, phoneCode, phoneNumber);
    } catch (e) {
      return (null, null, null);
    }
  }
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
