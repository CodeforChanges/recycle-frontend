import 'package:flutter/material.dart';
import 'package:recycle/components/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Container(
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        child: Post(),
                      ),
                      commentWidget(),
                      commentWidget(),
                      commentWidget(),
                    ],
                  ),
                ),
              ),
              bottomCommentWidgets()
            ],
          )),
    );
  }

  AppBar renderAppBar() => AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
      );

  Widget bottomCommentWidgets() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_box_outlined,
                  size: 28,
                  color: Colors.grey[700],
                )),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    hintText: '댓글을 입력하세요',
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  size: 28,
                  color: Colors.grey[700],
                )),
          ],
        ),
      );

  Widget commentWidget() => Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.jpg')),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            'indevruis',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '안녕하세요 adjof isa adjf iodajf ioaa   ',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('2024.02.03',
                  style: TextStyle(color: Colors.grey, fontSize: 10)),
            )
          ],
        ),
      );
}
