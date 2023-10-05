import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'mock.dart';

main(){

 var html = parse(theHtmlString);



  var items = html.getElementsByClassName("entity-result__item");

  List<LinkedinUserModel> users = [];
  for(int i = 0;i < items.length; i++){
   try{
    var element = items[i];
    var avatar = _getAvvat(element);

    var name = _getName(element);

    var link = _getLink(element);
    users.add(LinkedinUserModel(name: name ?? '',avatar: avatar ??'',url: link ?? ''));
   }catch(e){
    continue;
   }
  }
  // items.forEach((element) {
  // try{
  //  var avatar = _getAvvat(element);
  //
  //  var name = _getName(element);
  //
  //  var link = _getLink(element);
  //  print("name: $name");
  // }catch(e){
  //  print("LOI CMNR: ${e.toString()}");
  // }
  //
  //   // users.add(LinkedinUserModel(name: name ?? 'nullX', avatar: avatar ?? 'nullX', url: link ?? 'nullX'));
  // });

 print("users ${users.length}");

 expect(users.length, 9);
}

String? _getLink(Element element) {
  try {
    return element
       .getElementsByClassName("entity-result__universal-image")[0]
       .getElementsByClassName("app-aware-link")[0].attributes['href'];
  } on Exception catch (e) {
   return "KO CO _getLink";
  }
}

String? _getName(Element element) {
  try {
    return element
       .getElementsByClassName("entity-result__universal-image")[0]
       .getElementsByClassName("app-aware-link")[0].getElementsByTagName("img")[0]?.attributes['alt'];
  } on Exception catch (e) {
   return "KO CO _getName";
  }
}

String? _getAvvat(Element element) {
  try{
   return element
       .getElementsByClassName("entity-result__universal-image")[0]
       .getElementsByClassName("app-aware-link")[0].getElementsByTagName("img")[0]?.attributes['src'];
  }catch(e){
   return "KO CO _getAvvat";
  }
}


