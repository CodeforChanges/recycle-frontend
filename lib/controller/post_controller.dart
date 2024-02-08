import 'package:dio/dio.dart';
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
      print(post);
      Response response = await dio.post(
        ('${dotenv.get('SERVER')}/post'),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Authorization': 'Bearer ${_token.value}'},
        ),
        data: post,
      );

      print(response.data);
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
        ('${dotenv.get('SERVER')}/post'), //! 쿼리 바꿔야 함
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
        posts.removeWhere((post) => post.post_id == response.data);
        print('Delete Post Success');
      } else {
        print('Delete Post Failure');
      }
    } catch (e) {
      print('Error while deleting post is $e');
    }
  }
}
