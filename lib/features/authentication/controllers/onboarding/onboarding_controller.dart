import 'package:ecomm/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

//Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

//update Current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;
//jump to specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

//Update current index & jumps to next page
  void nextPage() {
    if (currentPageIndex == 2) {
      final storage = GetStorage();
      storage.write('isfirsttime', false);
      Get.offAll(LoginPage());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

//Update current index & jumps to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
