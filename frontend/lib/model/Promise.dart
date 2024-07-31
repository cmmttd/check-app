class Promise {
  final String date;
  final String title;
  final String description;
  final bool isFulfilled;

  Promise({required this.date, required this.title, required this.description, required this.isFulfilled});

  factory Promise.fromJson(Map<String, dynamic> json) {
    return Promise(
      date: json['date'],
      title: json['title'],
      description: json['description'],
      isFulfilled: json['is_fulfilled'],
    );
  }

  @override
  String toString() {
    return '$date $title';
  }
}
