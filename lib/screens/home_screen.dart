import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/components/post.dart';
import 'package:recycle/controller/post_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textField(),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: PostController.to.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed('/post', arguments: index);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Post(postIndex: index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: addPostBtn(),
    );
  }

  AppBar renderAppBar() => AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
      );

  FloatingActionButton addPostBtn() => FloatingActionButton.extended(
        backgroundColor: Color(0xff008000),
        onPressed: () {
          Get.toNamed('/write');
        },
        label: Text(
          '글쓰기',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 16.0,
        ),
      );

  Widget textField() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: TextField(
          onChanged: (value) => {PostController.to.getPostsBySearch(value)},
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: '원하는 재활용 꿀팁을 검색해보세요',
              prefixIconColor: Color(0xff008000),
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff008000), width: 2),
                  borderRadius: BorderRadius.circular(20)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff008000), width: 1),
                  borderRadius: BorderRadius.circular(20))),
        ),
      );
}
