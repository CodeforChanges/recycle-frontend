import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recycle/screens/add_post_screen.dart';
import 'package:recycle/screens/main_page.dart';
import 'package:recycle/screens/post_screen.dart';
import 'package:recycle/screens/profile_screen.dart';
import 'package:recycle/screens/created_post_screen.dart';
import 'package:recycle/screens/recycle_screen.dart';
import 'package:recycle/screens/signin_screen.dart';
import 'package:recycle/screens/signup_screen.dart';

Map<String, WidgetBuilder> routes(List<CameraDescription> cameras) {
  return {
    '/': (context) => MainPage(cameras: cameras),
    '/write': (context) => AddPostScreen(),
    '/post': (context) => PostScreen(),
    '/profile': (context) => ProfileScreen(),
    '/setting/createdPost': (context) => CreatedPostScreen(),
    '/signin': (context) => SignInScreen(),
    '/signup': (context) => SignUpScreen(),
    // 'recycle': (context) => RecycleScreen(cameras: cameras),
  };
}
