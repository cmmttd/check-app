import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<String> data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grapes',
    'Honeydew',
    'Kiwi',
    'Lemon',
  ];

  List<String> searchResults = [];

  void onQueryChanged(String query) {
    setState(() {
      searchResults = data
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: Text('Flutter Search Bar Tutorial'),
      // ),
      body: Column(
        children: [
          CstmSearchBar(onQueryChanged),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                );
              },
            ),
          ),
          TreeWidget(),
        ],
      ),
    );
  }
}

class CstmSearchBar extends StatelessWidget {
  final Func onQueryChanged;

  const CstmSearchBar(this.onQueryChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class TreeWidget extends StatelessWidget {
  const TreeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [for (int i = 0; i < 4; i++) TreePoint(i: i)]);
    // return Text('test');
  }
}

class TreePoint extends StatelessWidget {
  const TreePoint({
    super.key,
    required this.i,
  });

  final int i;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: Colors.red,
        iconStyle: IconStyle(iconData: Icons.event, color: Colors.white),
      ),
      startChild: Text('$i Event Title'),
      beforeLineStyle: LineStyle(
        color: Colors.red,
        thickness: 5,
      ),
      afterLineStyle: LineStyle(
        color: Colors.red,
        thickness: 2,
      ),
      endChild: Container(
        margin: EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Text('$i Event Description'),
      ),
    );
  }
}

typedef Func = void Function(String s);
