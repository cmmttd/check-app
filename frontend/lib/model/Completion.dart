import 'package:check_app/model/Subject.dart';

class Completion {
  final String? input;
  final List<Subject>? options;

  const Completion({
    required this.input,
    required this.options,
  });

  factory Completion.fromJson(Map<String, dynamic> json) {
    var optionsJson = json['options'] as List;
    var options = optionsJson.map((e) => Subject.fromJson(e)).toList();
    return Completion(
      input: json['input'],
      options: options,
    );
  }

  @override
  String toString() {
    return 'Completion{input: $input, options: $options}';
  }
}
