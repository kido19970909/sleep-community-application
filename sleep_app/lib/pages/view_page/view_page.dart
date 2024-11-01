import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/home_page/post_model.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';

class ViewPage extends GetView<MainPageController> {
  final TextEditingController descController = TextEditingController();
  var comments = [
    Comment.init(text: 'test'),
    Comment.init(text: 'test'),
  ].obs;

  late String title = '';
  late String hintText = '';
  @override
  Widget build(BuildContext context) {
    Post post = Get.arguments['post'] as Post;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(children: [
            Positioned.fill(
              child: Column(
                children: [
                  appBar(post.title, context),
                  inPutWidget(post: post),
                ],
              ),
            ),
            Positioned(
              right: 26,
              bottom: 16,
              child: fab(),
            ),
            Positioned(right: 0, left: 0, bottom: 0, child: buildInputComment())
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

  Expanded inPutWidget({required Post post}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 1,
              color: GlobalColor.gray4Back1,
            ),
            CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    'https://swaddelini.com/cdn/shop/files/WLP_0084_4f1467b6-254b-4bd0-8a61-3d9099bfeffa.jpg?v=1700191647&width=1200'),
            const Divider(
              height: 1,
              color: GlobalColor.gray4Back1,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                          alignment: Alignment.centerLeft,
                          decoration:
                              const BoxDecoration(color: GlobalColor.gray5Back2, borderRadius: BorderRadius.all(Radius.circular(16))),
                          child: Text(post.location ?? '', style: GlobalTextstyles.body_11M.copyWith(color: GlobalColor.black1Normal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                          child: Text(
                            'test 유저',
                            style: GlobalTextstyles.caption13M.copyWith(color: GlobalColor.gray2),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          post.timestamp.toIso8601String().split('.')[0].split('T')[0],
                          style: GlobalTextstyles.caption13M.copyWith(color: GlobalColor.gray2),
                        ),
                        Text(
                          post.timestamp.toIso8601String().split('.')[0].split('T')[1],
                          style: GlobalTextstyles.caption13M.copyWith(color: GlobalColor.gray2),
                        ),
                      ],
                    ),
                  ],
                )),
            const Divider(
              height: 1,
              color: GlobalColor.gray4Back1,
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.content!,
                style: GlobalTextstyles.body16M,
              ),
            ),
            SizedBox(height: 40),
            const Divider(
              height: 1,
              color: GlobalColor.gray4Back1,
            ),
            Container(
              color: GlobalColor.subPrimary.withOpacity(0.1),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                '댓글',
                style: GlobalTextstyles.body16M,
              ),
            ),
            const Divider(
              height: 1,
              color: GlobalColor.gray4Back1,
            ),
            Obx(() => _buildComment())
          ],
        ),
      ),
    );
  }

  Widget buildInputComment() {
    return GestureDetector(
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 26),
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
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalColor.gray5Back2,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 100.0, // Maximum height for four lines
                        ),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: TextField(
                              cursorHeight: 14,
                              controller: descController,
                              cursorColor: GlobalColor.gray2,

                              keyboardType: TextInputType.multiline,

                              maxLines: null, // Unlimited lines
                              decoration: InputDecoration(
                                fillColor: GlobalColor.gray5Back2,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          var comment = Comment.init(text: descController.text);

                          comments.add(comment);
                          comments.refresh();
                        },
                        child: Text('게시', style: GlobalTextstyles.body12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment() {
    return ListView.builder(
      itemCount: comments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 90, left: 16, right: 16),
      itemBuilder: (BuildContext context, int index) {
        return buildCommentItem(context, comments[index]);
      },
    );
  }

// 댓글 아이템을 빌드하는 함수
  Widget buildCommentItem(BuildContext context, Comment comment, {int depth = 0}) {
    return Row(
      children: [
        Expanded(
          child: ReplyCard(comment: comment, additionalInfo: 'test', postAuthorId: 'test', hasReplies: false, onReply: () async {}),
        ),
      ],
    );
  }

  Container appBar(String title, BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 10),
          SizedBox(
            height: 24,
            width: 24,
            child: IconButton(
                iconSize: 24,
                onPressed: () async {
                  Get.back();
                },
                padding: EdgeInsets.zero,
                icon: Image.asset(
                  'assets/icons/arrow-left.png',
                  width: 24,
                )),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: GlobalTextstyles.h1Title18B.copyWith(color: GlobalColor.black1Normal),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 34),
        ],
      ),
    );
  }
}

