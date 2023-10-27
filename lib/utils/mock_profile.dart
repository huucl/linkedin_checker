import 'package:flutter_chrome_app/utils/mock_data.dart';
import 'package:html/parser.dart';

void main() {
  var document = parse(mockSQL);
  var blocks = document.querySelectorAll('._2uhMtp0sIVUqJ-73kplv');

  var emailBlock = blocks[0];
  var phoneBlock = blocks[1];
  
  var allEmails = emailBlock.querySelectorAll('._1s6ahIjeybQUNlWLaOvk._2Eo_7ePJriNTmf_6Z9FA');

  String? email;

  List<String> emails = allEmails.map((e) => e.text.trim()).toList().sortAlgo();
  print(emails);

  email = emails.first.extractEmail();


  //similar for phone block
  String? phoneCode;
  String? phoneNumber;

  var allPhones = phoneBlock.querySelectorAll('._1s6ahIjeybQUNlWLaOvk._2Eo_7ePJriNTmf_6Z9FA');

  var phones = allPhones.map((e) => e.text.trim()).toList().sortAlgo();

  var res = phones.first.extractPhone();

  phoneCode = res.$1;
  phoneNumber = res.$2;

  print('Email: $email');
  print('Phone code: $phoneCode');
  print('Phone number: $phoneNumber');


  String text = """============= 
verified  
    +84 94 696 90 03
    
        +84 94 696 90 03
       
    Direct
   
    Copy
    
        content_copy
 ============== 
verified  
    +84 313 569 123
    
        +84 313 569 123
       
    SSI Securities Corporation
    
    Work
   
    Copy
    
        content_copy
 ============== 
verified  
    +84 94 696 90 03
    
        +84 94 696 90 03
       
    Direct
   
    Copy
    
        content_copy
 ============== 
verified  
    +84 313 569 123
    
        +84 313 569 123
       
    SSI Securities Corporation
    
    Work
   
    Copy
""";

  var texts = text.split(' ============== ');


  print(texts.first.extractPhone());

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
    RegExp phoneRegex = RegExp(r'(\+\d+)\s([\d\s]+)');
    final match = phoneRegex.firstMatch(this);
    if (match != null) {
      return (match.group(1), match.group(2)?.replaceAll(RegExp(r'\s'), ''));
    }
    return (null, null); // No phone number found in the string
  }
}

extension on List<String> {
  //sorting base on contains 'verified' and 'Direct' -> 'verified' and 'Work' -> 'Direct' -> 'Work'
  List<String> sortAlgo() {
    var verifiedDirect = <String>[];
    var verifiedWork = <String>[];
    var direct = <String>[];
    var work = <String>[];

    for (var element in this) {
      if (element.contains('verified') && element.contains('Direct')) {
        verifiedDirect.add(element);
      }
      if (element.contains('verified') && element.contains('Work')) {
        verifiedWork.add(element);
      }
      if (element.contains('Direct')) {
        direct.add(element);
      }
      if (element.contains('Work')) {
        work.add(element);
      }
    }

    verifiedDirect.sort((a, b) => a.compareTo(b));
    verifiedWork.sort((a, b) => a.compareTo(b));
    direct.sort((a, b) => a.compareTo(b));
    work.sort((a, b) => a.compareTo(b));

    return verifiedDirect + verifiedWork + direct + work;
  }
}