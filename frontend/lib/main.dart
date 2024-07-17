import 'dart:convert';

import 'package:check_app/details_page.dart';
import 'package:check_app/model/Completion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String serverUrl = String.fromEnvironment('SERVER_URL', defaultValue: 'http://localhost:8081/mock');

void main() {
  runApp(const CheckApp());
}

class CheckApp extends StatelessWidget {
  final title = "the name";

  const CheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.light(useMaterial3: true),
      home:
          // GestureDetector(
          //   onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          //   child:
          Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blue.shade700, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight))),
                backgroundColor: Colors.blue.shade300,
                title: Text(title),
              ),
              body: const HomePage()),
      // )
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchBarCustom(),
        DescriptionCard(),
        CredentialsArea(),
      ],
    );
  }
}

class CredentialsArea extends StatelessWidget {
  const CredentialsArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("Credentials"),
            )));
  }
}

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SizedBox(
            width: 800,
            child: Align(
                alignment: Alignment.center,
                child: Card(
                  child: Padding(padding: EdgeInsets.all(50), child: Text("Description how it may be used. Choose your politician!")),
                ))));
  }
}

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1200,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Autocomplete<Completion>(
            optionsBuilder: (textEditingValue) {
              var text = textEditingValue.text;
              var requestPath = text.isEmpty ? "completions" : "completion/$text";
              return http
                  .get(Uri.parse('$serverUrl/$requestPath'))
                  .asStream()
                  .map((event) => jsonDecode(event.body)["options"])
                  .expand((element) => element.toList())
                  .map((event) => Completion.fromJson(event))
                  // .map((event) => event.toString())
                  .toList();
            },
            onSelected: (Completion selection) {
              print('>> selected $selection');
              navigateForward(context, selection.toString());
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              targetName: value,
                            )),
                  );
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
                      final Completion option = options.elementAt(index);
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
        ));
  }

  void navigateForward(BuildContext context, String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsScreen(
                targetName: value,
              )),
    );
  }
}
