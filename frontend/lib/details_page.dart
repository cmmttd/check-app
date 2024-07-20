import 'dart:convert';

import 'package:check_app/interaction/title_text_button.dart';
import 'package:check_app/model/Promise.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/Subject.dart';

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
                    colors: [Colors.blue.shade700, Colors.purple.shade100], begin: Alignment.topRight, end: Alignment.bottomLeft))),
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

class Ex1CheckWidget extends StatefulWidget {
  double _progress = 0;
  late double count;

  Ex1CheckWidget({super.key});

  @override
  State<Ex1CheckWidget> createState() => _Ex1CheckWidgetState();
}

class _Ex1CheckWidgetState extends State<Ex1CheckWidget> {
  void done() {
    setState(() {
      widget._progress += widget.count;
    });
  }

  void undone() {
    setState(() {
      widget._progress -= widget.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pointsList = [
      Ex1CheckPoint(label: 'first', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'sec', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'th', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'frth', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'ffth', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'first', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'sec', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'th', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'frth', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'ffth', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'first', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'sec', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'th', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'frth', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'first', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'sec', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'th', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'frth', onDone: () => done(), onUndone: () => undone()),
      Ex1CheckPoint(label: 'last', onDone: () => done(), onUndone: () => undone()),
    ];
    widget.count = 1 / pointsList.length;

    var customScrollView = CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: PersistentHeader(
            widget: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.all(7),
                    child: LinearProgressIndicator(
                      color: Colors.blue,
                      value: widget._progress,
                      minHeight: 32.0,
                    ))),
          ),
        ),
        SliverList.builder(
          // separatorBuilder: (context, index) => const Divider(),
          itemCount: pointsList.length,
          itemBuilder: (context, index) {
            return Container(
              child: Card(
                color: Colors.blue.shade100,
                child: pointsList[index],
              ),
            );
          },
        ),
      ],
    );

    // list.addAll(pointsList);
    // list.add(customScrollView);

    // return Expanded(
    //   child: list,
    // );
    return customScrollView;
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget? widget;

  PersistentHeader({this.widget});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // width: double.infinity,
      // height: 42.0,
      child: Card(
        // margin: EdgeInsets.all(0),
        // color: Colors.white,
        // elevation: 5.0,
        child: Center(child: widget),
      ),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Ex1CheckPoint extends StatefulWidget {
  final String label;
  final void Function() onDone;
  final void Function() onUndone;

  const Ex1CheckPoint({super.key, required this.label, required this.onDone, required this.onUndone});

  @override
  State<Ex1CheckPoint> createState() => _Ex1CheckPointState();
}

class _Ex1CheckPointState extends State<Ex1CheckPoint> {
  bool? _val = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 42,
            child: Row(
              children: [
                Checkbox(
                  // checkColor: Colors.blue,
                  // focusColor: Colors.blue,
                  // hoverColor: Colors.red,
                  activeColor: Colors.blue,
                  value: _val,
                  onChanged: (value) {
                    setState(() {
                      _val = value;
                    });
                    if (value!) {
                      widget.onDone.call();
                    } else {
                      widget.onUndone.call();
                    }
                  },
                ),
                Text(widget.label)
              ],
            ))
      ],
    );
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
