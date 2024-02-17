class Tag {
  final String tag_name;
  final int post_id;

  Tag({
    required this.tag_name,
    required this.post_id,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tag_name: json['tag_name'],
      post_id: json['post_id'] ?? 0,
    );
  }
}
