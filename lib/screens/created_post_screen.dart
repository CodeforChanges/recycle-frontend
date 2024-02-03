import 'package:flutter/material.dart';
import 'package:recycle/components/post.dart';

class CreatedPostScreen extends StatefulWidget {
  const CreatedPostScreen({super.key});

  @override
  State<CreatedPostScreen> createState() => _CreatedPostScreenState();
}

class _CreatedPostScreenState extends State<CreatedPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Container(
        color: Colors.white,
        child: Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/post');
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Post(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar renderAppBar() => AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        title: const Text('내가 쓴 글'),
      );
}
