import 'package:flutter/material.dart';

class UrlItem {
  String url;
  bool? isFetch;

  UrlItem({
    required this.url,
    this.isFetch,
  });

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
