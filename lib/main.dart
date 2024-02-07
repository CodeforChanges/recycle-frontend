import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:recycle/controller/auth_service.dart';
import 'package:recycle/controller/post_controller.dart';
import 'package:recycle/routes.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  final List<CameraDescription> cameras = await availableCameras();
  Get.put(AuthService());
  Get.put(PostController());
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({required this.cameras, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/signin',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: routes(cameras),
    );
  }
}
