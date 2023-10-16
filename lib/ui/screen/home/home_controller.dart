import 'package:chrome_extension/accessibility_features.dart';
import 'package:chrome_extension/tabs.dart';
import 'package:flutter_chrome_app/app_routes.dart';
import 'package:flutter_chrome_app/domain/repository/linked_check_repository.dart';
import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/mock.dart';
import 'package:flutter_chrome_app/user_parser.dart';
import 'package:flutter_chrome_app/utils/pref_util/pref_util.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LinkedCheckRepository _linkedCheckRepository;

  HomeController(this._linkedCheckRepository);

  RxBool isSearch = true.obs;
  RxBool isProfile = true.obs;
  RxBool isLoading = false.obs;
  RxList<LinkedinUserModel> users = RxList<LinkedinUserModel>();
  String currentTabUrl = '';

  @override
  void onReady() {
    super.onReady();
    fetchData();
    checkIsCorrectSites();
    // ever(users, (callback) => checkDuplicateLinkedinProfile());
  }

  void checkIsCorrectSites(){
    chrome.tabs.query(QueryInfo(active: true,currentWindow: true)).then((tabs) {
      var currentTab = tabs[0];
      currentTabUrl = currentTab.url ?? '';
      if (currentTab.url?.contains('https://www.linkedin.com/in') == true){
        isProfile.value = true;
      }
      if (currentTab.url?.contains('https://www.linkedin.com/search/results/people') == true){
        isSearch.value = true;
      }
    });
  }

  void fetchData() {
    chrome.tabs.query(QueryInfo(currentWindow: true, active: true)).then((value) {
      chrome.tabs.sendMessage(value[0].id!, "message_getList", null).then((value) {
        users.value = UserParser.bem(value.toString());
        users.refresh();
        checkDuplicateLinkedinProfile();
        // AppNavigators.gotoLogInfo(users.map((element) => element.toString()).join('\n'));
      }).catchError((onError) {
        AppNavigators.gotoLogInfo(onError.toString());
      });
    });
  }

  void fetchData2() {
    users.value = UserParser.bem(theHtmlString);
    users.refresh();
  }

  void checkDuplicateLinkedinProfile() async {
    var urls = users.map((e) => e.url).toList();
    // if (isProfile.value == true){
    //   urls = [currentTabUrl];
    // }
    isLoading.value = true;
    try {
      var usersResponse = await _linkedCheckRepository.checkLinkedinExistence(urls);
      for (var user in usersResponse) {
        users[user.order!].isFetch = user.status != 'NOT_REGISTERED';
      }
      users.refresh();
      isLoading.value = false;
    } catch (e) {
      AppNavigators.gotoLogInfo(PrefUtils().accessToken + '\n' + e.toString());
      isLoading.value = false;
    }
  }
}
