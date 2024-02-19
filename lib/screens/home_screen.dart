import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/components/post.dart';
import 'package:recycle/controller/post_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool inSearch = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() async {
      if (isLoading) {
        return;
      }

      if (inSearch) {
        return;
      }

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        final result = await PostController.to.getPosts(page: page);

        if (result != null) {
          if (result) {
            setState(() {
              isLoading = false;
              page++;
            });
            return;
          }
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PostController.to.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: renderAppBar(),
            body: loadingSkeleton(),
            floatingActionButton: addPostBtn(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: renderAppBar(),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
            floatingActionButton: addPostBtn(),
          );
        } else {
          return GestureDetector(
            onTap: () {
              _focusNode.unfocus();
            },
            child: Scaffold(
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
                          controller: _scrollController,
                          itemCount: PostController.to.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed('/post', arguments: index);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    isLoading
                        ? loadingSkeleton()
                        : Container(
                            height: 0,
                          ),
                  ],
                ),
              ),
              floatingActionButton: addPostBtn(),
            ),
          );
        }
      },
    );
  }

  Container loadingSkeleton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
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
          focusNode: _focusNode,
          onChanged: (value) async {
            if (value.isNotEmpty) {
              setState(() {
                inSearch = true;
              });
              PostController.to.getPostsBySearch(value);
            } else {
              setState(() {
                page = 1;
                inSearch = false;
                PostController.to.posts.clear();
                PostController.to.getPosts(page: 0);
              });
            }
          },
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
