import 'dart:developer';

import 'package:colin_hanbury_frontend/models/blog.dart';
import 'package:colin_hanbury_frontend/services/blogs_service.dart';

class BlogsRepo {
  final BlogsService blogsAPI = BlogsService();

  Future<List<Blog>> getBlogs() async {
    List<dynamic> response = await blogsAPI.getBlogs();
    List<Blog> blogs =
        response.map((jsonObject) => Blog.fromJson(jsonObject)).toList();
    log(blogs.toString());
    return blogs;
  }
}
