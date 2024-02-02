import 'package:flutter/material.dart';

class SocialMetricsItem {
  final IconData icon;
  final String count;
  final Color color;

  const SocialMetricsItem(
      {required this.icon, required this.count, required this.color});
}

const List socialMetricsItems = [
  SocialMetricsItem(
      icon: Icons.favorite_border, count: '0', color: Color(0xff008000)),
  SocialMetricsItem(icon: Icons.chat, count: '0', color: Colors.grey),
  SocialMetricsItem(icon: Icons.autorenew, count: '0', color: Colors.grey),
];
