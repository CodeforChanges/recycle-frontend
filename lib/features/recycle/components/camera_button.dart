import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/features/recycle/components/recycle_result_dialog.dart';
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
      child: const Icon(Icons.camera_alt, color: Colors.white),
      onPressed: () async {
        try {
          await widget.controller.initialize();

          widget.controller.setFlashMode(FlashMode.off);

          final image = await widget.controller.takePicture();

          if (!mounted) {
            return;
          }

          // send image to server.
          //  =====================
          // get data from server.

          Get.rawSnackbar(
            maxWidth: 344,
            duration: const Duration(seconds: 5),
            messageText: Text(
              '해당 용품은 재활용이 가능합니다.',
              style: TextStyle(color: Color.fromRGBO(171, 210, 143, 1)),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromRGBO(46, 49, 42, 1),
            snackPosition: SnackPosition.TOP,
          );

          // show dialog
          Get.defaultDialog(
              titlePadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              title: '분리 수거 방법',
              content: RecycleResultDialog(kindOfRecycle: "투명 페트병"));
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
