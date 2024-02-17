import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle/controller/post_controller.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:recycle/utils/color_utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController textController = TextEditingController();
  List<Future<String>> userImagePaths = [];
  List<String> tagList = [];

  final storage = FirebaseStorage.instance;

  String? editingContent;

  List<String>? editingImages;

  int? postId;

  bool? isEditMode;

  bool isUpdating = false;

  final arguments = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (arguments != null) {
      setState(() {
        isEditMode = true;
        postId = arguments['postId'];
        editingContent = arguments['content'];
        editingImages = arguments['images'];
        textController.text = editingContent!;
        userImagePaths = editingImages!
            .map((image) async {
              return image;
            })
            .toList()
            .cast<Future<String>>();
      });
    }

    void updateText() {
      if (isUpdating) return;

      if (textController.text.endsWith(" ")) {
        isUpdating = true;

        RegExp regExp = RegExp(r'#([\w가-힣]+)');

        RegExpMatch? matches = regExp.firstMatch(textController.text);

        if (matches == null) {
          isUpdating = false;
          return;
        }

        setState(() {
          tagList.add(matches.group(0)?.trim() as String);
        });

        String newText = textController.text.replaceAll(regExp, '');

        int cursorPosition = textController.selection.baseOffset;
        cursorPosition =
            cursorPosition > newText.length ? newText.length : cursorPosition;
        textController.value = TextEditingValue(
          text: newText,
          selection:
              TextSelection.fromPosition(TextPosition(offset: cursorPosition)),
        );

        isUpdating = false;
      }
    }

    textController.addListener(updateText);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

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
              tagListWidget(),
              divider(),
              addPhotoBtn(),
            ],
          ),
        ));
  }

  Container tagListWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Wrap(
        children: List.generate(
          tagList.length,
          (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(right: 8),
            child: Chip(
              backgroundColor: primaryColor,
              label: Text(
                tagList[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              deleteIcon: const Icon(Icons.close, color: Colors.white),
              onDeleted: () {
                setState(() {
                  tagList.removeAt(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar renderAppBar() => AppBar(
        title: const Text('글쓰기'),
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              if (textController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('내용을 입력해주세요'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          '확인',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
                return;
              }
              final imagePaths = await Future.wait(userImagePaths);
              if (userImagePaths.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('이미지를 추가해주세요'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          '확인',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
                return;
              }

              if (isEditMode == true) {
                final result = await PostController.to.updatePost(
                  postId,
                  textController.text,
                  imagePaths,
                );
                if (result == false) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('글 수정에 실패했습니다.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            '확인',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                await PostController.to.getPosts();
                Get.toNamed('/home');
                return;
              }

              await PostController.to.postData(
                textController.text,
                imagePaths,
                tagList,
              );
              Get.back();
              return;
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
                                                        Text('loading error')),
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
      setState(() {
        userImagePaths.removeAt(index);
      });
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
