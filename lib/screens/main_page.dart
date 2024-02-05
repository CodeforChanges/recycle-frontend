import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recycle/models/bottom_nav_item.dart';
import 'package:recycle/screens/home_screen.dart';
import 'package:recycle/screens/recycle_screen.dart';
import 'package:recycle/screens/setting_screen.dart';

class MainPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MainPage({required this.cameras, Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(),
      RecycleScreen(
        cameras: widget.cameras,
      ),
      SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffF8FAF0),
        elevation: 0,
        selectedItemColor: Colors.green,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: bottomNavItems
            .map((e) =>
                BottomNavigationBarItem(icon: Icon(e.icon), label: e.label))
            .toList(),
      ),
    );
  }
}
