import 'package:check_app/interaction/search_bar_custom.dart';
import 'package:check_app/interaction/title_text_button.dart';
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
      home: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.purple.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight))),
            backgroundColor: Colors.blue.shade300,
            title: TitleTextButton(title: title),
          ),
          body: const HomePage()),
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
