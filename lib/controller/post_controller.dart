import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:recycle/models/post.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();

  Dio dio = Dio();
  RxList<Post> posts = <Post>[].obs;
  RxString _token = ''.obs;
  RxInt activeIndex = 0.obs;
  RxInt popupMenuIndex = 0.obs;
  RxList<Post> recommendPost = <Post>[].obs;
  RxInt selectedRecommendIndex = 0.obs;
  RxString search = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    String? accessToken = await storage.read(key: "access_token");
    if (accessToken != null) {
      _token.value = accessToken;
    }
    await getPosts();
  }

  final storage = FlutterSecureStorage();

  Future<void> postData(String post_content, List<String> post_images) async {
    try {
      Map<String, dynamic> post = {
        'post_content': post_content,
        'post_images': post_images,
      };
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/post'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
        data: post,
      );

      if (response.statusCode == 201) {
        posts.insert(0, Post.fromJson(response.data));
        Get.back();
        print('Post Success');
      } else {
        print('Post Failure');
      }
    } catch (e) {
      print('Error while posting post data is $e');
    }
  }

  Future<void> getPosts() async {
    try {
      Response response = await dio.get(
        ('${dotenv.get('SERVER')}/post'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );

      if (response.statusCode == 200) {
        posts.value =
            response.data.map<Post>((post) => Post.fromJson(post)).toList();

        print('Get Posts Success');
      } else {
        print('Get Posts Failure');
      }
    } catch (e) {
      print('Error while getting posts is $e');
    }
  }

  Future<void> getPostsBySearch() async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/post'),
      );
    } catch (e) {}
  }

  Future<void> deletePost(int postIndex) async {
    try {
      Response response = await dio.delete(
        ('${dotenv.get('SERVER')}/post/${posts[postIndex].post_id}'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );

      if (response.statusCode == 200) {
        posts.remove(posts[postIndex]);
        print('Delete Post Success');
      } else {
        print('Delete Post Failure');
      }
    } catch (e) {
      print('Error while deleting post is $e');
    }
  }

  Future<void> likePost(int postIndex) async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/like'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
        data: {'post_id': posts[postIndex].post_id.value},
      );

      if (response.statusCode == 201) {
        posts[postIndex].isLiked!.value = true;
        posts[postIndex].likesCount!.value++;
        print('Like Post Success');
      } else {
        print('Like Post Failure');
      }
    } catch (e) {
      print('Error while liking post is $e');
    }
  }

  Future<void> unlikePost(int postIndex) async {
    try {
      Response response = await dio.delete(
        ('${dotenv.get('SERVER')}/like/${posts[postIndex].post_id}'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );

      if (response.statusCode == 200) {
        posts[postIndex].isLiked!.value = false;
        posts[postIndex].likesCount!.value--;
        print('Unlike Post Success');
      } else {
        print('Unlike Post Failure');
      }
    } catch (e) {
      print('Error while unliking post is $e');
    }
  }

  Future<void> addComment(int postId, String comment) async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/comment'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
        data: {'comment_content': comment, 'post_id': postId},
      );

      if (response.statusCode == 201) {
        print(response.data);
        print(postId);
        print(posts[postId].post_comments);
        // posts[postId].post_comments!.add(Comment.fromJson(response.data));
        print('Post Comment Success');
      } else {
        print('Post Comment Failure');
      }
    } catch (e) {
      print('Error while posting comment is $e');
    }
  }

  Future<String> uploadImage(Image image) async {
    return 'url';
  }

  // Future<void> deleteComment(int postId, int commentIndex) async {
  //   try {
  //     Response response = await dio.delete(
  //       ('${dotenv.get('SERVER')}/comment/${posts[postId].post_comments![commentIndex]['comment_id']}'),
  //       options: Options(
  //         contentType: Headers.jsonContentType,
  //         headers: {'Authorization': 'Bearer ${_token.value}'},
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       posts[postId].post_comments!.removeAt(commentIndex);
  //       print('Delete Comment Success');
  //     } else {
  //       print('Delete Comment Failure');
  //     }
  //   } catch (e) {
  //     print('Error while deleting comment is $e');
  //   }
  // }

  // 추천 포스트 받아오는 로직 작성 예정.
}