class ReplyCard extends StatelessWidget {
  final Comment comment;
  final String postAuthorId;
  final Function? onReply;
  final bool hasReplies;
  final Function? deleteComment;

  final String? additionalInfo;

  ReplyCard({
    required this.comment,
    required this.postAuthorId,
    this.onReply,
    this.hasReplies = false,
    this.deleteComment,
    this.additionalInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.only(top: 12, bottom: 10),
      decoration: const BoxDecoration(
        color: GlobalColor.white,
        border: Border(
          bottom: BorderSide(width: 1, color: GlobalColor.gray4Back1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 18,
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: GlobalColor.gray5Back2,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  '작성자',
                  textAlign: TextAlign.center,
                  style: GlobalTextstyles.body_11M.copyWith(color: Colors.black),
                ),
              ),
              const SizedBox(),
              Expanded(
                child: Text(
                  comment.authorId,
                  style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray1),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  onPressed: () {},
                  iconSize: 16,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.more_vert, color: GlobalColor.gray3),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: LinkText(
                  comment.content,
                  style: GlobalTextstyles.body14.copyWith(color: GlobalColor.black1Normal),
                  linkStyle: GlobalTextstyles.body14.copyWith(color: GlobalColor.black1Normal, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          Row(
            children: [
              const Spacer(),
              Text(PostViewModel().formatPostTime(comment.timestamp), style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3)),
            ],
          ),
        ],
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;

  const LinkText(this.text, {super.key, this.style, this.linkStyle});

  @override
  Widget build(BuildContext context) {
    final urlPattern = RegExp(r'\b(?:https?://|www\.)\S+\b', caseSensitive: false);
    Iterable<RegExpMatch> matches = urlPattern.allMatches(text);

    List<TextSpan> spans = [];
    int start = 0;

    for (final RegExpMatch match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start), style: style));
      }
      final String url = text.substring(match.start, match.end);
      spans.add(TextSpan(
        text: url,
        style: linkStyle ?? const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
      ));
      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start, text.length), style: style));
    }

    return RichText(text: TextSpan(children: spans));
  }
}

class CommentWithReplies {
  final Comment comment;
  final List<CommentWithReplies> replies;

  CommentWithReplies({required this.comment, List<CommentWithReplies>? replies}) : replies = replies ?? [];
}

class Comment {
  final String id;
  final String postId;
  final String uid;
  final String authorId;
  final String? authorNationality;
  final String content;
  List<String> likes;
  DateTime timestamp;
  String? parentId;
  bool? isDeleted;

  Comment({
    required this.id,
    required this.postId,
    required this.uid,
    required this.authorId,
    this.authorNationality,
    required this.content,
    required this.likes,
    required this.timestamp,
    this.parentId,
    this.isDeleted = false,
  });

  factory Comment.init({required String text}) {
    return Comment(
      id: 'test',
      postId: 'test',
      uid: 'test',
      authorId: 'test',
      authorNationality: 'test',
      content: text,
      likes: ['test'],
      timestamp: DateTime.now(),
      parentId: 'test',
      isDeleted: false,
    );
  }

  Comment copyWith({
    String? id,
    String? postId,
    String? uid,
    String? authorId,
    String? authorNationality,
    String? content,
    List<String>? likes,
    DateTime? timestamp,
    String? parentId,
    bool? isDeleted,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      uid: uid ?? this.uid,
      authorId: authorId ?? this.authorId,
      authorNationality: authorNationality ?? this.authorNationality,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      timestamp: timestamp ?? this.timestamp,
      parentId: parentId ?? this.parentId,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
