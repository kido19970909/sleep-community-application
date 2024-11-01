import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_routes.dart';
import 'package:sleep_app/pages/main_page/home_page/home_page.dart';
import 'package:sleep_app/pages/main_page/my_page/my_page.dart';

class MainPageController extends GetxController {
  PageController signUpPageController = PageController();

  var selectedIndex = 0.obs;
  List<Widget> pages = [];
  @override
  void onInit() {
    super.onInit();
    pages = [
      HomePage(),
      HomePage(),
      MyPage(),
    ];
  }

  final pageOptions = [
    {
      'route': GlobalRoutes.main,
      'icon': 'navi_home.png',
      'label': '홈',
    },
    {
      'route': GlobalRoutes.main,
      'icon': 'navi_community.png',
      'label': '채팅',
    },
    {
      'route': GlobalRoutes.my,
      'icon': 'navi_profile.png',
      'label': '마이',
    },
  ];

  BottomNavigationBarItem buildBottomNavItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
        icon: Column(
          children: [
            Obx(() => Image.asset(
                  'assets/icons/$icon',
                  color: selectedIndex.value == index ? GlobalColor.black1Normal : GlobalColor.gray2,
                  width: 24,
                  height: 24,
                )),
            SizedBox(height: 6)
          ],
        ),
        label: label,
        backgroundColor: Colors.white);
  }
}
