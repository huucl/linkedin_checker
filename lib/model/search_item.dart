// To parse this JSON data, do
//
//     final skillRes = skillResFromMap(jsonString);

import 'dart:convert';

List<SearchItem> searchItemFromMap(String str) =>
    List<SearchItem>.from(json.decode(str).map((x) => SearchItem.fromMap(x)));

class SearchItem {
  final String? id;
  final String? label;

  SearchItem({
    this.id,
    this.label,
  });

  factory SearchItem.fromMap(Map<String, dynamic> json) => SearchItem(
        id: json["id"],
        label: json["label"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "label": label,
      };
}
