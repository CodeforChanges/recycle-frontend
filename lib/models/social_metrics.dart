import 'package:flutter/material.dart';

class SocialMetricsItem {
  final IconData icon;
  final Color color;

  const SocialMetricsItem({required this.icon, required this.color});
}

const List socialMetricsItems = [
  SocialMetricsItem(icon: Icons.favorite_border, color: Color(0xff008000)),
  SocialMetricsItem(icon: Icons.chat, color: Colors.grey),
  SocialMetricsItem(icon: Icons.autorenew, color: Colors.grey),
];
