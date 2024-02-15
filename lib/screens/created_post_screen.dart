import 'package:flutter/material.dart';
import 'package:recycle/components/post.dart';
import 'package:recycle/controller/auth_service.dart';
import 'package:recycle/controller/post_controller.dart';

class CreatedPostScreen extends StatefulWidget {
  const CreatedPostScreen({super.key});

  @override
  State<CreatedPostScreen> createState() => _CreatedPostScreenState();
}

class _CreatedPostScreenState extends State<CreatedPostScreen> {
  int page = 1;
  bool isLoading = false;

  final ScrollController _scrollController = ScrollController();

  Future<void> getMyPosts() async {
    try {
      final user_id = await AuthService.to.getCurrentUserId();
      await PostController.to.getPosts(owner_id: user_id, page: 0);
    } catch (e) {
      print('Error while getting my posts is $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() async {
      if (isLoading) {
        return;
      }

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        final user_id = await AuthService.to.getCurrentUserId();
        final result =
            await PostController.to.getPosts(page: page, owner_id: user_id);

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
    return Scaffold(
      appBar: renderAppBar(),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getMyPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: PostController.to.posts.length,
                itemBuilder: (context, index) {
                  return Post(
                    postIndex: index,
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }

  AppBar renderAppBar() => AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        title: const Text('내가 쓴 글'),
      );
}
