import 'package:flutter/material.dart';
import 'package:recycle/models/follow.dart';

class UserInf extends StatelessWidget {
  const UserInf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset(
              'assets/images/profile.jpg',
              width: 80.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            width: MediaQuery.of(context).size.width - 140.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '이름',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                    // const FollowBtn(),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: follows
                        .map((follow) => Row(
                              children: [
                                Icon(
                                  follow.icon,
                                  size: 20.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(follow.type),
                                ),
                                Text(follow.count.toString()),
                                const SizedBox(width: 10.0),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
