import 'package:check_app/main.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(Ex1App());
// }
//
// class Ex1App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Ex1 App",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(useMaterial3: true),
//       home: DetailsScreen(),
//     );
//   }
// }

class DetailsScreen extends StatelessWidget {
  final String targetName;

  DetailsScreen({super.key, required this.targetName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.purple.shade100], begin: Alignment.topRight, end: Alignment.bottomLeft))),
        title: IconButton(
          icon: Icon(Icons.account_balance),
          onPressed: () {
            print('abc');
            // Navigator.pop(context);
          },
        ),
        // title: Text("App bar"),
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.blue.shade100,
      ),
      body: Ex1CheckWidget(
        targetName: targetName,
      ),
    );
  }
}

class Ex1CheckWidget extends StatefulWidget {
  final String targetName;
  double _progress = 0;
  late double count;

  Ex1CheckWidget({super.key, required this.targetName});

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
    var list = [
      Text("Some progress: for ${widget.targetName}"),
      // Expanded(
      //     child: LinearProgressIndicator(
      //       value: widget._progress,
      //       minHeight: 1.0,
      //     )),
      Padding(
          // padding: EdgeInsets.all(2),
          padding: EdgeInsets.fromLTRB(4, 2, 4, 0),
          child: LinearProgressIndicator(
            color: Colors.blue,
            value: widget._progress,
            minHeight: 6.0,
          )),
    ];

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
          delegate: PersistentHeader(
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: list,
            ),
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
