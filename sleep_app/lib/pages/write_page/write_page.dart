import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';

class WritePage extends GetView<MainPageController> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  late String title = '';
  late String hintText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(children: [
            Positioned.fill(
              child: Column(
                children: [
                  appBar(title, context),
                  inPutWidget(),
                ],
              ),
            ),
            Positioned(
              right: 26,
              bottom: 16,
              child: fab(),
            ),
          ]),
        ));
  }

  Widget fab() {
    return SizedBox(
      width: 42,
      height: 42,
      child: FloatingActionButton(
        onPressed: () async {
          await selectImage();
        },
        elevation: 0,
        backgroundColor: GlobalColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
          side: BorderSide.none,
        ),
        child: Image.asset('assets/icons/photo.png', width: 24, height: 24, color: Colors.white),
      ),
    );
  }

  Future<void> selectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      var croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: CropAspectRatio(ratioX: 9, ratioY: 16),
          compressFormat: ImageCompressFormat.png,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: '이미지',
              cropStyle: CropStyle.rectangle,
              hideBottomControls: true,
              toolbarColor: Colors.grey,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: '이미지',
              cropStyle: CropStyle.rectangle,
            ),
          ]);
    }
  }

  Expanded inPutWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 6),
            TextField(
              controller: _titleController,
              cursorHeight: 16,
              maxLength: 500,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                hintText: '제목',
                hintStyle: GlobalTextstyles.body16M.copyWith(color: GlobalColor.gray3),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
            const Divider(
              height: 1,
              color: GlobalColor.gray4Back1,
            ),
            TextField(
              controller: descController,
              cursorHeight: 16,
              maxLength: 500,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                hintText: 'ex) 양 몇마리를 세야하나요?\n\n*커뮤니티 이용 수칙을 지켜주세요',
                hintStyle: GlobalTextstyles.body16M.copyWith(color: GlobalColor.gray3),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container appBar(String title, BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: GlobalColor.gray4Back1),
      )),
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                Get.back();
              },
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset('assets/icons/close.svg')),
          SizedBox(width: 10),
          Text('zzz 커뮤니티', style: GlobalTextstyles.h1Title18B.copyWith(color: GlobalColor.black1Normal)),
          Spacer(),
          Text(
            '완료',
            style: GlobalTextstyles.body16M.copyWith(color: GlobalColor.primary),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
