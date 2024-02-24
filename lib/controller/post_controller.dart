import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:recycle/models/comment.dart';
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
    try {
      super.onInit();
      String? accessToken = await storage.read(key: "access_token");
      if (accessToken != null) {
        _token.value = accessToken;
      }
      await getPosts(page: 0);
    } catch (e) {
      print("Error during onInit: $e");
    }
  }

  Future<void> initPostToken() async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken != null) {
        _token.value = accessToken;
        return;
      }
      Get.offAllNamed('/signin');
      print('No token available');
    } catch (e) {
      print('Error during initPostToken: $e');
    }
  }

  final storage = FlutterSecureStorage();

  Future<void> postData(String post_content, List<String> post_images,
      List<String> tagList) async {
    print('tagList: $tagList');
    try {
      Map<String, dynamic> post = {
        'post_content': post_content,
        'post_images': post_images,
        'post_tags': tagList,
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
        final newPost = Post.fromJson(response.data);
        print(newPost);
        posts.insert(0, newPost);
        print('Post Success');
      } else {
        print('Post Failure');
      }
    } catch (e) {
      print('Error while posting post data is $e');
    }
  }

  Future<bool?> getPosts({int? owner_id, int page = 0}) async {
    try {
      String ownerQuery = owner_id != null ? 'owner=$owner_id' : '';
      String pageQuery = 'page=$page';
      Response response = await dio.get(
        ('${dotenv.get('SERVER')}/post?$ownerQuery$pageQuery'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );

      if (response.statusCode != 200) {
        print('Get Posts Failure');
        return null;
      }

      if (response.data.length == 0) {
        print('Get Posts Success');
        return false;
      }

      posts.addAll(response.data
          .map<Post>((post) => Post.fromJson(post['post']))
          .toList());
      print('Get Posts Success');
      return true;
    } catch (e) {
      print('Error while getting posts is $e');
      return null;
    }
  }

  Future<void> getPostsBySearch(String keyword) async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/search'),
        data: {"keyword": keyword},
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );
      if (response.statusCode == 201) {
        print('response from search api: ${response.data}');
        posts.clear();
        posts.addAll(response.data
            .map<Post>((post) => Post.fromJson(post['post']))
            .toList());
        return;
      }
      print("get post not successful");
    } catch (e) {
      print('get post has an error');
      print(e);
    }
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

  Future<bool> updatePost(
      int? post_id, String post_content, List<String> post_images) async {
    if (post_id == null) return false;
    try {
      Map<String, dynamic> post = {
        'post_content': post_content,
        'post_images': post_images,
        'post_tags': [],
      };
      Response response = await dio.patch(
        ('${dotenv.get('SERVER')}/post/$post_id'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
        data: post,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        print('Update Post Success');
        return true;
      }
      print('Update Post Failure');
      return false;
    } catch (e) {
      print('Error while updating post is $e');
      return false;
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

  Future<void> addComment(int postIndex, String comment) async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/comment'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
        data: {
          'comment_content': comment,
          'post_id': posts[postIndex].post_id.value,
        },
      );

      if (response.statusCode == 201) {
        if (response.data != null) {
          posts[postIndex]
              .post_comments
              ?.insert(0, Comment.fromJson(response.data));
        }
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

  Future<bool> deleteComment(int? comment_id, int? postIndex) async {
    try {
      if (comment_id == null || postIndex == null) return false;
      Response response = await dio.delete(
        ('${dotenv.get('SERVER')}/comment/${comment_id}'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );

      if (response.statusCode == 200) {
        posts[postIndex]
            .post_comments!
            .removeWhere((element) => element.comment_id.value == comment_id);
        print('Delete Comment Success');
        return true;
      }
      print('Delete Comment Failure');
      return false;
    } catch (e) {
      print('Error while deleting comment is $e');
      return false;
    }
  }

  // 추천 포스트 받아오는 로직 작성 예정.
  Future<int> getTrashId(String imageUrl) async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/ai/garbage'),
        data: {
          'imageUrl': imageUrl,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );
      return response.data['id'];
    } catch (e) {
      print('Error while getting trash id is $e');
      return -1;
    }
  }

  Future<String> getTrashKind(int trashId) async {
    try {
      sleep(Duration(seconds: 5));
      Response response = await dio.get(
        ('${dotenv.get('SERVER')}/ai/garbage/$trashId'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['result']['label'];
      }
      return await this.getTrashKind(trashId);
    } catch (e) {
      return await this.getTrashKind(trashId);
    }
  }

  Future<void> getRecommendPosts(String type) async {
    try {
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/search'),
        data: {"keyword": type},
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
      );
      if (response.statusCode == 201) {
        recommendPost.clear();
        recommendPost.addAll(response.data
            .map<Post>((post) => Post.fromJson(post['post']))
            .toList());
        print('recommendPost: $recommendPost');
        return;
      }
    } catch (e) {
      print('Error while getting recommend posts is $e');
    }
  }
}
