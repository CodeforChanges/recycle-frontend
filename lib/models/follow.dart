import 'package:flutter/material.dart';

class Follow {
  IconData icon;
  String type;
  int count;

  Follow({
    required this.icon,
    required this.type,
    required this.count,
  });
}

List<Follow> follows = [
  Follow(icon: Icons.people, type: '팔로워', count: 100),
  Follow(icon: Icons.people, type: '팔로잉', count: 100),
];
