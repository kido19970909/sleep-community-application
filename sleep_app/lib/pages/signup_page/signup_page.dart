import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';
import 'package:sleep_app/pages/signup_page/signup_first_page.dart';
import 'package:sleep_app/pages/signup_page/signup_second_page.dart';

class SignUpPage extends GetView<MainPageController> {
  var _currentPageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: appBar(controller.signUpPageController),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.signUpPageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) {
                  _currentPageIndex.value = index;
                },
                children: [
                  SignUpFirstPage(),
                  SignUpSecondPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToNextPage() {
    if (controller.signUpPageController.hasClients) {
      controller.signUpPageController.animateToPage(
        controller.signUpPageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  AppBar appBar(PageController pageController) {
    return AppBar(
      backgroundColor: GlobalColor.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Image.asset(
          'assets/icons/close.png',
          color: GlobalColor.black1Normal,
          width: 15.5,
          height: 15.5,
        ),
      ),
      titleSpacing: 0,
      title: Text('회원가입',
          style: GlobalTextstyles.h2Title16B.copyWith(
            color: GlobalColor.black1Normal,
          )),
      centerTitle: false,
    );
  }
}
