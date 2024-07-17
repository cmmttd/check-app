class Completion {
  final String uuid;
  final String name;
  final String surname;
  final int birthdate;
  final String countryCode;

  const Completion({required this.uuid, required this.name, required this.surname, required this.birthdate, required this.countryCode});

  factory Completion.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'uuid': String uuid,
        'name': String name,
        'surname': String surname,
        'birthdate': int birthdate,
        'countryCode': String countryCode,
      } =>
        Completion(
          uuid: uuid,
          name: name,
          surname: surname,
          birthdate: birthdate,
          countryCode: countryCode,
        ),
      _ => throw const FormatException('Failed to construct Completion'),
    };
  }

  @override
  String toString() {
    return '$name $surname, $birthdate, $countryCode';
  }
}
