import 'package:flutter/material.dart';

class LinkedinUserModel {
  String name;
  String avatar;
  bool? isFetch;
  String url;
  String location;
  String? phoneCode;
  String? phoneNumber;
  String? email;

  LinkedinUserModel({
    required this.name,
    required this.avatar,
    required this.url,
    this.isFetch,
    required this.location,
    this.phoneCode,
    this.phoneNumber,
    this.email,
  });

  @override
  String toString() {
    return 'LinkedinUserModel{name: $name, avatar: $avatar, url: $url, isFetch: $isFetch, location: $location}';
  }

  Widget getIcon() {
    if (isFetch == true) {
      return const Icon(
        Icons.done,
        size: 20,
        color: Colors.green,
      );
    } else if (isFetch == false) {
      return const Icon(
        Icons.close,
        size: 20,
        color: Colors.red,
      );
    } else {
      return const Icon(
        Icons.hourglass_empty,
        size: 20,
        color: Colors.yellow,
      );
    }
  }
}
