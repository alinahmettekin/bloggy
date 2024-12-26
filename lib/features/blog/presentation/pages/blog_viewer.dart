import 'package:bloggy/core/theme/app_pallete.dart';
import 'package:bloggy/core/utils/calculate_reading_time.dart';
import 'package:bloggy/core/utils/format_date.dart';
import 'package:bloggy/features/blog/domain/models/blog.dart';
import 'package:flutter/material.dart';

class BlogViewer extends StatelessWidget {
  final Blog blog;
  static route(Blog blog) {
    return MaterialPageRoute(
      builder: (context) => BlogViewer(blog: blog),
    );
  }

  const BlogViewer({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'By ${blog.posterName}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${formateDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min read',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  blog.content,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
