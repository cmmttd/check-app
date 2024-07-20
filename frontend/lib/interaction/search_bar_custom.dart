import 'dart:convert';

import 'package:check_app/model/Subject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../details_page.dart';

const String serverUrl = String.fromEnvironment('SERVER_URL', defaultValue: 'http://localhost:8081/mock');

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({super.key});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1200,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Autocomplete<Subject>(
              optionsBuilder: (textEditingValue) async {
                var text = textEditingValue.text;
                var query = text.isEmpty ? "completions" : "completion/$text";
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                try {
                  final suggestions = await fetchSuggestions(query);
                  setState(() {
                    _isLoading = false;
                  });
                  return suggestions;
                } catch (e) {
                  setState(() {
                    _isLoading = false;
                    _errorMessage = 'Failed to load suggestions';
                  });
                  return const Iterable<Subject>.empty();
                }
              },
              onSelected: (Subject selection) {
                print('>> selected $selection');
                navigateForward(context, selection);
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                return TextFormField(
                  // textInputAction: TextInputAction.next,
                  // style: const TextStyle(color: Colors.red),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onTap: () => print('>> tap'),
                  onChanged: (str) => print('>> changed $str'),
                  onEditingComplete: () => print('>> edit complete'),
                  onFieldSubmitted: (String value) {
                    print('>> submitted: $value');
                    // todo: shall to be blocked, only suggested options could be available to pick
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => DetailsScreen(
                    //             targetName: value,
                    //           )),
                    // );
                    onFieldSubmitted();
                  },
                  onTapOutside: (v) {
                    print('>> tap outside');
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  validator: (String? value) {
                    // if (!_options.contains(value)) {
                    print("nothing");
                    return 'Nothing selected.';
                    // }
                    // return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: const TextStyle(backgroundColor: Colors.transparent),
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Name or birtdate",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      alignLabelWithHint: true),
                );
              },
              optionsViewBuilder: (context, onSelected, options) => Align(
                alignment: Alignment.topLeft,
                child: Material(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(2.0)),
                  ),
                  child: Container(
                    height: 52.0 * options.length,
                    width: 1100,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      shrinkWrap: false,
                      itemBuilder: (BuildContext context, int index) {
                        final Subject option = options.elementAt(index);
                        return InkWell(
                          focusColor: Colors.blue,
                          onTap: () => onSelected(option),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(option.toString()),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading) const CircularProgressIndicator(),
          if (_errorMessage != null) Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
        ]));
  }

  Future<List<Subject>> fetchSuggestions(String query) async {
    final response = await http.get(Uri.parse('$serverUrl/$query'));
    if (response.statusCode == 200) {
      // todo: migrate to Completion data object
      List decode = json.decode(response.body)['options'];
      return decode.map((suggestion) => Subject.fromJson(suggestion)).toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  void navigateForward(BuildContext context, Subject value) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsScreen(
                target: value,
              )),
    );
  }
}
