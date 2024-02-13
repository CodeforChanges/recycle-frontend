import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle/controller/post_controller.dart';

import 'package:firebase_storage/firebase_storage.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController textController = TextEditingController();
  List<Future<String>> userImagePaths = [];

  final storage = FirebaseStorage.instance;

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
            onPressed: () async {
              final imagePaths = await Future.wait(userImagePaths);
              if (userImagePaths.isEmpty) {
                AlertDialog(
                  title: const Text('이미지를 추가해주세요'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('확인'),
                    ),
                  ],
                );
                return;
              }
              await PostController.to.postData(
                textController.text,
                imagePaths,
              );
              // ! 포스트 추가시 업데이트가 반영이 안됨...
              // ! 업데이트시 반환되는 데이터를 없애도 될듯 합니다.
              PostController.to.getPosts();
              Get.toNamed('/');
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
              children: userImagePaths.isEmpty
                  ? []
                  : List.generate(
                      userImagePaths.length,
                      (index) => Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: FutureBuilder(
                                  future: userImagePaths[index],
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return snapshot.data != null
                                          ? Image.network(
                                              snapshot.data as String,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              );
                                            },
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover)
                                          : Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.grey,
                                            );
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -10,
                                child: IconButton(
                                    onPressed: () {
                                      deleteImage(index);
                                    },
                                    icon:
                                        Icon(Icons.delete, color: Colors.red)),
                              ),
                            ],
                          ))),
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
              if (image == null) {
                return;
              }
              ;

              File imageForFirebaseUpload = File(image.path);

              final now = DateTime.now().microsecondsSinceEpoch.toString();

              final imagesRef = storage.ref().child('images/${now}');

              final result = await imagesRef.putFile(imageForFirebaseUpload);

              setState(() {
                userImagePaths.add(result.ref.getDownloadURL());
              });
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey[600],
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                final ImagePicker _picker = ImagePicker();
                final List<XFile> images = await _picker.pickMultiImage();

                if (images.isEmpty) {
                  return;
                }

                final imagesForFirebaseUpload =
                    images.map((image) => File(image.path)).toList();

                final now = DateTime.now().microsecondsSinceEpoch.toString();
                int count = 0;

                final uploads = imagesForFirebaseUpload.map((image) async {
                  final imagesRef =
                      storage.ref().child('images/${now}_${count++}');
                  return await imagesRef.putFile(image);
                });

                final uploadTasks = await Future.wait(uploads);

                final imagePaths =
                    uploadTasks.map((task) => task.ref.getDownloadURL());

                setState(() {
                  userImagePaths = [...userImagePaths, ...imagePaths];
                });
              } catch (e) {
                print(e);
              }
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

  void deleteImage(int index) {
    try {
      print("deleteImage: $index");
      print(userImagePaths.length);
      setState(() {
        userImagePaths.removeAt(index);
      });
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
