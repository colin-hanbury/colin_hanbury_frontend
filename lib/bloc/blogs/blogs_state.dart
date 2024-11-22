import 'package:colin_hanbury_frontend/models/blog.dart';
import 'package:equatable/equatable.dart';

enum BlogsStatus {
  initial,
  successful,
  loading,
  error,
}

class BlogsState extends Equatable {
  final List<Blog> blogs;
  final BlogsStatus status;

  BlogsState({
    this.status = BlogsStatus.initial,
    List<Blog>? blogs,
  }) : blogs = blogs ?? const [];

  @override
  List<Object?> get props => [status, blogs];

  BlogsState copyWith({
    List<Blog>? blogs,
    BlogsStatus? status,
  }) =>
      BlogsState(blogs: blogs ?? this.blogs, status: status ?? this.status);
}
