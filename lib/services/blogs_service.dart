import 'package:colin_hanbury_frontend/models/blog.dart';
import 'package:colin_hanbury_frontend/models/like.dart';
import 'package:dio/dio.dart';

class BlogsService {
  final dio = Dio();
  final baseURL = 'http://localhost:5050';

  Future<dynamic> getBlog(String name) async {
    Response response = await dio.get('$baseURL/blogs?$name');
    return response.data;
  }

  Future<dynamic> getBlogs() async {
    Response response = await dio.get('$baseURL/blogs');
    return response.data;
  }

  Future<dynamic> addLikeToBlog(Blog blog, Like like) async {
    Response response = await dio.post('$baseURL/blogs', data: {
      'blogId': blog.id,
      'like': {
        'authorId': like.likerId,
      }
    });
    return response;
  }
}
