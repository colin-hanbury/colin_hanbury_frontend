class Blog {
  final String? name;
  final DateTime? date;

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(name: json['name'], date: DateTime.tryParse(json['date']));
  }

  Blog({
    this.name,
    this.date,
  });
}
