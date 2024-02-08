import 'dart:convert';

class User {
  final String user_name;
  final String user_nickname;
  final String user_email;
  final String? user_password;

  User({
    required this.user_name,
    required this.user_nickname,
    required this.user_email,
    this.user_password,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': user_name,
      'user_nickname': user_nickname,
      'user_email': user_email,
      'user_password': user_password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_name: map['user_name'],
      user_nickname: map['user_nickname'],
      user_email: map['user_email'],
      user_password: map['user_password'],
    );
  }
}
