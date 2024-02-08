import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle/controller/post_controller.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController textController = TextEditingController();
  List<String> userImagePaths = [];
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
              imagesWidget(),
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
              userImagePaths.isEmpty
                  ? print('not selected image') //! 사진 추가하라고 alert 날려주기?
                  : PostController.to.postData(
                      textController.text,
                      userImagePaths,
                    );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      );

  Widget imagesWidget() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: userImagePaths == []
                ? []
                : userImagePaths.map((image) {
                    File file = File(image);
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Image.file(
                        file,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
          ),
        ),
      );

  Divider divider() => const Divider(
        height: 1,
        color: Colors.grey,
      );

  Widget addPhotoBtn() => Row(
        children: [
          IconButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.camera);
              image == null
                  ? null
                  : setState(() {
                      userImagePaths.add(image.path);
                    });
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey[600],
            ),
          ),
          IconButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final List<XFile> images = await _picker.pickMultiImage();
              setState(() {
                userImagePaths
                    .addAll(images.map((image) => image.path).toList());
              });
            },
            icon: Icon(
              Icons.image_outlined,
              color: Colors.grey[600],
            ),
          ),
        ],
      );

  Widget textField() => Expanded(
        child: TextField(
          controller: textController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: '재활용 경험을 모두에게 공유해 주세요',
            border: InputBorder.none,
          ),
        ),
      );
}
