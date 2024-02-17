import 'package:get/get.dart';

class Comment {
  RxInt comment_id = 0.obs;
  RxString comment_content = ''.obs;
  late Rx<CommentOwner> comment_owner;
  RxString reg_date = ''.obs;

  Comment({
    required this.comment_id,
    required this.comment_content,
    required this.comment_owner,
    required this.reg_date,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    comment_id = RxInt(json['comment_id'] ?? 0);
    comment_content = RxString(json['comment_content'] ?? '');
    comment_owner =
        Rx<CommentOwner>(CommentOwner.fromJson(json['comment_owner']));
    reg_date = RxString(json['reg_date'] ?? '');
  }
}

class CommentOwner {
  int user_id = 0;
  String user_nickname = '';
  String? user_image;

  CommentOwner({
    required this.user_id,
    required this.user_nickname,
    this.user_image,
  });

  factory CommentOwner.fromJson(Map<String, dynamic> json) {
    return CommentOwner(
      user_id: json['user_id'] ?? 0,
      user_nickname: json['user_nickname'] ?? '',
      user_image: json['user_image'] ?? '',
    );
  }
}
