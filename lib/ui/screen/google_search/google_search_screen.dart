import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/model/url_item.dart';
import 'package:flutter_chrome_app/user_parser.dart';
import 'package:flutter_chrome_app/utils/profile_parser.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' hide Text;
import 'package:html/parser.dart';

import 'google_search_controller.dart';
import 'package:chrome_extension/tabs.dart';

class GoogleSearchScreen extends GetWidget<GoogleSearchController> {
  const GoogleSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchData();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          }),
          Obx(() {
            if (controller.isSearch.value) {
              return Expanded(
                child: ListView.separated(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    var item = controller.items[index];
                    return UrlItemWidget(item: item);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 2,
                      color: Colors.blueGrey,
                      height: 8,
                    );
                  }
                ),
              );
            } else {
              return const Center(
                child: Text('Please open google search'),
              );
            }
          }),
        ],
      ),
    );
  }
}

class UrlItemWidget extends StatefulWidget {
  const UrlItemWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  final UrlItem item;
  final Function(LinkedinUserDetailModel)? onTap;

  @override
  State<UrlItemWidget> createState() => _UrlItemWidgetState();
}

class _UrlItemWidgetState extends State<UrlItemWidget> {
  LinkedinUserDetailModel user = LinkedinUserDetailModel();

  List<int> ids = [];

  Future<Document> getHTML({required String url}) async {
    var tab = await chrome.tabs.create(CreateProperties(url: '$url/details/experience', active: false));
    await Future.delayed(const Duration(seconds: 5));
    var value = await chrome.tabs.sendMessage(tab.id!, "message_item", null);
    // chrome.tabs.remove(tab.id!);
    ids.add(tab.id!);
    return parse(value.toString());
  }

  void fetchProfile() async {
    try {
      Document profileHTML = Document();
      getHTML(url: widget.item.url).then((value) => profileHTML = value);
      Document skillHTMl = Document();
      getHTML(url: '${widget.item.url}/details/skills').then((value) => skillHTMl = value);
      var experienceHTML = await getHTML(url: '${widget.item.url}/details/experience');

      ProfileResult res = parseExperiences(experienceHTML: experienceHTML.outerHtml, skillHTML: skillHTMl.outerHtml);
      LinkedinUserModel coverUser = UserProfileParser.userParserFromDoc(profileHTML, widget.item.url);

      user = LinkedinUserDetailModel.fromObjects(user: coverUser, profileResult: res);
      AppNavigators.gotoAddCandidate(user: user);
      for (var element in ids) {
        chrome.tabs.remove(element);
      }
    } catch (e) {
      AppNavigators.gotoLogInfo(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.item.getIcon(),
      title: Text(widget.item.url),
      onTap: () {
        fetchProfile();
      },
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          fetchProfile();
        },
      ),
    );
  }
}
