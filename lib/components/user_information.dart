import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle/controller/auth_service.dart';
import 'package:recycle/controller/post_controller.dart';
import 'package:recycle/utils/color_utils.dart';

class UserInf extends StatelessWidget {
  const UserInf({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = FirebaseStorage.instance;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: FutureBuilder(
        future: AuthService.to.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
              () => Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child:
                            AuthService.to.user.value.user_image?.value == null
                                ? CircleAvatar(
                                    radius: 40.0,
                                    backgroundColor: Colors.brown.shade800,
                                  )
                                : CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(AuthService
                                            .to.user.value.user_image?.value ??
                                        ""),
                                    onBackgroundImageError:
                                        (exception, stackTrace) => CircleAvatar(
                                      radius: 40.0,
                                      backgroundColor: Colors.brown.shade800,
                                    ),
                                  ),
                      ),
                      Positioned(
                        bottom: -17,
                        right: -17,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? image = await imagePicker.pickImage(
                                  source: ImageSource.gallery);

                              if (image == null) {
                                return;
                              }

                              String fileName = DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString();
                              Reference ref =
                                  storage.ref().child('profiles/$fileName');

                              File file = File(image.path);

                              final uploadTask = await ref.putFile(file);

                              if (uploadTask.state == TaskState.success) {
                                final url = await ref.getDownloadURL();
                                final result =
                                    await AuthService.to.updateUserImage(url);
                                if (result) {
                                  PostController.to.posts.clear();
                                  await PostController.to.getPosts();
                                  AuthService.to.update();
                                  return;
                                } else {
                                  await showFailUploadDialog(context);
                                  return;
                                }
                              }
                            },
                            icon: const Icon(
                              size: 20,
                              Icons.photo_camera,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Row(
                      children: [
                        Text(
                          AuthService.to.user.value.user_nickname?.value ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20.0),
                        ),
                        IconButton(
                          onPressed: () async {
                            await editNickNameDialog(context);
                          },
                          icon: Icon(Icons.edit, size: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> showFailUploadDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('이미지를 불러오지 못했습니다.'),
        content: Text('다시 시도해주세요.'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'))
        ],
      ),
    );
  }

  Future<dynamic> editNickNameDialog(context) {
    final TextEditingController _nicknameController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('닉네임 변경'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                hintText: '닉네임을 입력해주세요.',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '취소',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_nicknameController.text.isEmpty) {
                return;
              }
              final result = await AuthService.to
                  .updateUserNickName(_nicknameController.text);
              if (result) {
                PostController.to.posts.clear();
                await PostController.to.getPosts();
                Navigator.pop(context);
                return;
              } else {
                await showFailUploadDialog(context);
                return;
              }
            },
            child: Text(
              '변경',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
