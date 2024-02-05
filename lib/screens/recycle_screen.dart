import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
            break;
          default:
            // Handle other errors here.
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
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // if (!controller.value.isInitialized) {
  //   //   return Container();
  //   // }
  //   return Scaffold(
  //       appBar: renderAppBar(),
  //       body: Container(
  //         color: Colors.white,
  //         width: double.infinity,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             textWidget(),
  //             // CameraPreview(controller),
  //           ],
  //         ),
  //       ));
  // }

  AppBar renderAppBar() => AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        title: const Text(
          'Recycle',
        ),
      );

  Widget textWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: const Text(
          '사진을 찍어 분리수거 방법과 재활용 팁을 확인해 보세요!',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      );
}


  // Future<void> takePicture() async {
  //   final CameraController cameraController = controller;

  // 카메라 초기화 여부 확인
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     print('Error: select a camera first.');
  //     return;
  //   }

  //   try {
      // await cameraController.takePicture('/assets/images/');
  //   } catch (e) {
  //     print(e.toString());
  //     return;
  //   }
  // }

