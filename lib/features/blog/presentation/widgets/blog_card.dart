import 'package:bloggy/core/utils/calculate_reading_time.dart';
import 'package:bloggy/features/blog/domain/models/blog.dart';
import 'package:bloggy/features/blog/presentation/pages/blog_viewer.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.color, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, BlogViewer.route(blog)),
      child: Container(
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        padding: const EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: Chip(
                              label: Text(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
