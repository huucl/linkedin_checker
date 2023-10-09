class LinkedinUserModel {
  String name;
  String avatar;
  String url;

  LinkedinUserModel(
      {required this.name, required this.avatar, required this.url});

  @override
  String toString() {
    return 'LinkedinUserModel{name: $name, avatar: $avatar, url: $url}';
  }
}
