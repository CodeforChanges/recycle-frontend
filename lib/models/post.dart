import 'package:get/get.dart';
import 'package:recycle/models/comment.dart';

import 'tag.dart';

class Post {
  RxInt post_id = 0.obs;
  RxString post_content = ''.obs;
  RxInt post_owner_id = 0.obs;
  String reg_date = '';
  RxList post_images = [].obs;
  late Rx<PostOwner> post_owner;
  RxList<Comment>? post_comments = <Comment>[].obs;
  RxInt? likesCount = 0.obs;
  RxBool? isLiked = false.obs;
  RxList<Tag> post_tags = <Tag>[].obs;

  Post({
    required this.post_id,
    required this.post_content,
    required this.post_owner_id,
    required this.reg_date,
    required this.post_images,
    required this.post_owner,
    required this.post_tags,
    this.post_comments,
    this.likesCount,
    this.isLiked,
  });

  Post.fromJson(Map<String, dynamic> json) {
    post_id = RxInt(json['post_id'] ?? 0);
    post_content = RxString(json['post_content'] ?? '');
    post_owner_id = RxInt(json['post_owner_id'] ?? 0);
    reg_date = json['reg_date'] ?? '';
    post_images = RxList(json['post_images'] ?? []);
    post_owner = Rx(PostOwner.fromJson(json['post_owner'] ?? {}));
    post_comments = RxList<Comment>(json['post_comments']
            ?.map((comment) => Comment.fromJson(comment))
            .toList()
            ?.cast<Comment>() ??
        []);
    likesCount = RxInt(json['likesCount'] ?? 0);
    isLiked = RxBool(json['isLiked'] ?? false);
    post_tags = RxList<Tag>(json['post_tags']
            ?.map((tag) => Tag.fromJson(tag))
            .toList()
            ?.cast<Tag>() ??
        []);
  }
}

class PostOwner {
  RxInt user_id = 0.obs;
  RxString user_nickname = ''.obs;
  RxString? user_image = ''.obs;

  PostOwner({
    required this.user_id,
    required this.user_nickname,
    this.user_image,
  });

  PostOwner.fromJson(Map<String, dynamic> json) {
    user_id = RxInt(json['user_id'] ?? 0);
    user_nickname = RxString(json['user_nickname'] ?? '');
    user_image = RxString(json['user_image'] ?? '');
  }
}
