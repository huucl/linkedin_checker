import 'package:chrome_extension/windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/model/education_model.dart';
import 'package:flutter_chrome_app/model/url_item.dart';
import 'package:flutter_chrome_app/user_parser.dart';
import 'package:flutter_chrome_app/utils/parser/education_parser.dart';
import 'package:flutter_chrome_app/utils/parser/profile_parser.dart';
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
      body: Stack(
        children: [
          Obx(() {
            if (controller.isSearch.value) {
              return ListView.separated(
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
                  });
            } else {
              return const Center(
                child: Text('Please open google search'),
              );
            }
          }),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
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

  Future<String> getHTML({required String url}) async {
    var tab = await chrome.tabs.create(CreateProperties(url: url, active: false));
    await Future.delayed(const Duration(seconds: 10));
    var value = await chrome.tabs.sendMessage(tab.id!, "message_item", null);
    // chrome.tabs.remove(tab.id!);
    ids.add(tab.id!);
    return value.toString();
  }

  void fetchProfile() async {
    var googleController = Get.find<GoogleSearchController>();
    try {
      googleController.isLoading.value = true;
      var response = await Future.wait([
        getHTML(url: widget.item.url),
        getHTML(url: '${widget.item.url}/details/skills'),
        getHTML(url: '${widget.item.url}/details/experience'),
        getHTML(url: '${widget.item.url}/details/education')
      ]);

      String profileHTML = response[0];
      String skillHTMl = response[1];
      String experienceHTML = response[2];
      String educationHTML = response[3];

      ProfileResult res = parseExperiences(experienceHTML: experienceHTML, skillHTML: skillHTMl);

      LinkedinUserModel coverUser = UserProfileParser.userParser(profileHTML, widget.item.url);

      List<EducationModel> educations = EducationParser.parseEducations(educationHTML: educationHTML);

      user = LinkedinUserDetailModel.fromObjects(
        user: coverUser,
        profileResult: res,
        educations: educations,
      );

      AppNavigators.gotoAddCandidate(user: user)?.then((value) {
        googleController.checkDuplicateLinkedinProfile();
      });
      for (var element in ids) {
        chrome.tabs.remove(element);
      }
      googleController.isLoading.value = false;
    } catch (e) {
      googleController.isLoading.value = false;
      AppNavigators.gotoLogInfo(e.toString());
    }
  }

  void launchNewWindow() {
    chrome.windows.create(
      CreateData(
        url: widget.item.url,
        focused: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.item.getIcon(),
      title: Text(widget.item.title),
      subtitle: Text(widget.item.url),
      onTap: () {
        fetchProfile();
      },
      trailing: IconButton(
        icon: const Icon(Icons.open_in_browser),
        onPressed: () {
          launchNewWindow();
        },
      ),
    );
  }
}
