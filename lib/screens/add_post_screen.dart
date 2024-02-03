import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar(),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            children: [
              textField(),
              divider(),
              addPhotoBtn(),
            ],
          ),
        ));
  }

  AppBar renderAppBar() => AppBar(
        title: const Text('글쓰기'),
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      );

  Divider divider() => const Divider(
        height: 1,
        color: Colors.grey,
      );

  Widget addPhotoBtn() => Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey[600],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.image_outlined,
              color: Colors.grey[600],
            ),
          ),
        ],
      );

  Widget textField() => Expanded(
        child: TextField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: '재활용 경험을 모두에게 공유해 주세요',
            border: InputBorder.none,
          ),
        ),
      );
}
