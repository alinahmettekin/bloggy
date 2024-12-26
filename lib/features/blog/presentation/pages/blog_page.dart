import 'package:bloggy/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) => const BlogPage(),
    );
  }

  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bloggy'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () {
              Navigator.of(context).push(
                AddNewBlogPage.route(),
              );
            },
          ),
        ],
      ),
    );
  }
}
