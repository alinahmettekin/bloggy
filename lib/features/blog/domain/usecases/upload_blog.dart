import 'dart:io';

import 'package:bloggy/core/error/failure.dart';
import 'package:bloggy/core/usecase/use_case.dart';
import 'package:bloggy/features/blog/domain/models/blog.dart';
import 'package:bloggy/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      posterId: params.posterId,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final List<String> topics;
  final String posterId;

  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.posterId,
  });
}
