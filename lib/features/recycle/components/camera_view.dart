import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({required this.cameras, required this.controller, Key? key})
      : super(key: key);
  final List<CameraDescription> cameras;
  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: CameraPreview(controller),
    );
  }
}
