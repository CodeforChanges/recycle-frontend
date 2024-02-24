import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/controller/post_controller.dart';
import 'package:recycle/features/recycle/components/recycle_result_dialog.dart';
import 'package:recycle/utils/color_utils.dart';

class CameraButton extends StatefulWidget {
  const CameraButton({required this.controller, Key? key}) : super(key: key);

  final CameraController controller;

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  final storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(Icons.camera_alt, color: Colors.white),
          onPressed: () async {
            try {
              await widget.controller.initialize();

              widget.controller.setFlashMode(FlashMode.off);

              final image = await widget.controller.takePicture();

              if (!mounted) {
                Get.snackbar('사진이 찍히지 않았습니다.', "다시 시도해주세요.");
                return;
              }

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      '사진을 업로드 하고 결과를 받아오는 중입니다.',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    content: Container(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              );

              // send image to server.
              File file = File(image.path);

              String fileName =
                  DateTime.now().millisecondsSinceEpoch.toString();

              final uploadResult = await storage
                  .ref()
                  .child('/trash/${fileName}.jpg')
                  .putFile(file);

              // get data from server.
              final uploadedUrl = await uploadResult.ref.getDownloadURL();

              print(uploadedUrl);

              final id = await PostController.to.getTrashId(uploadedUrl);

              final recycleResult = await PostController.to.getTrashKind(id);

              Navigator.pop(context);

              Get.rawSnackbar(
                maxWidth: 344,
                duration: const Duration(seconds: 5),
                messageText: Text(
                  '해당 용품은 재활용이 가능합니다.',
                  style: TextStyle(
                    color: Color.fromRGBO(171, 210, 143, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color.fromRGBO(46, 49, 42, 1),
                snackPosition: SnackPosition.TOP,
              );

              // show dialog
              Get.defaultDialog(
                titlePadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                title: '분리 수거 방법',
                content: RecycleResultDialog(kindOfRecycle: recycleResult),
              );
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }
}
