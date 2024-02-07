import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/utils/color_utils.dart';

class CameraButton extends StatefulWidget {
  const CameraButton({required this.controller, Key? key}) : super(key: key);

  final CameraController controller;

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      child: const Icon(Icons.camera_alt),
      onPressed: () async {
        try {
          await widget.controller.initialize();

          final image = await widget.controller.takePicture();

          if (!mounted) {
            return;
          }
          print("=====================");
          print(image.path);
          Get.snackbar('Success', 'Image saved to path');
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
