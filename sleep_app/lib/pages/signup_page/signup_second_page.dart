import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:get/route_manager.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_routes.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';

class SignUpSecondPage extends GetView<MainPageController> {
  final TextEditingController _otpController = TextEditingController();
  String? hash = '';
  String otpCode = '';
  bool isAuthExpired = false;

  @override
  Widget build(BuildContext context) {
    return authOKWidget();
  }

  Widget authOKWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Text(
                  '인증 코드를 전송했습니다',
                  style: GlobalTextstyles.h1Title18B.copyWith(
                    color: GlobalColor.black1Normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  "메일에 적힌 인증 코드를 입력해주세요.\n인증 코드는 5분 동안 유효합니다.",
                  style: GlobalTextstyles.body16DL.copyWith(
                    color: GlobalColor.black1Normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    cursorColor: GlobalColor.black1Normal,
                    cursorWidth: 1,
                    cursorHeight: 14,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      hintText: '인증 코드 입력',
                      hintStyle: GlobalTextstyles.body14.copyWith(color: GlobalColor.gray3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: GlobalColor.gray4Back1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: GlobalColor.gray4Back1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: GlobalColor.gray4Back1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 100.w,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: ElevatedButton(
              onPressed: () {
                Get.offAllNamed(GlobalRoutes.main);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColor.primary,
                disabledBackgroundColor: GlobalColor.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  // side: BorderSide(width: 1, color: _otpController.text.isEmpty ? GlobalColor.gray4Back1 : GlobalColor.black1Normal),
                ),
              ),
              child: Text(
                '메일 인증하기',
                style: GlobalTextstyles.h3Title14M.copyWith(color: GlobalColor.white),
              ),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
