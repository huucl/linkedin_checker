import 'package:flutter/material.dart';

class LinkedinUserModel {
  String name;
  String avatar;
  bool? isFetch;
  String url;

  LinkedinUserModel({required this.name, required this.avatar, required this.url, this.isFetch});

  @override
  String toString() {
    return 'LinkedinUserModel{name: $name, avatar: $avatar, url: $url, isFetch: $isFetch}';
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
