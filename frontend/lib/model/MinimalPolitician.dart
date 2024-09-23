class MinimalPolitician {
  final String uuid;
  final String name;

  const MinimalPolitician({
    required this.uuid,
    required this.name,
  });

  factory MinimalPolitician.fromJson(Map<String, dynamic> json) {
    return MinimalPolitician(
      uuid: json['uuid'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return '$uuid $name';
  }
}
