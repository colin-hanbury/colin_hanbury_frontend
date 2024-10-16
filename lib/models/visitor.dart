class Visitor {
  String? name;
  DateTime? date;
  Visitor(this.name, this.date);

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(json['name'], DateTime.tryParse(json['date']));
  }
}
