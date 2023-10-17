import 'package:flutter_chrome_app/utils/mock_data.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

void main() {
  var document = parse(mockProfileHtml);
  Element contentBlock = document.getElementsByClassName('artdeco-card ember-view pv-top-card').first;

  // Extract the avatar URL
  final Element? avatarImg = contentBlock.querySelector('.profile-photo-edit__preview');
  final String? avatarUrl = avatarImg?.attributes['src'];

  // Extract the name
  final Element? nameElement = contentBlock.querySelector('.text-heading-xlarge');
  final String? name = nameElement?.text;

  // Extract the location
  final Element? locationElement = contentBlock.querySelector('.text-body-small.inline.t-black--light.break-words');
  final String? location = locationElement?.text.trim();

  print('avatarUrl: $avatarUrl');
  print('name: $name');
  print('location: $location');
}

