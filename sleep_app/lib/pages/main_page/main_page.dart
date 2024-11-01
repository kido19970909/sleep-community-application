import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';

class MainPage extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1, color: Color(0x1961646B)),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 6,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: List.generate(controller.pageOptions.length, (index) {
            return controller.buildBottomNavItem(
                controller.pageOptions[index]['icon'] as String, controller.pageOptions[index]['label'] as String, index);
          }),
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: GlobalColor.primary,
          unselectedItemColor: GlobalColor.gray2,
          onTap: (value) {
            controller.selectedIndex.value = value;
          },
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
