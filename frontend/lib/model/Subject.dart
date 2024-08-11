import 'Promise.dart';

class Subject {
  final String uuid;
  final String name;
  final String surname;
  final String birthdate;
  final String countryCode;
  final String? bio;
  final List<Promise>? promises;

  const Subject({
    required this.uuid,
    required this.name,
    required this.surname,
    required this.birthdate,
    required this.countryCode,
    required this.bio,
    required this.promises,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      uuid: json['uuid'],
      name: json['name'],
      surname: json['surname'],
      birthdate: json['birthdate'],
      countryCode: json['country_code'],
      bio: json['bio'],
      promises: inferPromises(json["promises"]),
    );
  }

  static List<Promise>? inferPromises(List? jsonPromises) {
    return jsonPromises?.map((promise) => Promise.fromJson(promise)).toList();
  }

  @override
  String toString() {
    return '$name $surname, $birthdate, $countryCode';
  }
}
