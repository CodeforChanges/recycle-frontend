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
    post_owner = RxMap(json['post']['post_owner'] ?? {});
    post_comments = RxList(json['post']['post_comments'] ?? []);
    likesCount = RxInt(json['post']['likesCount'] ?? 0);
    sharesCount = RxInt(json['post']['sharesCount'] ?? 0);
    isLiked = RxBool(json['post']['isLiked'] ?? false);
  }
}
