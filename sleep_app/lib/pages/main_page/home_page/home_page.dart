import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sleep_app/global/global_colors.dart';
import 'package:sleep_app/global/global_textstyles.dart';
import 'package:sleep_app/pages/main_page/home_page/post_model.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';
import 'package:sleep_app/pages/view_page/view_page.dart';
import 'package:sleep_app/pages/write_page/write_page.dart';

class HomePage extends GetView<MainPageController> {
  List<Post> posts = [
    Post(
      title: '잠을 못 들어요. 유튜브 영상 추천 좀 해주세요.',
      timestamp: DateTime.now(),
      content: '브레이너 제너라고 듣고 있는데 효과가...',
      location: '은평구',
      likesCount: 100,
      commentsCount: 20,
      views: 111,
    ),
    Post(
      title: '잠을 못 들어요. 유튜브 영상 추천 좀 해주세요.',
      timestamp: DateTime.now(),
      content: '브레이너 제너라고 듣고 있는데 효과가...',
      location: '은평구',
      likesCount: 100,
      commentsCount: 20,
      views: 111,
    ),
    Post(
      title: '잠을 못 들어요. 유튜브 영상 추천 좀 해주세요.',
      timestamp: DateTime.now(),
      content: '브레이너 제너라고 듣고 있는데 효과가...',
      location: '은평구',
      likesCount: 100,
      commentsCount: 20,
      views: 111,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    recentPostList(),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 26,
              bottom: 16,
              child: fab(),
            ),
          ],
        ));
  }

  Widget recentPostList() {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return postCard(posts[index]);
      },
    );
  }

  Widget postCard(Post post) {
    return GestureDetector(
      onTap: () {
        Get.to(ViewPage(), arguments: {'post': post});
      },
      child: Container(
        padding: const EdgeInsets.only(top: 14, bottom: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: GlobalColor.gray4Back1, width: 1)),
        ),
        child: Column(
          children: [
            chipWidget(post),
            SizedBox(height: 8),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://swaddelini.com/cdn/shop/files/WLP_0084_4f1467b6-254b-4bd0-8a61-3d9099bfeffa.jpg?v=1700191647&width=1200'),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              post.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GlobalTextstyles.h3Title14M.copyWith(color: GlobalColor.black1Normal),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              post.content ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GlobalTextstyles.body14.copyWith(color: GlobalColor.gray1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            feedbackBar(post),
          ],
        ),
      ),
    );
  }

  Row chipWidget(Post post) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
          decoration: const BoxDecoration(color: GlobalColor.gray5Back2, borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Text(post.location ?? '', style: GlobalTextstyles.body_11M.copyWith(color: GlobalColor.black1Normal)),
        )
      ],
    );
  }

  Row feedbackBar(Post post) {
    return Row(
      children: [
        Text('좋아요', style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3)),
        SizedBox(width: 2),
        Text(PostViewModel().formatPostViews(post.likesCount), style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3)),
        SizedBox(width: 10),
        Text('댓글', style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3)),
        SizedBox(width: 2),
        Text(PostViewModel().formatPostViews(post.commentsCount), style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3)),
        SizedBox(width: 10),
        Text('뷰', style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3)),
        SizedBox(width: 2),
        Text(PostViewModel().formatPostViews(post.views), style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3)),
        const Spacer(),
        Text(
          PostViewModel().formatPostTime(post.timestamp),
          style: GlobalTextstyles.body12.copyWith(color: GlobalColor.gray3),
        ),
        SizedBox(width: 10)
      ],
    );
  }

  Widget fab() {
    return SizedBox(
      width: 42,
      height: 42,
      child: FloatingActionButton(
        onPressed: () async {
          Get.to(WritePage());
        },
        elevation: 0,
        backgroundColor: GlobalColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
          side: BorderSide.none,
        ),
        child: Image.asset('assets/icons/write_icon.png', width: 24, height: 24, color: Colors.white),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: GestureDetector(
        child: Text(
          'zzz 커뮤니티',
          style: GlobalTextstyles.h2Title16B.copyWith(color: GlobalColor.black1Normal),
        ),
      ),
      toolbarHeight: 50,
      shape: const Border(bottom: BorderSide(color: GlobalColor.gray4Back1, width: 1)),
      centerTitle: false,
      backgroundColor: GlobalColor.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/search.png', width: 24, height: 24),
        )
      ],
    );
  }
}
