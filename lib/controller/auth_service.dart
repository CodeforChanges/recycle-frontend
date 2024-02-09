import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recycle/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;

class AuthService extends GetxController {
  static AuthService get to => Get.find();

  User? user;
  Dio dio = Dio();
  RxString _token = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    String? accessToken = await storage.read(key: "access_token");
    if (accessToken != null) {
      _token.value = accessToken;
    }
    await getUser();
  }

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
        await storage.write(
            key: "access_token", value: response.data['access_token']);

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

  Future<void> getUser() async {
    try {
      Response response = await dio.get(
        ('${dotenv.get('SERVER')}/user'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );

      if (response.statusCode == 200) {
        user = User.fromJson(response.data);
        print("Get User Success");
      } else {
        print("Get User Failure");
      }
    } catch (e) {
      print("Error during getting user: $e");
    }
  }

  Future<void> deleteUser() async {
    print(_token.value);
    try {
      Response response = await dio.delete(
        ('${dotenv.get('SERVER')}/user'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );

      if (response.statusCode == 200) {
        await storage.delete(key: "access_token");
        print("User Deletion Success");
        Get.toNamed('/signin');
      } else {
        print("User Deletion Failure");
      }
    } catch (e) {
      print("Error during user deletion: $e");
    }
  }
}
