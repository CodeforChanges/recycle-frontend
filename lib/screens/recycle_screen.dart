import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recycle/features/recycle/components/ask_permission_container.dart';
import 'package:recycle/features/recycle/components/camera_button.dart';
import 'package:recycle/features/recycle/components/camera_view.dart';
import 'package:recycle/features/recycle/components/recycle_title.dart';

class RecycleScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const RecycleScreen({required this.cameras, Key? key}) : super(key: key);

  @override
  State<RecycleScreen> createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            // 카메라 사용해야만 사용할 수 있다는 다이얼로그 띄우고 메인화면으로 navigate 하기
            break;
          default:
            // Handle other errors here.
            // 에러 다이얼로그 띄우고 메인화면으로 navigate 하기
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (!controller.value.isInitialized) {
      return AskPermissionContainer();
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  CameraView(
                    cameras: widget.cameras,
                    controller: controller,
                  ),
                  RecycleScreenTitle(),
                ],
              ),
              Expanded(
                  child: CameraButton(
                controller: controller,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
