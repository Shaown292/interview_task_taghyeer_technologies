import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PostsPage extends StatefulWidget {

  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  List posts = [];

  int skip = 0;

  final scrollController = ScrollController();

  @override
  void initState() {

    super.initState();

    fetchPosts();

    scrollController.addListener(() {

      if(scrollController.position.pixels ==
          scrollController.position.maxScrollExtent){

        fetchPosts();

      }

    });
  }

  Future fetchPosts() async {

    final response = await Dio().get(
      "https://dummyjson.com/posts",
      queryParameters: {
        "limit":10,
        "skip":skip
      },
    );

    final newPosts = response.data["posts"];

    setState(() {

      posts.addAll(newPosts);

      skip += 10;

    });
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      controller: scrollController,

      itemCount: posts.length,

      itemBuilder: (context,index){

        final post = posts[index];

        return ListTile(

          title: Text(post["title"]),

          subtitle: Text(post["body"]),

        );
      },
    );
  }
}