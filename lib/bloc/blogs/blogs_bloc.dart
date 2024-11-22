import 'dart:developer';

import 'package:colin_hanbury_frontend/bloc/blogs/blogs_event.dart';
import 'package:colin_hanbury_frontend/bloc/blogs/blogs_state.dart';
import 'package:colin_hanbury_frontend/repositories/blogs_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsBLoC extends Bloc<BlogsEvent, BlogsState> {
  BlogsBLoC({required this.blogsRepo}) : super(BlogsState()) {
    on<LoadBlogs>(loadBlogs);
  }

  final BlogsRepo blogsRepo;

  void loadBlogs(LoadBlogs event, Emitter<BlogsState> emitter) async {
    emitter(state.copyWith(status: BlogsStatus.loading));
    try {
      final blogs = await blogsRepo.getBlogs();
      log(blogs.toString());
      emitter(state.copyWith(blogs: blogs, status: BlogsStatus.successful));
    } catch (e) {
      emitter(state.copyWith(status: BlogsStatus.error));
    }
  }
}
