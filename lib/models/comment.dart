class Comment {
  int comment_id = 0;
  String comment_content = '';
  CommentOwner comment_owner = CommentOwner(
    user_id: 0,
    user_nickname: '',
    user_image: null,
  );
  String reg_date = '';

  Comment({
    required this.comment_id,
    required this.comment_content,
    required this.comment_owner,
    required this.reg_date,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    comment_id = json['comment_id'] ?? 0;
    comment_content = json['comment_content'] ?? '';
    comment_owner = CommentOwner.fromJson(json['comment_owner']);
    reg_date = json['reg_date'] ?? '';
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
