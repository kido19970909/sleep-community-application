import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_routes.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';
import 'package:sleep_app/pages/signup_page/signup_page.dart';

class SignInPage extends GetView<MainPageController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  String? _emailError;
  String? _passwordError;
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _obscurePassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: appBar(),
      body: Stack(
        children: [
          loginBody(),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: GlobalColor.primary,
                ))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Form loginBody() {
    return Form(
      key: _formKeyLogin,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '반가워요!\n메일 주소와 비밀번호를 입력해주세요',
                    style: GlobalTextstyles.h1Title18B.copyWith(
                      color: GlobalColor.black1Normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            CustomTextField(
              controller: _emailController,
              hintText: '메일 입력',
              isError: () => _emailError != null && _emailController.text.isNotEmpty,
            ),
            mailErrorText(),
            SizedBox(height: 24),
            CustomTextField(
              controller: _pwController,
              obscureText: _obscurePassword,
              hintText: '비밀번호 입력',
              isError: () => _passwordError != null && _pwController.text.isNotEmpty,
            ),
            pwErrorText(),
            SizedBox(height: 20),
            loginBtn(),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(SignUpPage());
              },
              behavior: HitTestBehavior.translucent,
              child: Text(
                '회원가입',
                style: GlobalTextstyles.body14.copyWith(color: GlobalColor.gray1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container loginBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: Get.width,
      height: 50,
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
            side: BorderSide(width: 1, color: GlobalColor.primary),
          ),
        ),
        child: Text(
          '로그인',
          style: GlobalTextstyles.h3Title14M.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Padding buildErrorText(String? errorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              errorText ?? '',
              style: GlobalTextstyles.body12.copyWith(color: GlobalColor.error),
            ),
          ),
        ],
      ),
    );
  }

  Padding mailErrorText() {
    return buildErrorText(_emailError);
  }

  Padding pwErrorText() {
    return buildErrorText(_passwordError);
  }

  void _validateInput({
    required TextEditingController controller,
    required String emptyError,
    required String invalidError,
    required ValueSetter<bool> isValidSetter,
    required ValueSetter<String?> errorSetter,
  }) {
    final value = controller.text;
  }

  void _validateEmail() {
    _validateInput(
      controller: _emailController,
      emptyError: '',
      invalidError: '메일 주소를 확인해주세요.',
      isValidSetter: (isValid) => _isValidEmail = isValid,
      errorSetter: (error) => _emailError = error,
    );
  }

  void _validatePassword() {
    _validateInput(
      controller: _pwController,
      emptyError: '',
      invalidError: '비밀번호는 8자리 이상이어야 합니다.',
      isValidSetter: (isValid) => _isValidPassword = isValid,
      errorSetter: (error) => _passwordError = error,
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: GlobalColor.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 20,
      title: Text('로그인',
          style: GlobalTextstyles.h2Title16B.copyWith(
            color: GlobalColor.black1Normal,
          )),
      shape: const Border(bottom: BorderSide(color: GlobalColor.gray4Back1, width: 1)),
      toolbarHeight: 50,
      centerTitle: false,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool Function() isError;
  final bool? obscureText;
  final bool? isValid;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isError,
    this.obscureText,
    this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        cursorColor: GlobalColor.black1Normal,
        cursorWidth: 1,
        cursorHeight: 14,
        enabled: isValid ?? true,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          filled: !(isValid ?? true),
          fillColor: isValid ?? true ? GlobalColor.white : GlobalColor.gray4Back1,
          contentPadding: const EdgeInsets.all(12),
          hintText: hintText,
          hintStyle: GlobalTextstyles.body14.copyWith(color: GlobalColor.gray3),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(
              color: GlobalColor.gray4Back1,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(
              color: GlobalColor.gray3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(
              color: isError() ? GlobalColor.error : GlobalColor.gray4Back1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(
              color: isError() ? GlobalColor.error : GlobalColor.gray4Back1,
            ),
          ),
        ),
      ),
    );
  }
}
