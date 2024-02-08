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
  double maxHeight = 500;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        width: double.infinity,
        height: maxHeight,
        child: Column(
          children: [
            returnPostSlider(),
          ],
        ));
  }

  Container returnPost(int userIndex) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            returnImageSlider(userIndex),
            returnPostFooter(userData[userIndex]),
          ],
        ));
  }

  Container returnPostFooter(Map<String, dynamic> user) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          returnUserInfo(user['user_name'] ?? ''),
          returnPostInfo(user['like_count'], user['comment_count'])
        ],
      ),
    );
  }

  Container returnUserInfo(String userName) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/recycle.png'),
          ),
          SizedBox(width: 10),
          Text(userName,
              style: TextStyle(
                fontSize: 10,
              ))
        ],
      ),
    );
  }

  Container returnPostInfo(int likeCount, int commentCount) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.favorite),
          Text(likeCount.toString()),
          SizedBox(width: 10),
          Icon(Icons.comment),
          Text(commentCount.toString()),
        ],
      ),
    );
  }

  CarouselSlider returnImageSlider(int userIndex) {
    return CarouselSlider(
      items: List.generate(userData[userIndex]['post_images']?.length ?? 0,
          (index) {
        return Builder(builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.amber),
            child: Image.asset(userData[userIndex]['post_images'][index]),
          );
        });
      }).toList(),
      options: CarouselOptions(
        height: 150,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  CarouselSlider returnPostSlider() {
    return CarouselSlider(
        options: CarouselOptions(height: 400, scrollDirection: Axis.horizontal),
        items: List.generate(userData.length, (index) => returnPost(index)));
  }
}
