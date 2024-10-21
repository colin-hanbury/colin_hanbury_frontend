class Associate {
  final String? name;
  final DateTime? date;

  factory Associate.fromJson(Map<String, dynamic> json) {
    return Associate(name: json['name'], date: DateTime.tryParse(json['date']));
  }

  Associate({
    this.name,
    this.date,
  });
}
