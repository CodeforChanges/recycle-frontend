import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/components/post.dart';
import 'package:recycle/controller/post_controller.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int postIndex = Get.arguments;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Container(
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        child: Post(postIndex: postIndex),
                      ),
                      Obx(
                        () => Column(
                          children: [
                            PostController.to.posts[postIndex].post_comments !=
                                    null
                                ? Column(
                                    children: List.generate(
                                      PostController.to.posts[postIndex]
                                          .post_comments!.length,
                                      (index) => commentWidget(
                                        PostController
                                            .to
                                            .posts[postIndex]
                                            .post_comments?[index]
                                            .comment_id
                                            .value,
                                        PostController
                                            .to
                                            .posts[postIndex]
                                            .post_comments?[index]
                                            .comment_owner
                                            .value
                                            .user_nickname,
                                        PostController
                                            .to
                                            .posts[postIndex]
                                            .post_comments?[index]
                                            .comment_content
                                            .value,
                                        PostController
                                            .to
                                            .posts[postIndex]
                                            .post_comments?[index]
                                            .comment_owner
                                            .value
                                            .user_image,
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 12, 16, 12),
                                        child: Text('댓글이 없습니다.'),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomCommentWidgets(),
            ],
          )),
    );
  }

  AppBar renderAppBar() => AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
      );

  Widget bottomCommentWidgets() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_box_outlined,
                  size: 28,
                  color: Colors.grey[700],
                )),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    hintText: '댓글을 입력하세요',
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await PostController.to
                      .addComment(postIndex, commentController.text);
                  commentController.clear();
                  PostController.to.update();
                },
                icon: Icon(
                  Icons.send,
                  size: 28,
                  color: Colors.grey[700],
                )),
          ],
        ),
      );

  Widget commentWidget(
    int? comment_id,
    String? user_name,
    String? comment_content,
    String? user_image,
  ) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('댓글 삭제'),
                  content: Text('댓글을 삭제하시겠습니까?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('취소')),
                    TextButton(
                        onPressed: () async {
                          await PostController.to
                              .deleteComment(comment_id, postIndex);
                          Navigator.pop(context);
                        },
                        child: Text(
                          '삭제',
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                ));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (user_image == null || user_image == '')
                      ? CircleAvatar(
                          // ! Colors.brown으로 된 부분을 기본 이미지로 변경 예정.
                          backgroundColor: Colors.brown.shade800,
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            user_image,
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              null,
                        ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            user_name == null ? 'error' : user_name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          comment_content == null ? 'error' : comment_content,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('2024.02.03',
                  style: TextStyle(color: Colors.grey, fontSize: 10)),
            )
          ],
        ),
      ),
    );
  }
}
