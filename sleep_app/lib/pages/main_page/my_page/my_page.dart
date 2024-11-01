import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_routes.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';
import 'package:sleep_app/pages/signin_page/signin_page.dart';

class MyPage extends GetView<MainPageController> {
  String version = '';
  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      body: CustomScrollView(
        slivers: [
          appBar(),
          SliverToBoxAdapter(
            child: userNameWIdget(),
          ),
          SliverToBoxAdapter(
            child: dividerWidget(),
          ),
          SliverToBoxAdapter(
            child: menuBtn('내 활동 보기', () async {}),
          ),
          SliverToBoxAdapter(
            child: dividerWidget(height: 1, color: GlobalColor.gray4Back1),
          ),
          SliverToBoxAdapter(
            child: menuBtn('내 정보 관리', () {}),
          ),
          SliverToBoxAdapter(
            child: dividerWidget(),
          ),
          SliverToBoxAdapter(
            child: menuBtn('자주 묻는 질문', () {}),
          ),
          SliverToBoxAdapter(
            child: dividerWidget(height: 1, color: GlobalColor.gray4Back1),
          ),
          SliverToBoxAdapter(
            child: menuBtn('공지사항', () {}),
          ),
          SliverToBoxAdapter(
            child: dividerWidget(),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                children: [
                  Text(
                    '앱 버전',
                    style: GlobalTextstyles.body14.copyWith(color: GlobalColor.black1Normal),
                  ),
                  SizedBox(width: 4),
                  Text(
                    version,
                    style: GlobalTextstyles.body14.copyWith(color: GlobalColor.gray3),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: dividerWidget(height: 1, color: GlobalColor.gray4Back1),
          ),
          SliverToBoxAdapter(
            child: menuBtn('로그아웃', () {
              Get.offAllNamed(GlobalRoutes.signin);
            }),
          ),
          SliverToBoxAdapter(
            child: dividerWidget(),
          ),
        ],
      ),
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      floating: false,
      pinned: true,
      shape: const Border(bottom: BorderSide(color: GlobalColor.gray4Back1, width: 1)),
      title: Text(
        '마이페이지',
        style: GlobalTextstyles.h2Title16B.copyWith(color: GlobalColor.black1Normal),
      ),
      centerTitle: false,
      actions: [
        Container(
          height: 24,
          width: 24,
          child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            iconSize: 24,
            icon: Image.asset(
              'assets/icons/notification.png',
              color: GlobalColor.black1Normal,
            ),
          ),
        ),
        SizedBox(width: 13)
      ],
      backgroundColor: GlobalColor.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 50,
    );
  }

  menuBtn(String title, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        color: GlobalColor.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Text(
              title,
              style: GlobalTextstyles.body14.copyWith(color: GlobalColor.black1Normal),
            )
          ],
        ),
      ),
    );
  }

  Container dividerWidget({double height = 8, Color color = GlobalColor.gray5Back2}) {
    return Container(
      width: 100.w,
      height: height,
      color: color,
    );
  }

  Column userNameWIdget() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(height: 32),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              'tester',
              style: GlobalTextstyles.h0Title20B.copyWith(color: GlobalColor.black1Normal),
            ),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'tester@gmail.com',
                style: GlobalTextstyles.body14.copyWith(color: GlobalColor.gray3),
              ),
              const Spacer(),
            ],
          ))
    ]);
  }
}
