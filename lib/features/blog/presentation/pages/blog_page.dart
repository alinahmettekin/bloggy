import 'package:bloggy/core/common/widgets/loader.dart';
import 'package:bloggy/core/utils/show_snackbar.dart';
import 'package:bloggy/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:bloggy/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:bloggy/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) => const BlogPage(),
    );
  }

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          if (state is BlogsDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: Colors.primaries[index % Colors.primaries.length],
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
