import 'dart:convert';

import 'package:check_app/interaction/title_text_button.dart';
import 'package:check_app/model/Promise.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/Politician.dart';
import 'model/MinimalPolitician.dart';

// --dart-define=SERVER_URL=https://mock-server-2szvf52diq-uc.a.run.app/mock --web-port=56558
const String serverUrl = String.fromEnvironment('SERVER_URL', defaultValue: 'http://localhost:8081/mock');

class DetailsScreen extends StatelessWidget {
  final MinimalPolitician target;

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
          title: target.name,
        ),
        // title: Text("App bar"),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.blue.shade100,
      ),
      // body: Ex1CheckWidget(),
      body: FutureBuilder<Politician>(
        future: fetchPromises(target.uuid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final politician = snapshot.data!;
            final promises = politician.promises!;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            style: TextStyle(fontSize: 16),
                            politician.bio!,
                          ))),
                ),
                // todo: Align the promises list by center
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                    childCount: promises.length,
                    (ctx, index) {
                      var promise = promises[index];
                      return ListTile(iconColor: promise.isFulfilled ? Colors.green : Colors.red, title: CheckMarkRow(promise: promise));
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

Future<Politician> fetchPromises(String uuid) async {
  var response = await http.get(Uri.parse('$serverUrl/promises/$uuid'));
  if (response.statusCode == 200) {
    return Politician.fromJson(jsonDecode(response.body));
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
            Icon(promise.isFulfilled ? Icons.done : Icons.dangerous_outlined),
            const SizedBox(
              width: 4,
            ),
            Text(promise.date),
            const SizedBox(
              width: 4,
            ),
            Text(promise.title)
          ],
        ));
  }
}
