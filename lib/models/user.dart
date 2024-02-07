import 'dart:convert';

class User {
  final String user_name;
  final String user_nickname;
  final String user_email;
  final String user_password;

  User({
    required this.user_name,
    required this.user_nickname,
    required this.user_email,
    required this.user_password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_name': user_name,
      'user_nickname': user_nickname,
      'user_email': user_email,
      'user_password': user_password,
    };
  }

  String toJson() => json.encode(toMap());
}
