class User {
  final int? user_id;
  final String user_name;
  final String user_nickname;
  final String user_email;
  final String? user_image;
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
      'user_nickname': user_nickname,
      'user_email': user_email,
      'user_image': user_image,
      'user_password': user_password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_nickname: json['user_nickname'],
      user_email: json['user_email'],
      user_image: json['user_image'],
      user_password: json['user_password'],
    );
  }
}
