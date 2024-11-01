import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';
import 'package:sleep_app/pages/signin_page/signin_page.dart';

class SignUpFirstPage extends GetView<MainPageController> {
  final TextEditingController _emailController = TextEditingController();

  bool _isValidEmail = false;
  String? _emailError;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('반가워요!\n메일 주소와 비밀번호를 입력해주세요',
                          style: GlobalTextstyles.h1Title18B.copyWith(
                            color: GlobalColor.black1Normal,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              CustomTextField(
                  controller: _emailController, hintText: '메일 입력', isError: () => _emailError != null && _emailController.text.isNotEmpty),
              SizedBox(height: 30),
              nextBtn(),
            ],
          ),
        ),
      ],
    );
  }

  Widget nextBtn() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                controller.signUpPageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColor.primary,
                disabledBackgroundColor: GlobalColor.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(width: 1, color: GlobalColor.primary),
                ),
              ),
              child: Text(
                '다음',
                style: GlobalTextstyles.h3Title14M.copyWith(color: GlobalColor.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
