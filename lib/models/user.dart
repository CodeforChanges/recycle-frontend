import 'package:get/get.dart';

class User {
  final int? user_id;
  final String user_name;
  RxString user_nickname;
  final String user_email;
  RxString? user_image;
  final String? user_password;

  User({
    this.user_id,
    required this.user_name,
    required this.user_nickname,
    required this.user_email,
    this.user_image,
    this.user_password,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'user_name': user_name,
      'user_nickname': user_nickname.value,
      'user_email': user_email,
      'user_image': user_image?.value,
      'user_password': user_password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_nickname: RxString(json['user_nickname'] ?? ""),
      user_email: json['user_email'],
      user_image: RxString(json['user_image'] ?? ""),
      user_password: json['user_password'],
    );
  }
}
