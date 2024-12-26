import 'dart:io';

import 'package:bloggy/core/error/exceptions.dart';
import 'package:bloggy/core/error/failure.dart';
import 'package:bloggy/core/network/connection_checker.dart';
import 'package:bloggy/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:bloggy/features/blog/data/models/blog_model.dart';
import 'package:bloggy/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:bloggy/features/blog/domain/models/blog.dart';
import 'package:bloggy/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure('No internet connection'));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlogs(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
