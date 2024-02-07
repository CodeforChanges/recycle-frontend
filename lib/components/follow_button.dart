import 'package:flutter/material.dart';

class FollowBtn extends StatelessWidget {
  const FollowBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.green),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      child: const Text(
        'follow',
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
