import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recycle/controller/post_controller.dart';
import 'package:recycle/models/post.dart';

class RecycleTipDialog extends StatefulWidget {
  const RecycleTipDialog({super.key});

  @override
  State<RecycleTipDialog> createState() => _RecycleTipDialogState();
}

class _RecycleTipDialogState extends State<RecycleTipDialog> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        child: PostController.to.recommendPost.length == 0
            ? Center(
                child: Text('No recommend posts founded'),
              )
            : Column(
                children: [
                  returnPostSlider(),
                  returnSliderDescription(),
                  SizedBox(
                    height: 20,
                  ),
                  returnCloseButton(),
                ],
              ));
  }

  ElevatedButton returnCloseButton() {
    return ElevatedButton(
      child: Text(
        '닫기',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  GestureDetector returnPost(int postIndex) {
    return GestureDetector(
      onTap: () {
        // post 컨트롤러 recommendIndex 값 업데이트;
        // Get.toNamed('/post', );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
          width: 0.5,
          color: Colors.grey,
        )),
        child: Stack(
          children: [
            returnImageSlider(postIndex),
            returnPostFooter(
                PostController.to.recommendPost[postIndex].post_owner.value,
                PostController.to.recommendPost[postIndex].likesCount?.value ??
                    0,
                PostController
                        .to.recommendPost[postIndex].post_comments?.length ??
                    0),
            returnDotIndicator(imageIndex,
                PostController.to.recommendPost[postIndex].post_images.length),
          ],
        ),
      ),
    );
  }

  Row returnSliderDescription() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '좌우로 슬라이드해서 게시물을 넘길 수 있습니다.',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Positioned returnDotIndicator(int imageIndex, int length) {
    return Positioned(
      bottom: 90,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(length, (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 5,
            width: 5,
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: imageIndex == index ? Colors.white : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Align returnPostFooter(PostOwner owner, int likeCount, int commentCount) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: returnUserInfo(
                  owner.user_nickname.value, owner.user_image?.value),
            ),
            Center(
              child: returnPostInfo(likeCount, commentCount),
            )
          ],
        ),
      ),
    );
  }

  Container returnUserInfo(String userName, String? userImage) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: userImage == null ? null : NetworkImage(userImage),
          ),
          SizedBox(width: 10),
          Text(userName,
              style: TextStyle(
                fontSize: 14,
              ))
        ],
      ),
    );
  }

  Container returnPostInfo(int likeCount, int commentCount) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.favorite, size: 16, color: Colors.grey[700]),
          SizedBox(width: 3),
          Text(
            likeCount.toString(),
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.comment,
            size: 16,
            color: Colors.grey[700],
          ),
          SizedBox(width: 3),
          Text(
            commentCount.toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  CarouselSlider returnImageSlider(int postIndex) {
    return CarouselSlider(
      items: List.generate(
          PostController.to.recommendPost[postIndex].post_images.length,
          (index) {
        return Builder(builder: (BuildContext context) {
          return Image.network(
            PostController.to.recommendPost[postIndex].post_images[index]
                    ['image_link'] ??
                "",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text('Error while getting image.'),
            ),
          );
        });
      }).toList(),
      options: CarouselOptions(
        onPageChanged: (index, reason) => {
          setState(() {
            imageIndex = index;
          })
        },
        height: 180,
        aspectRatio: 4 / 3,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  CarouselSlider returnPostSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, reason) => {
          setState(() {
            imageIndex = 0;
          })
        },
        height: 252,
        viewportFraction: 1.0,
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(
        PostController.to.recommendPost.length,
        (index) => returnPost(index),
      ),
    );
  }
}
