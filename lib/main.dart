import 'package:flutter/material.dart';
import 'package:recycle/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: MainPage());
  }
}
