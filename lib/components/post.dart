import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:recycle/controller/post_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart';

class Post extends StatelessWidget {
  final int postIndex;
  const Post({super.key, required this.postIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(), //! 유저 이미지 때문에 터지는 듯
            // postImages(),
            socialMetrics(),
            contents(),
          ],
        ));
  }

  Widget header() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Obx(() => CircleAvatar(
                //     radius: 22.5,
                //     backgroundImage: AssetImage(PostController
                //         .to.posts[postIndex].post_owner.user_image))),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Obx(
                    () => Text(
                        PostController
                            .to.posts[postIndex].post_owner['user_nickname'],
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
            Row(
              children: [
                PopupMenuButton<String>(
                  constraints:
                      const BoxConstraints.expand(width: 70, height: 110),
                  itemBuilder: (ctx) => [
                    _buildPopupMenuItem('수정'),
                    _buildPopupMenuItem('삭제'),
                  ],
                  onSelected: (String index) => index == '수정'
                      ? print('수정')
                      : PostController.to.deletePost(postIndex),
                )
              ],
            ),
          ],
        ),
      );

  PopupMenuItem<String> _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child: Text(title),
      value: title,
    );
  }

  Widget postImages() =>
      Obx(() => Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            CarouselSlider.builder(
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    PostController.to.activeIndex.value = index,
              ),
              itemCount: PostController.to.posts[postIndex].post_images.length,
              itemBuilder: (context, index, realIndex) {
                final path = PostController
                    .to.posts[postIndex].post_images[index]['image_link'];
                return imageSlider(path, index);
              },
            ),
            Align(alignment: Alignment.bottomCenter, child: indicator())
          ]));

  Widget imageSlider(path, index) => Container(
        width: double.infinity,
        height: 240,
        color: Colors.grey,
        child: Image.asset(path, fit: BoxFit.cover),
      );

  Widget indicator() => Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.bottomCenter,
      child: Obx(() => AnimatedSmoothIndicator(
            activeIndex: PostController.to.activeIndex.value,
            count: PostController.to.posts[postIndex].post_images.length,
            effect: JumpingDotEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: Colors.white,
                dotColor: Colors.white.withOpacity(0.6)),
          )));

  Widget socialMetrics() => Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () async {
                  PostController.to.posts[postIndex].isLiked!.value == false
                      ? await PostController.to.likePost(postIndex)
                      : await PostController.to.unlikePost(postIndex);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                  child: Obx(() => Icon(
                      PostController.to.posts[postIndex].isLiked!.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Color(0xff008000))),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Obx(() =>
                  Text(PostController.to.posts[postIndex].likesCount.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 4, 8, 4),
              child: const Icon(Icons.chat_bubble_outline),
            ),
            Obx(() => Text(
                  PostController.to.posts[postIndex].post_comments!.length
                      .toString(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                )),
          ],
        ),
      );

  Widget contents() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
                  PostController.to.posts[postIndex].post_content.toString(),
                  style: TextStyle(fontSize: 16.0, height: 1.5),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                '#재활용',
                style: TextStyle(
                    fontSize: 16.0, height: 1.5, color: Color(0xff33691E)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
              child: Obx(
                () => Text(
                    DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        PostController.to.posts[postIndex].reg_date)),
                    style: TextStyle(
                        fontSize: 12.0, height: 1.5, color: Colors.grey)),
              ),
            ),
          ],
        ),
      );
}
