import 'package:chrome_extension/accessibility_features.dart';
import 'package:chrome_extension/tabs.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/domain/repository/linked_check_repository.dart';
import 'package:flutter_chrome_app/model/url_item.dart';
import 'package:flutter_chrome_app/utils/google_search_parser.dart';
import 'package:flutter_chrome_app/utils/pref_util/pref_util.dart';
import 'package:get/get.dart';

class GoogleSearchController extends GetxController {
  final LinkedCheckRepository _linkedCheckRepository;

  GoogleSearchController(this._linkedCheckRepository);

  RxBool isSearch = true.obs;
  RxBool isLoading = false.obs;
  String currentTabUrl = '';

  RxList<GoogleResultItem> googleResItems = <GoogleResultItem>[].obs;
  RxList<UrlItem> items = <UrlItem>[].obs;

  @override
  void onReady() async {
    super.onReady();
    await checkIsCorrectSites();
    if (isSearch.value) {
      fetchData();
    }
  }

  Future<void> checkIsCorrectSites() async {
    isLoading.value = true;
    var tabs = await chrome.tabs.query(QueryInfo(currentWindow: true, active: true));
    var currentTab = tabs[0];
    currentTabUrl = currentTab.url ?? '';
    if (currentTab.url?.toLowerCase().contains('https://www.google.com/search') == true) {
      isSearch.value = true;
    } else {
      isSearch.value = false;
    }

    isLoading.value = false;
  }

  void fetchData() {
    chrome.tabs.query(QueryInfo(currentWindow: true, active: true)).then((value) {
      var currentTab = value[0];
      chrome.tabs.sendMessage(currentTab.id!, "message_getList", null).then((value) {
        if (isSearch.value) {
          googleResItems.value = GoogleSearchParser.getLinkedinUrls(value.toString());
          items.clear();
          items.addAll(googleResItems
              .map((e) => UrlItem(
                    url: e.url,
                    title: e.title,
                    isFetch: null,
                  ))
              .toList());
        }
        checkDuplicateLinkedinProfile();
        // AppNavigators.gotoLogInfo(users.map((element) => element.toString()).join('\n'));
      }).catchError((onError) {
        AppNavigators.gotoLogInfo('Error (fetchData): $onError');
      });
    });
  }

  void checkDuplicateLinkedinProfile() async {
    isLoading.value = true;
    try {
      var usersResponse = await _linkedCheckRepository.newCheckLinkedinExistence(googleResItems.map((element) => element.url).toList());
      for (int i = 0; i < usersResponse.length; i++) {
        items[i].isFetch = usersResponse[i].status != 'NOT_REGISTERED';
      }
      items.refresh();
      isLoading.value = false;
    } catch (e) {
      AppNavigators.gotoLogInfo('${PrefUtils().accessToken}\n$e');
      isLoading.value = false;
    }
  }
}
