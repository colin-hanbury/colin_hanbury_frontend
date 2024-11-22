import 'package:colin_hanbury_frontend/models/like.dart';

class Blog {
  final String? id;
  final String? title;
  final DateTime? date;
  final String? url;
  final List<Like>? likes;

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      date: DateTime.tryParse(json['date']),
      url: json['url'],
    );
  }

  Blog({
    this.id,
    this.title,
    this.date,
    this.url,
    this.likes,
  });
}
