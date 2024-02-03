import 'package:recycle/screens/add_post_screen.dart';
import 'package:recycle/screens/main_page.dart';
import 'package:recycle/screens/post_screen.dart';
import 'package:recycle/screens/profile_screen.dart';
import 'package:recycle/screens/created_post_screen.dart';

final routes = {
  '/': (context) => MainPage(),
  '/write': (context) => AddPostScreen(),
  '/post': (context) => PostScreen(),
  '/profile': (context) => ProfileScreen(),
  '/setting/createdPost': (context) => CreatedPostScreen(),
};
