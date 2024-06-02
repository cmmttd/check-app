import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parallax_animation/parallax_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search and Timeline App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final Future<String> json;

  @override
  void initState() {
    super.initState();
    json = obtainJson();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      FutureBuilder<String>(
        future: json,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ));
          } else if (snapshot.hasError) {
            return Text('Err: ${snapshot}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            color: Colors.blue,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Welcome to the <> portal. Scroll down and check your politician",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            )),
      ),
      Text("last",
          style: TextStyle(
            color: Colors.red,
            fontSize: 40,
            fontWeight: FontWeight.w900,
          )),
    ];

    final colors = [Colors.amber, Colors.lightGreen, Colors.blueGrey];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('App logo'),
        centerTitle: true,
      ),
      body: ParallaxArea(
        child: PageView.builder(
            itemCount: 3,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ParallaxWidget(
                overflowWidthFactor: 1,
                background: ColoredBox(
                  color: colors[index],
                ),
                child: Center(
                  child: list[index],
                ),
              );
            }),
      ),
    );
  }
}

Future<String> obtainJson() async {
  var response = await http.get(Uri.parse('http://localhost:8080/mock/promises/1'));
  // var response = await http.get(Uri.parse('https://google.com'));
  print('Resp: ${response.statusCode}');
  if (response.statusCode == 200) {
    print('Resp: ${response.body}');
    // return Promises.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    // return jsonDecode(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load album');
  }
}

class Promises {
  final int politician_id;

  // final List<Promise> promises;

  const Promises({
    required this.politician_id,
    // required this.promises,
  });

  factory Promises.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'politician_id': int politician_id,
        // 'promises': List<Promise> promises,
      } =>
        Promises(
          politician_id: politician_id,
          // promises: promises,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class Promise {
  final int timestamp;
  final String promise_name;
  final String description;

  Promise({required this.timestamp, required this.promise_name, required this.description});
}
