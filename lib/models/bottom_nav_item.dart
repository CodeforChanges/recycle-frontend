import 'package:flutter/material.dart';

class BottomNavItem {
  final IconData icon;
  final String label;

  const BottomNavItem({
    required this.icon,
    required this.label,
  });
}

const List<BottomNavItem> bottomNavItems = [
  BottomNavItem(icon: Icons.home, label: 'Home'),
  BottomNavItem(icon: Icons.recycling, label: 'Recycling'),
  BottomNavItem(icon: Icons.settings, label: 'Setting'),
];
