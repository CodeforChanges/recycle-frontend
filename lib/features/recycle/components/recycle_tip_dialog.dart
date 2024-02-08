import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> userData = [
  {
    'user_name': 'user1',
    'user_image': 'assets/images/recycle.png',
    'post_images': [
      'assets/images/recycle.png',
      'assets/images/recycle.png',
      'assets/images/recycle.png',
    ],
    'like_count': 10,
    'comment_count': 20,
  },
  {
    'user_name': 'user2',
    'user_image': 'assets/images/recycle.png',
    'post_images': [
      'assets/images/recycle.png',
      'assets/images/recycle.png',
      'assets/images/recycle.png',
    ],
    'like_count': 10,
    'comment_count': 20,
  },
  {
    'user_name': 'user3',
    'user_image': 'assets/images/recycle.png',
    'post_images': [
      'assets/images/recycle.png',
      'assets/images/recycle.png',
      'assets/images/recycle.png',
    ],
    'like_count': 10,
    'comment_count': 20,
  },
  {
    'user_name': 'user4',
    'user_image': 'assets/images/recycle.png',
    'post_images': [
      'assets/images/recycle.png',
      'assets/images/recycle.png',
      'assets/images/recycle.png',
    ],
    'like_count': 10,
    'comment_count': 20,
  },
  {
    'user_name': 'user5',
    'user_image': 'assets/images/recycle.png',
    'post_images': [
      'assets/images/recycle.png',
      'assets/images/recycle.png',
      'assets/images/recycle.png',
    ],
    'like_count': 10,
    'comment_count': 20,
  },
];

class RecycleTipDialog extends StatefulWidget {
  const RecycleTipDialog({super.key});

  @override
  State<RecycleTipDialog> createState() => _RecycleTipDialogState();
}

class _RecycleTipDialogState extends State<RecycleTipDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: returnPostSlider(),
    );
  }

  Container returnPost(int userIndex) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
        width: 0.5,
        color: Colors.grey,
      )),
      child: Column(
        children: [
          returnImageSlider(userIndex),
          returnPostFooter(userData[userIndex]),
        ],
      ),
    );
  }

  Container returnPostFooter(Map<String, dynamic> user) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: returnUserInfo(user['user_name'] ?? ''),
          ),
          Center(
            child: returnPostInfo(user['like_count'], user['comment_count']),
          )
        ],
      ),
    );
  }

  Container returnUserInfo(String userName) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/recycle.png'),
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

  CarouselSlider returnImageSlider(int userIndex) {
    return CarouselSlider(
      items: List.generate(userData[userIndex]['post_images']?.length ?? 0,
          (index) {
        return Builder(builder: (BuildContext context) {
          return FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(userData[userIndex]['post_images'][index]),
          );
        });
      }).toList(),
      options: CarouselOptions(
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
          height: 252,
          viewportFraction: 1.0,
          scrollDirection: Axis.horizontal,
        ),
        items: List.generate(userData.length, (index) => returnPost(index)));
  }
}
