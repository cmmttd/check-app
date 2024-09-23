import 'package:check_app/model/Politician.dart';

class Completion {
  final String? input;
  final List<Politician>? options;

  const Completion({
    required this.input,
    required this.options,
  });

  factory Completion.fromJson(Map<String, dynamic> json) {
    var optionsJson = json['completions'] as List;
    var options = optionsJson.map((e) => Politician.fromJson(e)).toList();
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
