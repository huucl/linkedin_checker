import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/ui/screen/home/home_controller.dart';
import 'package:flutter_chrome_app/user_item.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeyCRM duplicate checker'),
        actions: [
          IconButton(
            onPressed: () {
              controller.checkDuplicateLinkedinProfile();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return controller.isCorrectSites.value
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return ListView.separated(
                    itemBuilder: (c, i) {
                      var user = controller.users[i];
                      return UserItem(
                        item: user,
                        stt: i + 1,
                        onTap: () {
                          controller.isLoading.value = true;
                          Future.delayed(const Duration(seconds: 2), () {
                            controller.isLoading.value = true;
                            var snackBar = const SnackBar(
                              content: Text('UPDATED'),
                              duration: Duration(milliseconds: 200),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar,
                            );
                          });
                        },
                      );
                    },
                    separatorBuilder: (c, i) {
                      return const Divider(
                        thickness: 2,
                        color: Colors.blueGrey,
                        height: 8,
                      );
                    },
                    itemCount: controller.users.length);
              }),
            )
            : const Center(
          child: Text(
            'Please open LinkedIn profile or search page',
          ),
        );
      }),
    );
  }
}
