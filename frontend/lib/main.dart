import 'package:check_app/details_page.dart';
import 'package:flutter/material.dart';

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
              body: HomePage()),
      // )
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
  static const List<String> _options = ["Washington", "Churchill", "Kassym-Jomart Tokayev", "Clinton", "Arnold Schwarzenegger"];

  const SearchBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1200,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Autocomplete(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return _options;
              }
              return _options.where((option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
            },
            onSelected: (String selection) {
              print('You just selected $selection');
              navigateForward(context, selection);
            },
            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                // textInputAction: TextInputAction.next,
                // style: const TextStyle(color: Colors.red),
                controller: textEditingController,
                focusNode: focusNode,
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
                onChanged: (str) => print('>> changed $str'),
                onEditingComplete: () => print('>> edit complete'),
                onTap: () => print('>> tap'),
                onTapOutside: (v) {
                  print('>> tap outside');
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (String? value) {
                  if (!_options.contains(value)) {
                    return 'Nothing selected.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(backgroundColor: Colors.transparent),
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
                      final String option = options.elementAt(index);
                      return InkWell(
                        focusColor: Colors.blue,
                        onTap: () => onSelected(option),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(option),
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
