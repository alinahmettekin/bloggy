import 'dart:io';

import 'package:bloggy/core/error/failure.dart';
import 'package:bloggy/features/blog/domain/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
  });
}
