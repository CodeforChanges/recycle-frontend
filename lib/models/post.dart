import 'package:get/get.dart';
import 'package:recycle/models/comment.dart';

class Post {
  RxInt post_id = 0.obs;
  RxString post_content = ''.obs;
  RxInt post_owner_id = 0.obs;
  String reg_date = '';
  RxList post_images = [].obs;
  late Rx<PostOwner> post_owner;
  RxList<Comment>? post_comments = <Comment>[].obs;
  RxInt? likesCount = 0.obs;
  RxInt? sharesCount = 0.obs;
  RxBool? isLiked = false.obs;

  Post({
    required this.post_id,
    required this.post_content,
    required this.post_owner_id,
    required this.reg_date,
    required this.post_images,
    required this.post_owner,
    this.post_comments,
    this.likesCount,
    this.sharesCount,
    this.isLiked,
  });

  Post.fromJson(Map<String, dynamic> json) {
    post_id = RxInt(json['post']['post_id'] ?? 0);
    post_content = RxString(json['post']['post_content'] ?? '');
    post_owner_id = RxInt(json['post']['post_owner_id'] ?? 0);
    reg_date = json['post']['reg_date'] ?? '';
    post_images = RxList(json['post']['post_images'] ?? []);
    post_owner = Rx(PostOwner.fromJson(json['post']['post_owner'] ?? {}));
    post_comments = RxList<Comment>(json['post']['post_comments']
            ?.map((comment) => Comment.fromJson(comment))
            .toList()
            ?.cast<Comment>() ??
        []);
    likesCount = RxInt(json['post']['likesCount'] ?? 0);
    sharesCount = RxInt(json['post']['sharesCount'] ?? 0);
    isLiked = RxBool(json['post']['isLiked'] ?? false);
  }
}

class PostOwner {
  RxInt user_id = 0.obs;
  RxString user_nickname = ''.obs;
  RxString? user_image = ''.obs;
  RxInt follower_count = 0.obs;

  PostOwner({
    required this.user_id,
    required this.user_nickname,
    this.user_image,
    required this.follower_count,
  });

  PostOwner.fromJson(Map<String, dynamic> json) {
    user_id = RxInt(json['user_id'] ?? 0);
    user_nickname = RxString(json['user_nickname'] ?? '');
    user_image = RxString(json['user_image'] ?? '');
    follower_count = RxInt(json['follower_count'] ?? 0);
  }
}
