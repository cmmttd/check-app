import 'dart:convert';

import 'package:check_app/interaction/title_text_button.dart';
import 'package:check_app/model/Promise.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/Subject.dart';

// --dart-define=SERVER_URL=https://mock-server-2szvf52diq-uc.a.run.app/mock --web-port=56558
const String serverUrl = String.fromEnvironment('SERVER_URL', defaultValue: 'http://localhost:8081/mock');

class DetailsScreen extends StatelessWidget {
  final Subject target;

  const DetailsScreen({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.purple.shade100],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ))),
        title: TitleTextButton(
          title: '${target.name} ${target.surname}',
        ),
        // title: Text("App bar"),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.blue.shade100,
      ),
      // body: Ex1CheckWidget(),
      body: FutureBuilder<List<Promise>>(
        future: fetchPromises(target.uuid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final promises = snapshot.data!;
            return ListView.builder(
              itemCount: promises.length,
              itemBuilder: (context, index) {
                final promise = promises[index];
                return ListTile(
                  title: CheckMarkRow(promise: promise),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<List<Promise>> fetchPromises(String uuid) async {
  var response = await http.get(Uri.parse('$serverUrl/promises/$uuid'));
  if (response.statusCode == 200) {
    // todo: migrate to Subject data structure parsing instead
    List jsonResponse = jsonDecode(response.body)["promises"];
    return jsonResponse.map((promise) => Promise.fromJson(promise)).toList();
  } else {
    throw Exception('Failed to load entities');
  }
}

class CheckMarkRow extends StatelessWidget {
  final Promise promise;

  const CheckMarkRow({super.key, required this.promise});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 42,
        child: Row(
          children: [
            Checkbox(
              // checkColor: Colors.blue,
              // focusColor: Colors.blue,
              // hoverColor: Colors.red,
              activeColor: Colors.blue,
              value: promise.isFulfilled,
              onChanged: (bool? value) {},
            ),
            Text(promise.toString())
          ],
        ));
  }
}
