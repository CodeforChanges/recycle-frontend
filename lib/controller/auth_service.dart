import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recycle/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;

class AuthService extends GetxController {
  static AuthService get to => Get.find();

  User? user;
  Dio dio = Dio();
  RxString token = ''.obs;
  final storage = FlutterSecureStorage();

  Future<void> signIn(String email, String password) async {
    try {
      Map<String, dynamic> userData = {
        'user_email': email,
        'user_password': password,
      };

      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/auth'),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        data: userData,
      );

      if (response.statusCode == 201) {
        token.value = response.data['access_token'];
        await storage.write(key: "access_token", value: token.value);
        print("SignIn Success");
        Get.toNamed('/');
      } else {
        print("SignIn Failure");
      }
    } catch (e) {
      print("Error during sign-in: $e");
    }
  }

  Future<void> signUp(context, User user) async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/user'),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        data: user.toMap(),
      );

      if (response.statusCode == 201) {
        print("SignUp Success");
        Get.toNamed('/signin');
      } else {
        print("SignUp Failure");
      }
    } catch (e) {
      print("Error during sign-up: $e");
    }
  }

  Future<void> signOut() async {
    await storage.delete(key: "access_token");
    Get.toNamed('/signin');
  }
}
