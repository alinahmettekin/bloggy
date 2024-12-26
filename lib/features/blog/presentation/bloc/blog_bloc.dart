import 'dart:io';

import 'package:bloggy/core/usecase/use_case.dart';
import 'package:bloggy/features/blog/domain/models/blog.dart';
import 'package:bloggy/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloggy/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>((event, emit) => _onBlogUpload(event, emit));
    on<BlogFetchAllBlogs>((event, emit) => _onGetAllBlogs(event, emit));
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        topics: event.topics,
        posterId: event.posterId,
      ),
    );

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogsDisplaySuccess(blogs)),
    );
  }
}
