import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text('Hi, guide will be here'),
          SizedBox(height: 10),
          Spacer(flex: 2),
          TreeWidget()
        ],
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
    return
        // ListView.builder(
        // itemCount: 2,
        // itemBuilder: (context, index) {
        //   return
        Column(children: [
      for (int i = 0; i < 3; i++)
        TimelineTile(
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
          //   );
          // },
        )
    ]);
  }
}
