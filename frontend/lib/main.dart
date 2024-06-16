import 'package:first_dart/details_page.dart';
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
        home: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              appBar: AppBar(
                title: Text(title),
                backgroundColor: Colors.blue.shade300,
              ),
              body: HomePage()),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchBar(),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: SizedBox(
                width: 800,
                child: Align(
                    alignment: Alignment.center,
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Text(
                              "Description how it may be used. Description how it may be used. Description how it may be used. Description how it may be used.")),
                    )))),
        Expanded(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Credentials"),
                ))),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1200,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (str) => print('>> changed $str'),
            onEditingComplete: () => print('>> edit complete'),
            onSubmitted: (str) {
              print('>> submitted $str');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsScreen()),
              );
            },
            onTap: () => print('>> tap'),
            onTapOutside: (v) => print('>> tap outside'),
            // enableInteractiveSelection: true,
            // textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(backgroundColor: Colors.transparent),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                prefixIcon: const Icon(Icons.search),
                hintText: "Name or birtdate",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                alignLabelWithHint: true),
          ),
        ));
  }
}
