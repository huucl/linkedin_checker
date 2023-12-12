import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chrome_extension/tabs.dart';
import 'package:chrome_extension/windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/linkedin_user_detail_model.dart';
import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/ui/screen/home/home_controller.dart';
import 'package:flutter_chrome_app/utils/parser/education_parser.dart';
import 'package:flutter_chrome_app/utils/parser/profile_parser.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.item,
    required this.stt,
    this.onTap,
  });

  final LinkedinUserModel item;
  final int stt;
  final VoidCallback? onTap;

  void launchNewTabURL(String url) async {
    int experienceTabId = 0;
    int skillTabId = 0;
    int educationTabId = 0;

    String experienceHTML = '';
    String skillHTML = '';
    String educationHTML = '';

    var user = item;

    Future<void> fetchTabHTML(int tabID) async {
      await Future.delayed(const Duration(seconds: 10));
      var value = await chrome.tabs.get(tabID);
      if (value.status != TabStatus.loading) {
        try {
          var value = await chrome.tabs.sendMessage(tabID, "message_item", null);
          var html = parse(value.toString());
          if (tabID == experienceTabId) {
            experienceHTML = html.outerHtml;
          } else if (tabID == skillTabId) {
            skillHTML = html.outerHtml;
          } else if (tabID == educationTabId) {
            educationHTML = html.outerHtml;
          }
        } catch (e) {
          AppNavigators.gotoLogInfo(e.toString());
        }
      }
    }

    var experienceValue = await chrome.tabs.create(CreateProperties(url: '$url/details/experience', active: false));
    experienceTabId = experienceValue.id ?? 0;

    var skillValue = await chrome.tabs.create(CreateProperties(url: '$url/details/skills', active: false));
    skillTabId = skillValue.id ?? 0;

    var educationValue = await chrome.tabs.create(CreateProperties(url: '$url/details/education', active: false));
    educationTabId = educationValue.id ?? 0;

    var res = await Future.wait([
      fetchTabHTML(experienceTabId),
      fetchTabHTML(skillTabId),
      fetchTabHTML(educationTabId),
    ]);

    var profile = parseExperiences(experienceHTML: experienceHTML, skillHTML: skillHTML);
    var educations = EducationParser.parseEducations(educationHTML: educationHTML);

    //close tabs
    chrome.tabs.remove(experienceTabId);
    chrome.tabs.remove(skillTabId);
    chrome.tabs.remove(educationTabId);

    var homeController = Get.find<HomeController>();
    homeController.isLoading.value = false;
    AppNavigators.gotoAddCandidate(
        user: LinkedinUserDetailModel.fromObjects(
      user: user,
      profileResult: profile,
      educations: educations,
    ))?.then((value) {
      homeController.checkDuplicateLinkedinProfile();
    });
  }

  void launchNewWindow() {
    chrome.windows.create(
      CreateData(
        url: item.url,
        focused: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        launchNewTabURL(item.url);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('#$stt', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: item.avatar,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
                placeholder: (
                  BuildContext context,
                  String url,
                ) {
                  return const Icon(Icons.person);
                },
                errorWidget: (_, __, ___) {
                  return CachedNetworkImage(
                      imageUrl:
                          'https://media.licdn.com/dms/image/D4D0BAQH4TwiyEOT6Vg/company-logo_200_200/0/1686631084785?e=1704326400&v=beta&t=zkc8S6unhad3pfO2b34ilM5OFQsOQsg0spZSC_7ibPQ');
                },
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(item.name),
                const SizedBox(width: 4),
                item.getIcon(),
                SelectableText(item.location),
                TextButton(
                  onPressed: () {
                    launchNewWindow();
                  },
                  child: Text(item.url),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
