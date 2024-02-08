import 'package:get/get.dart';

class Post {
  RxInt post_id = 0.obs;
  RxString post_content = ''.obs;
  RxInt post_owner_id = 0.obs;
  String reg_date = '';
  RxList post_images = [].obs;
  RxMap post_owner = {}.obs;
  RxList? post_comments = [].obs;
  RxInt? likesCount = 0.obs;
  RxInt? sharesCount = 0.obs;
  RxBool? isLiked = false.obs;
  RxBool? isShared = false.obs;
  RxBool? isFollowed = false.obs;

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
    this.isShared,
    this.isFollowed,
  });

  Post.fromJson(Map<String, dynamic> json) {
    post_id = RxInt(json['post_id'] ?? 0);
    post_content = RxString(json['post_content'] ?? '');
    post_owner_id = RxInt(json['post_owner_id'] ?? 0);
    reg_date = json['reg_date'] ?? '';
    post_images = RxList(json['post_images'] ?? []);
    post_owner = RxMap(json['post_owner'] ?? {});
    post_comments = RxList(json['post_comments'] ?? []);
    likesCount = RxInt(json['likesCount'] ?? 0);
    sharesCount = RxInt(json['sharesCount'] ?? 0);
    isLiked = RxBool(json['isLiked'] ?? false);
    isShared = RxBool(json['isShared'] ?? false);
    isFollowed = RxBool(json['isFollowed'] ?? false);
  }
}
