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
      searchResults = data.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
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
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: searchResults.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(searchResults[index]),
          //       );
          //     },
          //   ),
          // ),
          // TreeWidget(),
        ],
      ),
    );
  }
}

class CstmSearchBar extends StatelessWidget {
  final Func onQueryChanged;

  const CstmSearchBar(this.onQueryChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: const InputDecoration(
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
        // children: [for (int i = 0; i < 4; i++) TreePoint(i: i)]
        children: [
          // AnimatedList.builder(
          ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return TreePoint(i: index);
              })
        ]);
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

// class TimelineTile extends StatelessWidget {
//   final Map<String, String> event;
//
//   TimelineTile({required this.event});
//
//   @override
//   Widget build(BuildContext context) {
//     bool isLargeScreen = MediaQuery.of(context).size.width > 600;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               Container(
//                 width: 2,
//                 height: 20,
//                 color: Colors.grey,
//               ),
//               Container(
//                 width: 10,
//                 height: 10,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue,
//                 ),
//               ),
//               Container(
//                 width: 2,
//                 height: 20,
//                 color: Colors.grey,
//               ),
//             ],
//           ),
//           SizedBox(width: 16),
//           Text(event['timestamp']!, style: TextStyle(color: Colors.grey)),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   event['title']!,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 if (!isLargeScreen) Text(event['description']!),
//               ],
//             ),
//           ),
//           if (isLargeScreen)
//             Flexible(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(event['description']!),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
